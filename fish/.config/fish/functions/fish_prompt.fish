function fish_prompt
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # status
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    # user
    set -l usercolor (set_color FABD2F)
    set -l user (whoami)

    # working directory
    set -l wdircolor (set_color 98971A)
    set -l wdir (pwd)

    # vcs
    set -l vcscolor (set_color 458588)
    set -l vcsprompt (fish_vcs_prompt)

    # separator sign at the end
    set -l endsigncolor (set_color 689D6A)
    set -l endsign ""

    # if status not 0 print status
    if test "$prompt_status" != ""
        printf "%s " $prompt_status
    end
    # print user and working directory
    printf "%s%s %s%s" $usercolor $user $wdircolor $wdir
    # if vcs is present print it's prompt
    if test -n $vcsprompt
        printf "%s%s " $vcscolor $vcsprompt
    end
    # finally print end symbol and reset color
    printf "%s%s%s " $endsigncolor $endsign $normal
end
