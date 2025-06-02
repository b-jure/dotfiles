function transmission_rm_finished
    transmission-remote -l | grep 100% \
    | awk 'match($1, /[0-9]+/) { print substr($1, RSTART, RLENGTH) }' \
    | paste -d, -s | xargs -i transmission-remote -t {} -r
end
