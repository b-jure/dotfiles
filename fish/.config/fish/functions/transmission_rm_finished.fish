function transmission_rm_finished
	transmission-remote -l | grep 100% | awk '{print $1}' | paste -d, -s |
	xargs -i transmission-remote -t {} -r
end
