local myrepotemplate = [===[
* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?
** Synopsis
   Text
   Local git [[file:/home/%n/prog/%^{Language repo is written in}/%^{Repository name}][Desc]].
]===]

require("orgmode").setup({
	org_agenda_files = { "~/notes/org/agenda/*.org" },
	org_default_notes_file = "~/notes/org/note.org",
	org_hide_leading_stars = true,
	org_capture_templates = {
		r = {
			description = "My repository",
			template = myrepotemplate,
			target = "~/notes/org/myrepos.org",
			properties = {
				empty_lines = { before = 1, after = 0 },
			},
		},
	},
})
