/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 31;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Berkeley Mono:size=10" };
static const char dmenufont[]       = "Berkeley Mono:size=10";

static const char norm_fg[] = "#D5C4A1";
static const char norm_bg[] = "#282828";
static const char norm_border[] = "#282828";
static const char sel_fg[] = "#cc241d";
static const char sel_bg[] = "#1d2021";
static const char sel_border[] = "#fbf1c7";
static const char *colors[][3]      = {
    /*               fg           bg          border                         */
    [SchemeNorm] =   { norm_fg,   norm_bg,    norm_border }, 		     // unfocused wins
    [SchemeSel]  =   { sel_fg,    sel_bg,     sel_border },		     // the focused win
};

static const char *tags[] = { "code", "web", "1", "2", "3" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       0,            0,           -1 },
};

/* layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1;    /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ ControlMask,                  KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/usr/bin/fish", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb", "#282828", "-nf", "#a89984", "-sb", "#cc241d", "-sf", "#a89984", NULL };
static const char *termcmd[]  = { "alacritty", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ ControlMask,                  XK_backslash,   spawn,          {.v = dmenucmd } },
	{ ControlMask,                  XK_Return,      spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,           togglebar,      {0} },
	{ MODKEY,                       XK_j,           focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_semicolon,   focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_k,           setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,           setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return,      zoom,           {0} },
	{ MODKEY,                       XK_Tab,         view,           {0} },
	{ MODKEY,                       XK_f,           killclient,     {0} },
	{ MODKEY,                       XK_t,           setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,           setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,       setlayout,      {0} },
	{ ControlMask,                  XK_5,           togglefloating, {0} },
	{ MODKEY,                       XK_0,           view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,           tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,       focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,      focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,       tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,      tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_bracketleft,                 0)
	TAGKEYS(                        XK_bracketright,                1)
	TAGKEYS(                        XK_2,                           2)
	TAGKEYS(                        XK_3,                           3)
	TAGKEYS(                        XK_4,                           4)
	{ MODKEY|ShiftMask,             XK_q,           quit,           {0} },
	// { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	// { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

