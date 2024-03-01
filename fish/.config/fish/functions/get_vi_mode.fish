function get_vi_mode --description "Display vi prompt mode, same as
    fish_default_mode_prompt it outputs string literals without color formatting"
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                echo -n 'normal'
            case insert
                echo -n 'insert'
            case replace_one
                echo -n 'replace_one'
            case replace
                echo -n 'replace'
            case visual
                echo -n 'visual'
        end
    end
end
