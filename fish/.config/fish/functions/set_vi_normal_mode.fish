# Set normal vi mode
function set_vi_normal_mode
    set vi_mode (get_vi_mode)
    if commandline -P
        commandline -f cancel
    else if [ $vi_mode != "normal" ]
            set fish_bind_mode default 
        if [ $vi_mode = "visual" ]
            commandline -f end-selection
        end
        commandline -f repaint-mode
    end
end
