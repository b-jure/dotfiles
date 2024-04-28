# Override slow command-not-found handler
function fish_command_not_found
    echo "fish: Unknown command '$argv'" >&2
end

# no greeting
function fish_greeting 
end

# set SHELL env var
setenv SHELL /usr/bin/fish

# Override exit to automatically 'disown'
function exit
    jobs -q; and disown (jobs -p)
    builtin exit
end

abbr -a se sudoedit

# Check if keychain is in path
if command -v keychain >/dev/null
    begin
        set HOSTNAME (hostname)
        if test -f "$HOME/.keychain/$HOSTNAME-fish"
            source "$HOME/.keychain/$HOSTNAME-fish"
        end
    end
end

if command -v sloccount >/dev/null
	abbr -a loc sloccount
end

# Notification server
if command -v dunst >/dev/null
	abbr -a dunstrc $EDITOR "$HOME/.config/dunst/dunstrc"
end

# Debugger
if command -v gf2 >/dev/null
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
    abbr -a lsd eza -alD
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
    abbr -a gco git checkout
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
    setenv MANPAGER "nvim +Man!"
    abbr -a e $EDITOR
    abbr -a vim $EDITOR
    abbr -a vimrc "$EDITOR $HOME/.config/nvim"
end

# requires wezterm
if command -v wezterm >/dev/null
	abbr -a wcf "$EDITOR $HOME/.config/wezterm/wezterm.lua"
end

# requires vifm
if command -v vifm >/dev/null
	abbr -a vfrc "$EDITOR $HOME/.config/vifm/vifmrc"

	# change shell directory when leaving vifm
	function vicd --argument-names 'startdir'
		if ! test -n "$startdir" >/dev/null
			set startdir (pwd)
		end
		set dst "$(command vifm "$startdir" --choose-dir - $argv[2..-1])"
	    	if [ -z "$dst" ]; return 1; end
	    	cd "$dst"
	end

	abbr -a vf vicd
	abbr -a vimrc vicd "$HOME/.config/nvim"
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
    abbr -a acf $EDITOR "$HOME/.config/alacritty/alacritty.toml"
end

# Nice to have
abbr --add dotdot --regex '^\.\.+$' --function multicd

# Requires fzf and fd
if command -v fzf and command -v fd >/dev/null
	setenv FZF_DEFAULT_COMMAND "command locate /"
	setenv FZF_DEFAULT_OPTS "--layout=reverse --inline-info --height 30% --bind=ctrl-n:down,ctrl-p:up"
	setenv FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
	setenv FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND
	fzf_key_bindings
end

# if using X
if test -z "$WAYLAND_DISPLAY" &>/dev/null
    abbr -a xinit sudoedit /etc/X11/xinit/xinitrc
end

# Requires cargo
if command -v cargo >/dev/null
    if command -v starship >/dev/null
        setenv STARSHIP_CONFIG "$HOME/.config/fish/prompt/starship/starship.toml"
        abbr -a scf "$EDITOR $STARSHIP_CONFIG"
        starship init fish | source
    end
end

# download youtube video/audio
if command -v yt-dlp >/dev/null
	abbr -a ytd yt-dlp
end

# pdf viewer
if command -v zathura >/dev/null
	abbr -a zrc $EDITOR "$HOME/.config/zathura/zathurarc"
end

# compositor
if command -v picom >/dev/null
	abbr -a pcf sudoedit "/etc/xdg/picom.conf"
end

if command -v transmission-remote >/dev/null
	abbr -a trs transmission-remote
	abbr -a trst transmission-remote -t
	abbr -a trsl transmission-remote -l
	abbr -a trss transmission-remote -tall --start
	abbr -a trsr transmission_rm_finished
end

# fstab file
abbr -a fsc sudoedit "/etc/fstab"

# AddressSanitizer log files output
setenv ASAN_OPTIONS "log_path=/tmp/asan.log"

# Requires GNU stow
if command -v stow >/dev/null
	set DOTFILES "$HOME/dotfiles"
	if command -v nvim >/dev/null
		abbr -a vimrc "$EDITOR $DOTFILES/nvim/.config/nvim"
	end
	if command -v vifm >/dev/null
		abbr -a vfrc "$EDITOR $DOTFILES/vifm/.config/vifm/vifmrc"
		abbr -a vimrc "vicd $DOTFILES/nvim/.config/nvim"
	end
	if command -v dunst >/dev/null
		abbr -a dunstrc "$EDITOR $DOTFILES/dunst/.config/dunst/dunstrc"
	end
	if command -v zathura >/dev/null
		abbr -a zrc "$EDITOR $DOTFILES/zathura/.config/zathura/zathurarc"
	end
	if command -v fish >/dev/null
		abbr -a fcf "$EDITOR $DOTFILES/fish/.config/fish/config.fish"
		if command -v starship >/dev/null
			abbr -a scf "$EDITOR $DOTFILES/fish/.config/fish/prompt/starship/starship.toml"
		end
	end
	if command -v alacritty >/dev/null
		abbr -a acf "$EDITOR $DOTFILES/alacritty/.config/alacritty/alacritty.toml"
	end
	if command -v tmux >/dev/null
		abbr -a tedit "$EDITOR $DOTFILES/tmux/.config/tmux/tmux.conf"
	end
	if command -v polybar >/dev/null
		abbr -a pedit "$EDITOR $DOTFILES/polybar/.config/polybar/config.ini"
	end
	if command -v wezterm >/dev/null
		abbr -a wcf "$EDITOR $DOTFILES/wezterm/.config/wezterm/wezterm.lua"
	end

    	set SUCKLESS "$DOTFILES/suckless"
	if command -v dwm >/dev/null
		abbr -a dwmc "$EDITOR $SUCKLESS/dwm/config.def.h"
	end
	if command -v dmenu >/dev/null
		abbr -a dmenuc "$EDITOR $SUCKLESS/dmenu/config.def.h"
	end
	if command -v slstatus >/dev/null
		abbr -a slstatusc "$EDITOR $SUCKLESS/slstatus/config.def.h"
	end
end


# personal stuff
fish_add_path -a "$HOME/.config/linux-scripts"
set MUSIC $HOME/.config/personal/music
abbr -a music "$EDITOR $MUSIC"


fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set fish_vi_force_cursor 1
# INSERT MODE
bind -M insert -m default \ce forward-char -m insert
# DEFAULT MODE
bind -M default j backward-char
bind -M default \; forward-char
bind -M default k down-or-search
bind -M default l up-or-search
# VISUAL MODE
bind -M visual j backward-char
bind -M visual \; forward-char
bind -M visual k down-or-search
bind -M visual l up-or-search

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showdirtystate yes

# copy-paste
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

set -U fish_pager_color_selected_description


# Colorscheme: Lava
set -U fish_color_normal normal
set -U fish_color_command FF9400
set -U fish_color_quote BF9C30
set -U fish_color_redirection BF5B30
set -U fish_color_end FF4C00
set -U fish_color_error FFDD73
set -U fish_color_param FFC000
set -U fish_color_comment A63100
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion FFC473
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel --reverse
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D
set -U fish_pager_color_selected_background --background=brblack
set -U fish_pager_color_secondary_prefix
set -U fish_pager_color_background
set -U fish_pager_color_selected_prefix
set -U fish_pager_color_secondary_description
set -U fish_pager_color_secondary_completion
set -U fish_pager_color_selected_completion
set -U fish_pager_color_secondary_background
set -U fish_color_option
set -U fish_color_host_remote
set -U fish_color_keyword
set -U fish_pager_color_selected_description


if status is-interactive
	if status is-login
		and command -a keychain >/dev/null
		keychain --quiet $SSH_KEYS
	end
end
