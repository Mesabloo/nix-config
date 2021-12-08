# Taken from https://gist.github.com/daboross/cb2967bb71d371327d270b4ebeae5d8c

# Extremely basic prolog highlighting for kakoune
# Updated 2018-05-14
#
# It's pretty functional, but it doesn't support all the fanciness it could.
# The main bad thing right now is that it doesn't differentiate between calls
# to other rules and atoms.
hook global BufCreate .*\.(pro|pl)? %{
    set-option buffer filetype prolog
}

add-highlighter shared/prolog regions
add-highlighter shared/prolog/double_string region %{(?<!\\)(?:\\\\)*\K"} %{(?<!\\)(?:\\\\)*"} fill string
add-highlighter shared/prolog/single_string region %{(?<!\\)(?:\\\\)*\K'} %{(?<!\\)(?:\\\\)*'} fill string
add-highlighter shared/prolog/inline-comment region '(?<!\$)%' '$' fill comment
add-highlighter shared/prolog/multiline-comment region '/\*' '\*/' fill comment
add-highlighter shared/prolog/code default-region group
add-highlighter shared/prolog/code/operator regex (:-|[,\.\-\+\*]) 0:operator
add-highlighter shared/prolog/code/variable regex \b[A-Z]\w* 0:variable
add-highlighter shared/prolog/code/constant regex \b[a-z]\w* 0:value
add-highlighter shared/prolog/code/decimal_number regex \b[0-9]+ 0:value
add-highlighter shared/prolog/code/floating_number regex \b[0-9]+\.[0-9]+ 0:value

# largely taken from https://github.com/mawww/kakoune/blob/
# 43f50c0852a6f95abbcdf81f9d3bab9eeefbde0d/rc/base/rust.kak#L42
define-command -hidden prolog-indent-on-new-line %~
    evaluate-commands -draft -itersel %<
        # copy % comments prefix and following white spaces
        try %{ execute-keys -draft k <a-x> s ^\h*\K%[!/]?\h* <ret> y gh j P }
        # preserve previous line indent
        try %{ execute-keys -draft \; K <a-&> }
        # filter previous line
        try %{ execute-keys -draft -itersel k <a-x> s \h+$ <ret> d }
        # indent after lines ending with ':-'
        try %{ execute-keys -draft k <a-x> <a-k> :-\h*$ <ret> j <a-gt> }
        # align to opening paren of previous line
        try %{ execute-keys -draft [( <a-k> \A\([^\n]+\n[^\n]*\n?\z <ret> s \A\(\h*.|.\z <ret> & }
    >
~

hook -group prolog-highlight global WinSetOption filetype=prolog %{
    add-highlighter window/ ref prolog
    hook window InsertChar \n -group prolog-indent prolog-indent-on-new-line
    # correct comment-block behavior
    set-option window comment_block_begin '/*'
    set-option window comment_block_end '*/'
    set-option window comment_line '%'
}

hook -group prolog-highlight global WinSetOption filetype=(?!prolog).* %{
    remove-highlighter window/prolog
    remove-hooks window prolog-indent
}
