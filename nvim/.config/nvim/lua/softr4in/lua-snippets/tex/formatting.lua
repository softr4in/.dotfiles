local helpers = require("softr4in.luasnip-helpers")
local get_visual = helpers.get_visual

return {
	-- CUSTOM COLORED TEXT/MATH NOTATION IN MATH ENVIRONMENTS; 1st parameter is color, 2nd parameter is your notation
	s(
		{ trig = "cmc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \cmc{<>}{<>}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = helpers.in_mathzone }
	),
	-- SI unit formatting; this one provides formatting for an SI unit only.
	s(
		{ trig = "sii", snippetType = "autosnippet" },
		fmta([[\si{<>}]], {
			i(1),
		})
	),
	-- SI unit formatting; this one provides formatting for both a number and its SI unit e.g. 3.14 meters
	s(
		{ trig = "SI" },
		fmta([[\SI{<>}{<>}]], {
			i(1),
			i(2),
		})
	),
	-- CLICKABLE URL; syntax reminder: \url{some_link} for raw link
	s(
		{ trig = "url" },
		fmta([[\url{<>}]], {
			d(1, get_visual),
		})
	),
	-- CLICKABLE TEXT W/ URL LINK; syntax reminder: \href{some_link}{some_text} for clickable text.
	s(
		{ trig = "href" },
		fmta([[\href{<>}{<>}]], {
			d(1, get_visual),
			d(2, get_visual),
		})
	),
	-- VSPACE
	s(
		{ trig = "vs" },
		fmta([[\vspace{0.5<>em}]], {
			d(1, get_visual),
		})
	),
	-- SETLENGTH
	s(
		{ trig = "setl" },
		fmta([[\setlength{\abovedisplayskip}{-0.5<>em}]], {
			d(1, get_visual),
		})
	),
	-- SECTION
	s({ trig = "skp", snippetType = "autosnippet" }, fmta([[\noalign{\vskip 0.5em}]], {})),
	-- SECTION
	s(
		{ trig = "h1", snippetType = "autosnippet" },
		fmta(
			[[
      \section{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- SUBSECTION
	s(
		{ trig = "h2", snippetType = "autosnippet" },
		fmta(
			[[
      \subsection{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- SUBSUBSECTION
	s(
		{ trig = "h3", snippetType = "autosnippet" },
		fmta(
			[[
      \subsubsection{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- MATH SYMBOLS IN SECTION/SUBSECTION/SUBSUBSECTION (needed if using STIX math font)
	s(
		{ trig = "hmath", snippetType = "autosnippet" },
		fmta([[\texorpdfstring{<>}{<>}]], {
			i(1),
			i(2),
		})
	),
	-- REFERENCE
	s(
		{ trig = "rfr", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
      ~\ref{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- HPHANTOM
	s(
		{ trig = "hpp", snippetType = "autosnippet" },
		fmta(
			[[
      \hphantom{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- BOLD TEXT i.e. \textbf
	s(
		{ trig = "tbf", snippetType = "autosnippet" },
		fmta("\\textbf{<>}", {
			d(1, get_visual),
		})
	),
	-- COLORED BOLD FOR MATH DEFINITION TEXT
	s(
		{ trig = "tbd", snippetType = "autosnippet" },
		fmta("\\textdef{<>}", {
			d(1, get_visual),
		})
	),
	-- COLORED MATH TEXT
	s(
		{ trig = "tmc", snippetType = "autosnippet" },
		fmta("\\tmc{<>}", {
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone }
	),
}
