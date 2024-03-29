fzf_key_bindings

bind -M default \cN history-search-forward
bind -M default \cP history-search-backward

bind -M insert \cN history-search-forward
bind -M insert \cP history-search-backward

bind -k ic true
bind -M default -k ic true
bind -M insert -k ic true
bind -M visual -k ic true
