# Move out of directories using continous string of dots starting from .. as first layer
# Each consecutive layer is one additional dot, so ... is depth of 2, .... is 4 etc...
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
