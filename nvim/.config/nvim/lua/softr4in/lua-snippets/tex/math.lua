local helpers = require("softr4in.luasnip-helpers")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.conditions.expand").line_begin

return {

	-- NOTE: MATH ENVIRONMENTS

	-- INLINE MATH
	s(
		{ trig = "mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		-- or is used instead of xor here because line_begin has a loose definition: it allows for any number of preceding
		-- whitespaces before it. Hence, it is possible for both conditions to be true at once.
		-- With xor, the snippet would not trigger with more than 1 preceding whitespace
		{ condition = line_begin + helpers.single_whitespace_before }
	),
	-- align*; multiple equation lines w/o numbering for each line
	s(
		{ trig = "al0", snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{-2em}
      \begin{align*}
        <>
      \end{align*}
      \vspace{-2em}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- align*; multiple equation lines w/o numbering for each line, align left
	s(
		{ trig = "al1", snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{-2em}
      \begin{align*}
        & <>
        &
        &
        &
      \end{align*}
      \vspace{-2em}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- multiple equation lines, single numbering
	s(
		{ trig = "al2", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{equation}
        \begin{aligned}
          <>
        \end{aligned}
      \end{equation}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- align; multiple equation lines w/ numbering for each line
	s(
		{ trig = "al3", snippetType = "autosnippet" },
		fmta(
			[[
      \vspace{-2em}
      \begin{align}
        <>
      \end{align}
      \vspace{-2em}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- SPLIT environment within EQUATION
	s(
		{ trig = "ss", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{equation*}
        \begin{split}
          <>
        \end{split}
      \end{equation*}
      ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	-- LEFT VERTICAL BRACE W/ FIXED CENTRE ALIGNMENT
	s(
		{ trig = "lcase", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{equation*}
        \text{placeholder LHS text}<>
        \begin{cases}
          placeholderRHS\ line\ 1<> \\
          placeholderRHS\ line\ 2<>
        \end{cases}
      \end{equation*}
      ]],
			{
				i(1),
				i(2),
				i(3),
			}
		)
	),

	-- RIGHT VERTICAL BRACE W/ FIXED CENTRE ALIGNMENT
	s(
		{ trig = "rcase", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{equation*}
        \begin{rcases}
          placeholder\ LHS\ line\ 1<> \\
          placeholder\ LHS\ line\ 2<>
        \end{rcases}
        \text{placeholder RHS text}<>
      \end{equation*}
      ]],
			{
				i(1),
				i(2),
				i(3),
			}
		)
	),
	-- LEFT VERTICAL BRACE W/ ADJUSTABLE ALIGNMENT
	s(
		{ trig = "lacase", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{adjustbox}{left}
        \begin{tabular}{l@{}l@{}l}
          \multirow{2}{3.8cm}{placeholder LHS text<>} & \ldelim{\{}{2}{1em} & $placeholder\ RHS\ line\ 1<>$ \\
          & & $placeholder\ RHS\ line\ 2<>$ \\
        \end{tabular}
      \end{adjustbox}
      ]],
			{
				i(1),
				i(2),
				i(3),
			}
		)
	),

	-- RIGHT VERTICAL BRACE W/ ADJUSTABLE ALIGNMENT
	s(
		{ trig = "racase", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      \begin{adjustbox}{left}
        \begin{tabular}{l@{}l@{}l}
          $placeholder\ LHS\ line\ 1<>$ & \rdelim{\}}{2}{1em} & \multirow{2}{4cm}{placeholder\ RHS text<>} \\
          $placeholder\ LHS\ line\ 2<>$ & & \\
        \end{tabular}
      \end{adjustbox}
      ]],
			{
				i(1),
				i(2),
				i(3),
			}
		)
	),
	-- GENERAL MATRIX EXPRESSION 1
	s(
		{ trig = "mtx1", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        &
        \left[
        \begin{array}{ccc|c}
          a & b & c & d
        \end{array}
        \right]
        \\
        \overset{*}{\longrightarrow}&
        \left[
        \begin{array}{ccc|c}
          0 & 0 & 0 & 0 \\
        \end{array}
        \right]
        \\
        \overset{*}{\longrightarrow}&
        \left[
        \begin{array}{ccc|c}
          0 & 0 & 0 & 0 \\
        \end{array}
        \right]
        \\
        \overset{*}{\longrightarrow}&
        \left[
        \begin{array}{ccc|c}
          0 & 0 & 0 & 0 \\
        \end{array}
        \right]
        \\
        \overset{*}{\longrightarrow}&
        \left[
        \begin{array}{ccc|c}
          0 & 0 & 0 & 0 \\
        \end{array}
        \right]
        \\
        \overset{*}{\longrightarrow}&
        \left[
        \begin{array}{ccc|c}
          0 & 0 & 0 & 0 \\
        \end{array}
        \right]
        \\
        \overset{*}{\longrightarrow}&
        \left[
        \begin{array}{ccc|c}
          0 & 0 & 0 & 0 \\
        \end{array}
        \right]
      \end{align*}
      \vspace{-2em}
      ]],
			{}
		)
	),
	-- GENERAL MATRIX EXPRESSION 2
	s(
		{ trig = "mtx2", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left[
        \begin{array}{cc}
          a & b \\
          c & d
        \end{array}
        \right]
        +
        \left[
        \begin{array}{cc}
          a & b \\
          c & d
        \end{array}
        \right]
        &=
        \left[
        \begin{array}{cc}
          e & f \\
          g & h
        \end{array}
        \right]
      \end{align*}
      \vspace{-2em}
      ]],
			{}
		)
	),
	-- GENERAL MATRIX EXPRESSION 3
	s(
		{ trig = "mtx3", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
        +
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
        &=
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
        \\
        &=
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
      \end{align*}
      \vspace{-2em}
      ]],
			{}
		)
	),
	-- GENERAL MATRIX EXPRESSION 4
	s(
		{ trig = "mtx4", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
        &=
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
        +
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
        \\
        &=
        \left(
        \begin{array}{cc}
          1 & 2 \\
          3 & 4
        \end{array}
        \right)
      \end{align*}
      \vspace{-2em}
      ]],
			{}
		)
	),
	-- GENERAL MATRIX EXPRESSION 5
	s(
		{ trig = "mtx5", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        A + B &=
        \left[
        \begin{array}{cc}
          2 & 1 \\
          5 & 4
        \end{array}
        \right]
        +
        \left[
        \begin{array}{cc}
            2 & 0 \\
            7 & 3
        \end{array}
        \right]
        +
        \left[
        \begin{array}{cc}
            4 & 3 \\
            5 & 6
        \end{array}
        \right]
        +
        \left[
        \begin{array}{cc}
            3 & 1 \\
            5 & 8
        \end{array}
        \right]
        \\
        &
        +
        \left[
        \begin{array}{cc}
            1 & 0 \\
            3 & 3
        \end{array}
        \right]
        +
        \left[
        \begin{array}{cc}
            4 & 4 \\
            6 & 2
        \end{array}
        \right]
        +
        \left[
        \begin{array}{cc}
            9 & 5 \\
            3 & 2
        \end{array}
        \right]
        \\
        &=
        \left[
        \begin{array}{cc}
          25 & 14 \\
          34 & 28
        \end{array}
        \right]
      \end{align*}
      \vspace{-2em}
      ]],
			{}
		)
	),
	-- LONE MATRIX W/ ROUND BRACES
	s(
		{ trig = "rmtx", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left(
        \begin{array}{cc<>}
          a & b<>
        \end{array}
        \right)
      \end{align*}
      \vspace{-2em}
      ]],
			{
				i(1),
				i(2),
			}
		)
	),
	-- LONE MATRIX W/ SQUARE BRACES
	s(
		{ trig = "smtx", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left[
        \begin{array}{cc<>}
          a & b<>
        \end{array}
        \right]
      \end{align*}
      \vspace{-2em}
      ]],
			{
				i(1),
				i(2),
			}
		)
	),
	-- LONE MATRIX W/ CURLY BRACES
	s(
		{ trig = "cmtx", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left\{
        \begin{array}{cc<>}
          a & b<>
        \end{array}
        \right\}
      \end{align*}
      \vspace{-2em}
      ]],
			{
				i(1),
				i(2),
			}
		)
	),
	-- LONE MATRIX W/ VERTICAL BARS
	s(
		{ trig = "vmtx", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left|
        \begin{array}{cc<>}
          a & b<>
        \end{array}
        \right|
      \end{align*}
      \vspace{-2em}
      ]],
			{
				i(1),
				i(2),
			}
		)
	),
	-- LONE MATRIX W/ DOUBLE VERTICAL BARS
	s(
		{ trig = "Vmtx", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
      \setlength{\abovedisplayskip}{-0.5em}
      \begin{align*}
        \left\|
        \begin{array}{cc<>}
          a & b<>
        \end{array}
        \right\|
      \end{align*}
      \vspace{-2em}
      ]],
			{
				i(1),
				i(2),
			}
		)
	),

	-- NOTE: MATH SYNTAX

	-- FOR A SINGLE STRING OF PROGRAMMING FONT TEXT IN MATH MODE
	s(
		{ trig = "ttp", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("<>\\texttt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_alphanumeric_before }
	),
	-- FOR A SINGLE STRING OF PLAIN TEXT IN MATH MODE
	s(
		{ trig = "ttt", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("<>\\text{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- MATH BLACKBOARD i.e. \mathbb
	s(
		{ trig = "mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathbb{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- PAIRED CURLY BRACES IN MATH
	s({ trig = "\\{", wordTrig = false, snippetType = "autosnippet" }, {
		t("\\{"),
		d(1, get_visual),
		t("\\}"),
	}),
	-- BINOMIAL
	s(
		{ trig = "bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\binom{<>}{<>}", {
			i(1),
			i(2),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- INLINE VERBATIM (EXCL. START OF LINE)
	s(
		{ trig = "sd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\texttt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.no_single_alphanumeric_before }
	),
	-- DIFFERENTIAL SYMBOL W/ ONE SPACE PRECEDING, i.e. \diff
	s(
		{ trig = "ddd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\ d<>", {
			i(1),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- PARTIAL DERIVATIVE, i.e. \diff
	s(
		{ trig = "prt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\prt<>", {
			i(1),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- DEFINITE SINGLE INTEGRAL
	s(
		{ trig = "in1", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\int\\limits_{<>}^{<>}", {
			i(1),
			i(2),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- DEFINITE DOUBLE INTEGRAL SYMBOL
	s(
		{ trig = "in2", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\int\\limits_{<>}^{<>} \\int \\limits_{<>}^{<>}", {
			i(1),
			i(2),
			i(3),
			i(4),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- DEFINITE TRIPLE INTEGRAL SYMBOL
	s(
		{ trig = "in3", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\int\\limits_{<>}^{<>} \\int \\limits_{<>}^{<>} \\int \\limits_{<>}^{<>}", {
			i(1),
			i(2),
			i(3),
			i(4),
			i(5),
			i(6),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- CLOSED INTEGRAL SYMBOL
	s(
		{ trig = "oi1", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\oint_{C<>}", {
			i(1),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- CLOSED DOUBLE INTEGRAL SYMBOL
	s(
		{ trig = "oi2", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("\\oiint_{C<>}", {
			i(1),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- SUPERSCRIPT
	s(
		{ trig = "';", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.brackets_or_pipe_or_single_alphanumeric_before }
	),
	-- SUBSCRIPT
	s(
		{ trig = ";", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.brackets_or_pipe_or_single_alphanumeric_before }
	),
	-- SUBSCRIPT AND SUPERSCRIPT
	s(
		{ trig = "__", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = helpers.in_mathzone * helpers.brackets_or_pipe_or_single_alphanumeric_before }
	),
	-- FRACTION
	s(
		{ trig = "ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- FRACTION W/ built-in \displaystyle
	s(
		{ trig = "dff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dfrac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- DIFFERENTIATING W.R.T. x
	s(
		{ trig = "dfx", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dfrac{d<>}{dx}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- DIFFERENTIATING W.R.T. y
	s(
		{ trig = "dfy", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dfrac{d<>}{dy}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- DIFFERENTIATING W.R.T. _insert_own_variable_
	s(
		{ trig = "dfd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dfrac{d<>}{d<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- PARTIAL DERIVATIVE W.R.T. x
	s(
		{ trig = "pdx", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dfrac{\\prt <>}{\\prt x}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- PARTIAL DERIVATIVE W.R.T. y
	s(
		{ trig = "pdy", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dfrac{\\prt <>}{\\prt y}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- PARTIAL DERIVATIVE W.R.T. _insert_own_variable
	s(
		{ trig = "pdd", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dfrac{\\prt <>}{\\prt <>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- both upper and lower limit
	s(
		{ trig = "lmb", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\limits_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- lower limit only
	s(
		{ trig = "lml", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\limits_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- upper limit only
	s(
		{ trig = "lmu", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\limits^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_letter_before }
	),
	-- IMPLICATION
	s({ trig = ">>", snippetType = "autosnippet" }, {
		t("\\Rightarrow "),
	}, { condition = helpers.in_mathzone }),
	-- REVERSE IMPLICATION
	s({ trig = "<<", snippetType = "autosnippet" }, {
		t("\\Leftarrow "),
	}, { condition = helpers.in_mathzone }),
	-- ANGLE IN DEGREES
	s(
		{ trig = "dg", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\ang{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone * helpers.no_single_alphanumeric_before }
	),
	-- SQUARE ROOT 2
	s(
		{ trig = "sr2", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sqrt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone }
	),
	-- SQUARE ROOT n
	s(
		{ trig = "srn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sqrt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = helpers.in_mathzone }
	),

	-- NOTE: GREEK SYMBOLS

	s({ trig = ";d", snippetType = "autosnippet" }, {
		t("\\delta"),
	}),
	s({ trig = ";D", snippetType = "autosnippet" }, {
		t("\\Delta"),
	}),
	s({ trig = ";e", snippetType = "autosnippet" }, {
		t("\\epsilon"),
	}),
	s({ trig = ";ve", snippetType = "autosnippet" }, {
		t("\\varepsilon"),
	}),
	s({ trig = ";o", snippetType = "autosnippet" }, {
		t("\\theta"),
	}),
	s({ trig = ";vo", snippetType = "autosnippet" }, {
		t("\\vartheta"),
	}),
	s({ trig = ";O", snippetType = "autosnippet" }, {
		t("\\Theta"),
	}),
	s({ trig = ";l", snippetType = "autosnippet" }, {
		t("\\lambda"),
	}),
	s({ trig = ";m", snippetType = "autosnippet" }, {
		t("\\mu"),
	}),
	s({ trig = ";i", snippetType = "autosnippet" }, {
		t("\\pi"),
	}),
	s({ trig = ";I", snippetType = "autosnippet" }, {
		t("\\Pi"),
	}),
	s({ trig = ";s", snippetType = "autosnippet" }, {
		t("\\sigma"),
	}),
	s({ trig = ";S", snippetType = "autosnippet" }, {
		t("\\Sigma"),
	}),
	s({ trig = "tbs", snippetType = "autosnippet" }, {
		t("\\tb"),
	}),
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("\\alpha"),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("\\beta"),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("\\gamma"),
	}),
	s({ trig = ";pp", snippetType = "autosnippet" }, {
		t("\\partial"),
	}),
	--  s({ trig=";G", snippetType="autosnippet" },
	--    {
	--      t("\\Gamma"),
	--  }),
	--  s({ trig=";z", snippetType="autosnippet" },
	--    {
	--      t("\\zeta"),
	--  }),
	--  s({ trig=";h", snippetType="autosnippet" },
	--    {
	--      t("\\eta"),
	--  }),
	--  s({ trig=";k", snippetType="autosnippet" },
	--    {
	--      t("\\kappa"),
	--  }),
	--  s({ trig=";L", snippetType="autosnippet" },
	--    {
	--      t("\\Lambda"),
	--  }),
	--  s({ trig=";n", snippetType="autosnippet" },
	--    {
	--      t("\\nu"),
	--  }),
	--  s({ trig=";x", snippetType="autosnippet" },
	--    {
	--      t("\\xi"),
	--  }),
	--  s({ trig=";X", snippetType="autosnippet" },
	--    {
	--      t("\\Xi"),
	--  }),
	--  s({ trig=";r", snippetType="autosnippet" },
	--    {
	--      t("\\rho"),
	--  }),
	--  s({ trig=";t", snippetType="autosnippet" },
	--    {
	--      t("\\tau"),
	--  }),
	--  s({ trig=";c", snippetType="autosnippet" },
	--    {
	--      t("\\chi"),
	--  }),
	--  s({ trig=";p", snippetType="autosnippet" },
	--    {
	--      t("\\psi"),
	--  }),
	--  s({ trig=";P", snippetType="autosnippet" },
	--    {
	--      t("\\Psi"),
	--  }),
	--  s({ trig=";w", snippetType="autosnippet" },
	--    {
	--      t("\\omega"),
	--  }),
	--  s({ trig=";W", snippetType="autosnippet" },
	--    {
	--      t("\\Omega"),
	--  }),
}
