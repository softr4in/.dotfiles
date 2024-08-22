local helpers = require("softr4in.luasnip-helpers")
local get_date = helpers.get_date
local get_visual = helpers.get_visual
local line_begin_or_non_letter = helpers.line_begin_or_non_letter
local not_in_mathzone = helpers.not_in_mathzone

return {
	-- Autopair for parentheses
	s(
		{ trig = "(", wordTrig = false, snippetType = "autosnippet" },
		fmta("(<>)", {
			d(1, get_visual),
		})
	),
	-- Multiline autopair for curly braces
	s(
		{ trig = ";{", wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      {
        <>
      }
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- Autopair for curly braces
	s(
		{ trig = "{", wordTrig = false, snippetType = "autosnippet" },
		fmta("{<>}", {
			d(1, get_visual),
		})
	),
	-- Autopair for square braces
	s(
		{ trig = "[", wordTrig = false, snippetType = "autosnippet" },
		fmta("[<>]", {
			d(1, get_visual),
		})
	),
	-- Autopair for angled braces
	s(
		{ trig = "<", wordTrig = false, snippetType = "autosnippet" },
		fmt("<{}>", {
			d(1, get_visual),
		}),
		{ condition = not_in_mathzone }
	),
	-- Autopair for backticks
	s(
		{ trig = "`", wordTrig = false, snippetType = "autosnippet" },
		fmta("`<>`", {
			d(1, get_visual),
		})
	),
	-- Paired double quotes
	s(
		{ trig = '"', wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta('"<>"', {
			d(1, get_visual),
		}),
		{ condition = line_begin_or_non_letter * not_in_mathzone }
	),
	-- Paired single quotes
	s(
		{ trig = "'", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("'<>'", {
			d(1, get_visual),
		}),
		{ condition = line_begin_or_non_letter * not_in_mathzone }
	),
	-- Today's date in DD-MM-YYYY format
	s({ trig = "dmy" }, { f(get_date) }),
}
