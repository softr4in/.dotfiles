local helpers = require("softr4in.luasnip-helpers")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.conditions.expand").line_begin

return {

	-- NOTE: NONMATH ENVIRONMENTS AND TABLES

	-- GENERIC ENVIRONMENT
	s(
		{ trig = "n1", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
        <>
      \end{<>}
      ]],
			{
				i(1),
				d(2, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ENVIRONMENT WITH ONE EXTRA ARGUMENT
	s(
		{ trig = "n2", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}{<>}
        <>
      \end{<>}
      ]],
			{
				i(1),
				i(2),
				d(3, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ENVIRONMENT WITH TWO EXTRA ARGUMENTS
	s(
		{ trig = "n3", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}{<>}{<>}
        <>
      \end{<>}
      ]],
			{
				i(1),
				i(2),
				i(3),
				d(4, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ITEMIZE
	s(
		{ trig = "itt", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{itemize}
        \item <>
      \end{itemize}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin }
	),
	-- ITEMIZE W/ INVISIBLE BULLET POINTS
	s(
		{ trig = "itx", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{itemize}
        \renewcommand\labelitemi{}
        \item <>
      \end{itemize}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin }
	),
	-- ENUMERATE
	s(
		{ trig = "enn", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{enumerate}
        \item <>
      \end{enumerate}
      ]],
			{
				i(0),
			}
		)
	),
	-- FIGURE: VECTOR GRAPHICS
	s(
		{ trig = "vct" },
		fmta(
			[[
        \begin{center}
          \includeinkscape[width=<>\linewidth]{<>}
          \captionof{figure}{<>}
          \label{<>}
        \end{center}
      ]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
			}
		),
		{ condition = line_begin }
	),
	-- FIGURE: PNG GRAPHICS
	s(
		{ trig = "fig" },
		fmta(
			[[
        \begin{center}
          \includegraphics[width=<>\linewidth]{<>}
          \captionof{figure}{<>}
          \label{<>}
        \end{center}
      ]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
			}
		),
		{ condition = line_begin }
	),
	-- DEFINITION
	s(
		{ trig = "dfn", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{definition}[<>]
        <>

      \end{definition}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- THEOREM
	s(
		{ trig = "thm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{theorem}[<>]
        <>

      \end{theorem}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- COROLLARY
	s(
		{ trig = "crly", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{corollary}[<>]
        <>

      \end{corollary}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- LEMMA
	s(
		{ trig = "lma", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{lemma}[<>]
        <>

      \end{lemma}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- EXAMPLE
	s(
		{ trig = "exmp", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{example}[<>]
        <>

      \end{example}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- NOTE
	s(
		{ trig = "nte", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{note}[<>]
        <>

      \end{note}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- QUESTION W/O NUMBERING
	s(
		{ trig = "qn", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{question}[<>]
        <>

        \textbf{Solution:}

      \end{question}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- SIMPLIFIED EXPLANATIONS
	s(
		{ trig = "smp", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{simplified}
        \textbf{Simplified:}

        <>
      \end{simplified}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- TABLE W/ 2 COLUMNS (doesn't work well in multicol)
	s(
		{ trig = "tb2", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{tblr}{p{0.45\linewidth} p{0.45\linewidth}}
        <>
      \end{tblr}
       ]],
			{
				i(1),
			}
		)
	),
	-- TABLE W/ 3 COLUMNS (doesn't work well in multicol)
	s(
		{ trig = "tb3", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{tblr}{p{0.31\linewidth} p{0.31\linewidth} p{0.31\linewidth}}
        <>
      \end{tblr}
       ]],
			{
				i(1),
			}
		)
	),
	-- TABLE W/ 4 COLUMNS (doesn't work well in multicol)
	s(
		{ trig = "tb4", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{tblr}{p{0.15\linewidth} p{0.3\linewidth} p{0.15\linewidth} p{0.3\linewidth}}
        <>
      \end{tblr}
       ]],
			{
				i(1),
			}
		)
	),
	-- TABLE W/ 2 COLUMNS (doesn't work well in multicol)
	s(
		{ trig = "tb5", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{tblr}{p{0.19\linewidth} p{0.19\linewidth} p{0.19\linewidth} p{0.19\linewidth} p{0.19\linewidth}}
        <>
      \end{tblr}
       ]],
			{
				i(1),
			}
		)
	),
	-- TABLE W/ 6 COLUMNS (doesn't work well in multicol)
	s(
		{ trig = "tb6", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{tblr}{c|c|c|c|c|c}
        <>
      \end{tblr}
       ]],
			{
				i(1),
			}
		)
	),

	-- CLASSIC TABLE, 2 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t2", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=6.3cm#\hfil} & \quad \vtop{\hsize=6.3cm#\hfil} \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- CLASSIC TABLE, 3 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t3", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=4cm#\hfil} & \quad \vtop{\hsize=4cm#\hfil} & \quad \vtop{\hsize=4cm#\hfil} \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- CLASSIC TABLE, 4 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t4", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=3cm#\hfil} & \quad \vtop{\hsize=3cm#\hfil} & \quad \vtop{\hsize=3cm#\hfil} & \quad \vtop{\hsize=3cm#\hfil}
      \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- CLASSIC TABLE, 5 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t5", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=2.4cm#\hfil} & \quad \vtop{\hsize=2.4cm#\hfil} & \quad \vtop{\hsize=2.4cm#\hfil} & \quad \vtop{\hsize=2.
      4cm#\hfil} & \quad \vtop{\hsize=2.4cm#\hfil} \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- CLASSIC TABLE, 6 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t6", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=2cm#\hfil} & \quad \vtop{\hsize=2cm#\hfil} & \quad \vtop{\hsize=2cm#\hfil} & \quad \vtop{\hsize=2cm#\hfil}
        & \quad \vtop{\hsize=2cm#\hfil}  & \quad \vtop{\hsize=2cm#\hfil} \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- CLASSIC TABLE, 7 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t7", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=1.7cm#\hfil} & \quad \vtop{\hsize=1.7cm#\hfil} & \quad \vtop{\hsize=1.7cm#\hfil} & \quad \vtop{\hsize=1.
      7cm#\hfil} & \quad \vtop{\hsize=1.7cm#\hfil}  & \quad \vtop{\hsize=1.7cm#\hfil}  & \quad \vtop{\hsize=1.7cm#\hfil} \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- CLASSIC TABLE, 8 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t8", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=1.5cm#\hfil} & \quad \vtop{\hsize=1.5cm#\hfil} & \quad \vtop{\hsize=1.5cm#\hfil} & \quad \vtop{\hsize=1.
      5cm#\hfil} & \quad \vtop{\hsize=1.5cm#\hfil} & \quad \vtop{\hsize=1.5cm#\hfil} & \quad \vtop{\hsize=1.5cm#\hfil} &
      \quad \vtop{\hsize=1.5cm#\hfil} \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- CLASSIC TABLE, 9 COL; THE ONLY ONE THAT WORKS WITH multicol (breaks properly across columns)
	s(
		{ trig = "t9", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{0.5em}
      \halign{%
      \vtop{\hsize=1.3cm#\hfil} & \quad \vtop{\hsize=1.3cm#\hfil} & \quad \vtop{\hsize=1.3cm#\hfil} & \quad \vtop{\hsize=1.
      3cm#\hfil} & \quad \vtop{\hsize=1.3cm#\hfil} & \quad \vtop{\hsize=1.3cm#\hfil} & \quad \vtop{\hsize=1.3cm#\hfil} &
      \quad \vtop{\hsize=1.3cm#\hfil} & \quad \vtop{\hsize=1.3cm#\hfil} \cr
        <>
      }
      ]],
			{
				i(1),
			}
		)
	),
	-- MULTIPLE LINES OF VERBATIM (requires lstlisting LaTeX package)
	s(
		{ trig = "vbt", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{lstlisting}
        <>
      \end{lstlisting}
      ]],
			{
				i(1),
			}
		)
	),

	-- NOTE: NONMATH SYNTAX

	-- QUOTES
	s(
		{ trig = "qte", snippetType = "autosnippet" },
		fmta("``<>''", {
			d(1, get_visual),
		})
	),
	-- -- 2 COLUMNS
	-- s({ trig = "p2", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	--   fmta(
	--     [[
	--     \setlength{\columnsep}{3em}
	--     \begin{paracol}{2}
	--       <>
	--     \end{paracol}
	--     ]],
	--     {
	--       i(1),
	--     }
	--   ),
	--   { condition = line_begin }
	-- ),
	-- -- 3 COLUMNS
	-- s({ trig = "p3", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	--   fmta(
	--     [[
	--     \setlength{\columnsep}{3em}
	--     \begin{paracol}{3}
	--       <>
	--     \end{paracol}
	--     ]],
	--     {
	--       i(1),
	--     }
	--   ),
	--   { condition = line_begin }
	-- ),
	--
	-- -- 4 COLUMNS
	-- s({ trig = "p4", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	--   fmta(
	--     [[
	--     \setlength{\columnsep}{3em}
	--     \begin{paracol}{4}
	--       <>
	--     \end{paracol}
	--     ]],
	--     {
	--       i(1),
	--     }
	--   ),
	--   { condition = line_begin }
	-- ),
	-- -- TOPIC ENVIRONMENT (my custom tcbtheorem environment)
	-- s({ trig = "nto", snippetType = "autosnippet" },
	--   fmta(
	--     [[
	--     \begin{topic}{<>}{<>}
	--       <>
	--     \end{topic}
	--     ]],
	--     {
	--       i(1),
	--       i(2),
	--       d(3, get_visual),
	--     }
	--   ),
	--   { condition = line_begin }
	-- ),
}
