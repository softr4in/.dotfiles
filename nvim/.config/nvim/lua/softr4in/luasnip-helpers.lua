local M = {}

local ls = require("luasnip")
local cond_obj = require("luasnip.extras.conditions")
local sn = ls.snippet_node
local i = ls.insert_node

-- NOTE: Language-agnostic helper functions

local function get_date()
  return os.date("%d-%b-%Y")
end

-- This function helps to implements the equivalent of Ultisnip's visual placeholder feature.
-- i.e. in visual mode, cut selected string, press <Tab> to save it in SELECT_RAW.
-- After triggering snippet in insert mode, autoinsert the cut string in insert node.
local function get_visual(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

-- NOTE: LaTeX-specific helper functions

-- This function makes the snippet trigger only in math mode
local function in_mathzone()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- This function makes the snippet trigger only outside of math mode
local function not_in_mathzone()
  return not M.in_mathzone()
end

-- `line_begin` checks whether the text from beginning of line up to cursor position is all whitespace
local function line_begin(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

-- `non_letter` checks whether the single character before the snippet trigger is any of (space, colon, backtick,
-- equals, open curly bracket, open parenthesis or open square bracket)
local function non_letter(line_to_cursor, matched_trigger)
  return line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match('[ :`=%{%(%["]')
end

-- A logical OR of `line_begin` and `non_letter`
local function line_begin_or_non_letter(line_to_cursor, matched_trigger)
  local is_line_begin = line_begin(line_to_cursor, matched_trigger)
  local is_non_letter = non_letter(line_to_cursor, matched_trigger)
  return is_line_begin or is_non_letter
end

-- This function checks whether the single character before the snippet trigger is not an alphabetical character
-- This is useful for defining snippets not to trigger if it is preceded by an alphabetical character.
-- Example: for the snippet trigger ff , I don't want to trigger the snippet when typing, say, "buffet".
local function no_single_letter_before(line_to_cursor, matched_trigger)
  local char_before_trigger = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1))
  return char_before_trigger:match("%A") ~= nil
end

-- This function checks whether the single character before the snippet trigger is not an alphanumeric character
-- This is useful for defining snippets not to trigger if it is preceded by an alphanumeric character.
local function no_single_alphanumeric_before(line_to_cursor, matched_trigger)
  local char_before_trigger = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1))
  return char_before_trigger:match("%W") ~= nil
end

-- This function checks whether there is a single whitespace preceding the snippet trigger.
local function single_whitespace_before(line_to_cursor, matched_trigger)
  local char_before_trigger = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1))
  return char_before_trigger:match("%s") ~= nil
end

-- This function checks whether the single character before the snippet trigger is an alphanumeric character or ) ] } |
-- This is useful for defining snippets that trigger just after closing brackets or alphabetically named math objects.
-- Example: _{} is the LaTeX syntax for subscript and must be affixed to a math object.
local function brackets_or_pipe_or_single_alphanumeric_before(line_to_cursor, matched_trigger)
  local char_before_trigger = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1))
  return char_before_trigger:match("[%w%)%]%}|]") ~= nil
end

M.get_date = cond_obj.make_condition(get_date)
M.get_visual = cond_obj.make_condition(get_visual)

M.in_mathzone = cond_obj.make_condition(in_mathzone)
M.not_in_mathzone = cond_obj.make_condition(not_in_mathzone)
M.line_begin = cond_obj.make_condition(line_begin)
M.non_letter = cond_obj.make_condition(non_letter)
M.line_begin_or_non_letter = cond_obj.make_condition(line_begin_or_non_letter)
M.no_single_letter_before = cond_obj.make_condition(no_single_letter_before)
M.no_single_alphanumeric_before = cond_obj.make_condition(no_single_alphanumeric_before)
M.single_whitespace_before = cond_obj.make_condition(single_whitespace_before)
M.brackets_or_pipe_or_single_alphanumeric_before = cond_obj.make_condition(
  brackets_or_pipe_or_single_alphanumeric_before)

return M
