# Override slow command-not-found handler
function fish_command_not_found
    echo "fish: Unknown command '$argv'" >&2
end

# no greeting
function fish_greeting 
end

# Override exit to automatically 'disown'
function exit
    jobs -q; and disown (jobs -p)
    builtin exit
end

setenv SHELL /usr/bin/fish
setenv ASAN_OPTIONS "log_path=stderr"
setenv GAMES_DIR "$HOME/games/"


# helper
function havebin -a bin
    return (command -v $bin >/dev/null)
end


function reporterr -a msg
    set -l currline "$(commandline -L)"
    echo "fish:$currline: $msg"
end


if havebin nvim
    # set vimrc path
    setenv VIMRCDIR "$HOME/.config/nvim"
    setenv MYVIMRC "$HOME/.config/nvim/init.lua"

    if test -n "$NVIM_LISTEN_ADDRESS"
        set -x MANPAGER "/usr/local/bin/nvr -c 'Man!' -o -"
    end

    if havebin vim
        abbr -a vim nvim
    end

    setenv EDITOR nvim
    setenv MANPAGER "nvim +Man!"
    abbr -a e "$EDITOR"
    abbr -a fcf "$EDITOR $HOME/.config/fish/config.fish"
    abbr -a vimrc "$EDITOR $HOME/.config/nvim"

    set orgfile "$HOME/notes/org/refile.org"
    function note
        if ! test -e $orgfile > /dev/null
            printf "#+title: \$\n#+author: B. Jure\n" > $orgfile
        end
        $EDITOR $orgfile
    end
    abbr -a rmnote "rm $orgfile"

    set texdir "$HOME/tex"
    set texfile "$HOME/tex/new.tex"
    abbr -a texf "nvim $texfile"
    abbr -a rmtexf "rm $texfile"
end


if havebin magick
    function conv -a infile -a infmt -a outfmt
        set --local outfile
        set outfile (basename -s ".$infmt" $infile)
        set outfile "$outfile.$outfmt"
        magick $infile $outfile
    end
    function png2ico -a infile
        conv $infile "png" "ico"
    end
    function ico2png -a infile
        conv $infile "ico" "png"
    end
end


if havebin khard
    abbr -a khardcf "$EDITOR $HOME/.config/khard/khard.config"
end


if havebin alarm
    setenv ALARM_PLAYER mpv
    setenv ALARM_AUDIO ~/.config/linux-scripts/alarm/alarm.mp3
end


if havebin rofi
    abbr -a redit "$EDITOR $HOME/.config/rofi/config.rasi"
end


if havebin polybar
    abbr -a pedit "$EDITOR $HOME/.config/polybar/config.ini"
end


if havebin wget
    abbr -a wgetall "wget --wait=1
                         --level=inf
                         --limit-rate=20M
                         --recursive
                         --page-requisite
                         --user-agent=Mozilla
                         --no-parent
                         --convert-links
                         --adjust-extension
                         --no-clobber
                         -e robots=off"
end


function memtop
    set psout ps -eo user,pid,ppid,cmd,pmem,rss --no-headers --sort=-rss
    $psout | awk '{if ($2 ~ /^[0-9]+$/ && $6/1024 >= 1) {\\
        printf "PID: %s, PPID: %s, Memory consumed (RSS): %.2f MB, Command: ",\\
        $2, $3, $6/1024; for (i=4; i<=NF; i++) printf "%s ", $i; printf "\n"}}' | head
end


if havebin make
    abbr -a make "make -j12"
end


if havebin mbsync
    abbr -a mbsyncrc "$EDITOR $HOME/.mbsyncrc"
end


if havebin neomutt
    abbr -a mutt neomutt
    abbr -a muttrc "$EDITOR $HOME/.config/neomutt/neomuttrc"
end


# Run ssh-agent and avoid running multiple agents
function sshauth
    if not havebin ssh-agent
        reporterr "have 'sshauth' but could not find 'ssh-agent'"
        return
    end
    set sshdir "$HOME/.ssh"
    set -a sshkeys "$sshdir/id_ed25519_aur"
    set -a sshkeys "$sshdir/id_ed25519_gh"
    if not test -S "$sshdir/ssh_auth_sock"
        eval (ssh-agent -c)
        ln -sf "$SSH_AUTH_SOCK" "$sshdir/ssh_auth_sock"
    end
    export SSH_AUTH_SOCK="$sshdir/ssh_auth_sock"
    ssh-add -l > /dev/null; or ssh-add $sshkeys # do not quote 'sshkeys' !
end


if havebin sloccount 
    abbr -a loc sloccount
end


if havebin dunst
    abbr -a dunstrc "$EDITOR $HOME/.config/dunst/dunstrc"
end


if havebin gf2
    abbr -a dbg gf2
end


if havebin xclip
    abbr -a xp "xclip -selection cliboard -o"
    abbr -a xc "xclip -selection clipboard"
end


if havebin eza
    abbr -a l eza
    abbr -a ls "eza -a"
    # only dirs
    abbr -a lsd "eza -alD"
    # only files
    abbr -a lsf "eza -alf"
    abbr -a lsa "eza -al"
    abbr -a tree "eza -T"
    abbr -a treeg "eza -T --git-ignore"
    abbr -a lsg "eza -al --git-ignore"
end


if havebin git
    abbr -a g git
    abbr -a gs "git status"
    abbr -a ga "git add"
    abbr -a gc "git commit"
    abbr -a gp "git push"
    abbr -a gcf "git config --global --edit"
    abbr -a gco "git checkout"
end


if havebin python3
    abbr -a py python3
end


if havebin wezterm
    abbr -a wcf "$EDITOR $HOME/.config/wezterm/wezterm.lua"
end


if havebin vifm
    abbr -a vfrc "$EDITOR $HOME/.config/vifm/vifmrc"
    # change shell directory when leaving vifm
    function vicd --argument-names 'startdir'
        if ! test -n "$startdir" >/dev/null
            set startdir (pwd)
        end
        set dst "$(command vifm "$startdir" --choose-dir - $argv[2..-1])"
        if [ -z "$dst" ]
            return 1
        end
        cd "$dst"
    end

    abbr -a vf vicd
    abbr -a vimrc "vicd $HOME/.config/nvim"
end


if havebin tmux
    abbr -a tedit $EDITOR "$HOME/.config/tmux/tmux.conf"
end

if havebin xsct
    abbr -a sct xsct
    if [ -z $XSCT_TEMPERATURE_DAY ]
        setenv XSCT_TEMPERATURE_DAY 6500
    end
    if [ -z $XSCT_TEMPERATURE_NIGHT ]
        setenv XSCT_TEMPERATURE_NIGHT 3500
    end
end

if havebin alacritty
    abbr -a acf $EDITOR "$HOME/.config/alacritty/alacritty.toml"
end


if havebin fzf
    and havebin locate
    setenv FZF_DEFAULT_COMMAND "command locate --regexp $HOME/[^.].\*"
    setenv FZF_DEFAULT_OPTS "--layout=reverse --inline-info --height 50% --bind=ctrl-n:down,ctrl-p:up"
    setenv FZF_CTRL_T_COMMAND "command locate --regexp /[^.].\*"
    setenv FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND
    fzf_key_bindings
end


if test -z "$WAYLAND_DISPLAY" &>/dev/null
    abbr -a xinit "$EDITOR $HOME/.xinitrc"
end


if havebin yt-dlp
    abbr -a ytd yt-dlp
end


if havebin zathura
    abbr -a zrc "$EDITOR $HOME/.config/zathura/zathurarc"
end


if havebin picom
    abbr -a pcf "$EDITOR $HOME/.config/picom/picom.conf"
end


if havebin transmission-remote
    abbr -a trs transmission-remote
    abbr -a trst "transmission-remote -t"
    abbr -a trsl "transmission-remote -l"
    abbr -a trss "transmission-remote -tall --start"
    abbr -a trsr transmission_rm_finished
end


if havebin i3
    abbr -a i3cf "$EDITOR $HOME/.config/i3/config"
end


if havebin i3blocks
    abbr -a i3bcf "$EDITOR $HOME/.config/i3blocks/config"
end


if havebin emacs
    fish_add_path -a "$HOME/.config/emacs/bin"
end

if havebin paru
    complete --command paru --wraps pacman
    abbr -a p "paru"
    abbr -a up "paru -Syu"
end


if havebin rg
    and havebin fzf
    set FZFOPTS 'fzf -i --layout=reverse --inline-info --height 50% --bind=ctrl-n:down,ctrl-p:up'
    function fnote
        $EDITOR $(rg -n --type=org -l ".*" "$HOME/notes/org" |
        fzf -i --layout=reverse --inline-info --height 50% --bind=ctrl-n:down,ctrl-p:up)
    end
end


if havebin steam
    set -l steampath "$HOME/.local/share/Steam"
    setenv STEAM_COMPAT_CLIENT_INSTALL_PATH "$steampath"
    setenv STEAM_COMPAT_DATA_PATH "$steampath/steamapps/compatdata"
    setenv PROTON_PATH "$steampath/steamapps/common/Proton 9.0 (Beta)/proton"
    if not [ -e "$PROTON_PATH" ] # no proton?
        set -e -Ug PROTON_PATH # remove PROTON_PATH
    end
end

# personal stuff
fish_add_path -a "$HOME/.config/linux-scripts"
set MUSIC $HOME/.config/personal/music
abbr -a music "$EDITOR $MUSIC"


fish_vi_key_bindings
set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual block blink
set fish_vi_force_cursor 1

# INSERT MODE
bind -M insert -m default ctrl-e forward-char -m insert

# DEFAULT MODE
bind -M default j backward-char
bind -M default \; forward-char
bind -M default k down-or-search
bind -M default l up-or-search
bind -M default yy fish_clipboard_copy
bind -M default Y fish_clipboard_copy
bind -M default p fish_clipboard_paste

# VISUAL MODE
bind -M visual j backward-char
bind -M visual \; forward-char
bind -M visual k down-or-search
bind -M visual l up-or-search
bind -M visual y fish_clipboard_copy
bind -M visual Y fish_clipboard_copy
bind -M visual p fish_clipboard_paste


# Fish git prompt
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showdirtystate yes

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

abbr --add dotdot --regex '^\.\.+$' --function multicd
abbr -a se sudoedit
abbr -a fcf "$EDITOR $HOME/.config/fish/config.fish"
abbr -a fsc sudoedit "/etc/fstab"
abbr -a srm shred -u 
abbr -a c clear

if status is-interactive
    sshauth
end
