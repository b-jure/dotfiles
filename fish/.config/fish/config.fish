if status is-interactive
    if command -a keychain >/dev/null
        keychain --quiet $SSH_KEYS
    end
end

# Override slow command-not-found handler
function fish_command_not_found
    echo "fish: Unknown command '$argv'" >&2
end

# Override exit to automatically 'disown'
function exit
    jobs -q; and disown (jobs -p)
    builtin exit
end

abbr -a se sudoedit

# Check if keychain is in path
if command -a keychain >/dev/null
    begin
        set HOSTNAME (hostname)
        if test -f "$HOME/.keychain/$HOSTNAME-fish"
            source "$HOME/.keychain/$HOSTNAME-fish"
        end
    end
end

# Debugger
if command -a gf2 >/dev/null
    abbr -a dbg gf2
end

# Requires 'xclip'
if command -v xclip >/dev/null
    abbr -a xp xclip -selection cliboard -o
    abbr -a xc xclip -selection clipboard
end

# Requires eza installed
if command -v eza >/dev/null
    abbr -a l eza
    abbr -a ls eza -a
    abbr -a lsd eza -aD
    abbr -a lsa eza -al
    abbr -a tree eza -T
    abbr -a treeg eza -T --git-ignore
    abbr -a lsg eza -al --git-ignore
end

# Requires git
if command -v git >/dev/null
    abbr -a g git
    abbr -a gs git status
    abbr -a ga git add
    abbr -a gc git commit
    abbr -a gp git push
    abbr -a ge git config --global --edit
    abbr -a gd git difftool
    abbr -a gdl git difftool HEAD^ HEAD
end

# Requires python3
if command -v python3 >/dev/null
    abbr -a py python3
end

# Config file for fish
if command -v fish >/dev/null
    abbr -a fcf $EDITOR "$HOME/.config/fish/config.fish"
end

# Requires 'neovim'
if command -v nvim >/dev/null
    # set vimrc path
    setenv MYVIMRC "$HOME/.config/nvim/init.lua"

    if test -n "$NVIM_LISTEN_ADDRESS"
      set -x MANPAGER "/usr/local/bin/nvr -c 'Man!' -o -"
    end

    setenv EDITOR nvim
    abbr -a e $EDITOR
    abbr -a vim $EDITOR
    abbr -a vedit $EDITOR "$HOME/.config/nvim"
end

# Config file for polybar
if command -v polybar >/dev/null
    abbr -a pedit $EDITOR "$HOME/.config/polybar/config.ini"
end

# Config file for tmux
if command -v tmux >/dev/null
    abbr -a tedit $EDITOR "$HOME/.config/tmux/tmux.conf"
end

# Config file for alacritty
if command -v alacritty >/dev/null
    abbr -a acf $EDITOR "$HOME/.config/alacritty/alacritty.yml"
end

# Nice to have
abbr --add dotdot --regex '^\.\.+$' --function multicd

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m' # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m' # begin bold
setenv LESS_TERMCAP_me \e'[0m' # end mode
setenv LESS_TERMCAP_se \e'[0m' # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m' # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m' # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# set SHELL env var
setenv SHELL /usr/bin/fish

# Use vi key bindings inside fish shell
fish_vi_key_bindings
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block


# INSERT MODE
bind -M insert -m default \ck forward-char -m insert


# DEFAULT MODE
# Movement j,k,l,;
bind -M default j backward-char
bind -M default \; forward-char
bind -M default k down-or-search
bind -M default l up-or-search


# VISUAL MODE
# Movement j,k,l,;
bind -M visual j backward-char
bind -M visual \; forward-char
bind -M visual k down-or-search
bind -M visual l up-or-search


# Fish git prompt
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showdirtystate yes

# Requires fzf and fd
if command -v fzf >/dev/null
    if command -v fd >/dev/null
        setenv FZF_DEFAULT_COMMAND "command fd --type directory --hidden --exclude '.git' ."
        setenv FZF_DEFAULT_OPTS "--layout=reverse --inline-info --height 20%
--bind=ctrl-k:down,ctrl-l:up"
        setenv FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
        setenv FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND
        fzf_key_bindings
    end
end

# THEME COLORS
# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection


# Requires cargo
if command -v cargo >/dev/null
    mkdir -p "$HOME/.cargo/bin"
    set -g CARGO_BIN "$HOME/.cargo/bin"
    # Requires starship (prompt theme)
    # You want to build the starship with rustc and
    # then move the binary file into $CARGO_BIN
    if command -v $CARGO_BIN/starship >/dev/null
        setenv STARSHIP_CONFIG "$HOME/.config/fish/prompt/starship/starship.toml"
        abbr -a scf $EDITOR $STARSHIP_CONFIG
        $CARGO_BIN/starship init fish | source
    end
end


# Make ctrl act as escape on short press
# Note: my CapsLock is mapped as Ctrl
if not pgrep xcape >/dev/null
    xcape -t 200 -e 'Control_L=Escape'
end


# Requires GNU stow
if command -v stow >/dev/null
    set DOTFILES "$HOME/dotfiles"
    abbr -a fcf $EDITOR "$DOTFILES/fish/.config/fish/config.fish"
    abbr -a acf $EDITOR "$DOTFILES/alacritty/.config/alacritty/alacritty.yml"
    abbr -a scf $EDITOR "$DOTFILES/fish/.config/fish/prompt/starship/starship.toml"
    abbr -a vedit $EDITOR "$DOTFILES/nvim/.config/nvim"
    abbr -a tedit $EDITOR "$DOTFILES/tmux/.config/tmux/tmux.conf"
    abbr -a pedit $EDITOR "$DOTFILES/polybar/.config/polybar/config.ini"
end


# personal stuff
fish_add_path -a "$HOME/.config/scripts"
set MUSIC "$HOME/.config/personal/music"
abbr -a music $EDITOR "$MUSIC"
