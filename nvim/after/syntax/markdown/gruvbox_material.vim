if !exists('g:colors_name') || g:colors_name !=# 'gruvbox-material'
    finish
endif
if index(g:gruvbox_material_loaded_file_types, 'markdown') ==# -1
    call add(g:gruvbox_material_loaded_file_types, 'markdown')
else
    finish
endif
let s:configuration = gruvbox_material#get_configuration()
let s:palette = gruvbox_material#get_palette(s:configuration.background, s:configuration.foreground, s:configuration.colors_override)
" syn_begin: markdown {{{
" builtin: {{{
call gruvbox_material#highlight('markdownH1', s:palette.red, s:palette.none, 'bold')
call gruvbox_material#highlight('markdownH2', s:palette.orange, s:palette.none, 'bold')
call gruvbox_material#highlight('markdownH3', s:palette.yellow, s:palette.none, 'bold')
call gruvbox_material#highlight('markdownH4', s:palette.green, s:palette.none, 'bold')
call gruvbox_material#highlight('markdownH5', s:palette.blue, s:palette.none, 'bold')
call gruvbox_material#highlight('markdownH6', s:palette.purple, s:palette.none, 'bold')
call gruvbox_material#highlight('markdownUrl', s:palette.blue, s:palette.none, 'underline')
call gruvbox_material#highlight('markdownItalic', s:palette.none, s:palette.none, 'italic')
call gruvbox_material#highlight('markdownBold', s:palette.none, s:palette.none, 'bold')
call gruvbox_material#highlight('markdownItalicDelimiter', s:palette.grey1, s:palette.none, 'italic')
highlight! link markdownCode Green
highlight! link markdownCodeBlock Aqua
highlight! link markdownCodeDelimiter Aqua
highlight! link markdownBlockquote Grey
highlight! link markdownListMarker Red
highlight! link markdownOrderedListMarker Red
highlight! link markdownRule Purple
highlight! link markdownHeadingRule Grey
highlight! link markdownUrlDelimiter Grey
highlight! link markdownLinkDelimiter Grey
highlight! link markdownLinkTextDelimiter Grey
highlight! link markdownHeadingDelimiter Grey
highlight! link markdownLinkText Purple
highlight! link markdownUrlTitleDelimiter Green
highlight! link markdownIdDeclaration markdownLinkText
highlight! link markdownBoldDelimiter Grey
highlight! link markdownId Yellow
" }}}
" vim-markdown: https://github.com/gabrielelana/vim-markdown {{{
call gruvbox_material#highlight('mkdURL', s:palette.blue, s:palette.none, 'underline')
call gruvbox_material#highlight('mkdInlineURL', s:palette.purple, s:palette.none, 'underline')
call gruvbox_material#highlight('mkdItalic', s:palette.grey1, s:palette.none, 'italic')
highlight! link mkdCodeDelimiter Aqua
highlight! link mkdBold Grey
highlight! link mkdLink Purple
highlight! link mkdHeading Grey
highlight! link mkdListItem Red
highlight! link mkdRule Purple
highlight! link mkdDelimiter Grey
highlight! link mkdId Yellow
" }}}
" syn_end
" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
let s:configuration = gruvbox_material#get_configuration()
let s:palette = gruvbox_material#get_palette(s:configuration.background, s:configuration.foreground, s:configuration.colors_override)
" syn_begin: html/markdown/javascriptreact/typescriptreact {{{
" builtin: https://notabug.org/jorgesumle/vim-html-syntax {{{
call gruvbox_material#highlight('htmlH1', s:palette.red, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH2', s:palette.orange, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH3', s:palette.yellow, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH4', s:palette.green, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH5', s:palette.blue, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlH6', s:palette.purple, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlLink', s:palette.none, s:palette.none, 'underline')
call gruvbox_material#highlight('htmlBold', s:palette.none, s:palette.none, 'bold')
call gruvbox_material#highlight('htmlBoldUnderline', s:palette.none, s:palette.none, 'bold,underline')
call gruvbox_material#highlight('htmlBoldItalic', s:palette.none, s:palette.none, 'bold,italic')
call gruvbox_material#highlight('htmlBoldUnderlineItalic', s:palette.none, s:palette.none, 'bold,underline,italic')
call gruvbox_material#highlight('htmlUnderline', s:palette.none, s:palette.none, 'underline')
call gruvbox_material#highlight('htmlUnderlineItalic', s:palette.none, s:palette.none, 'underline,italic')
call gruvbox_material#highlight('htmlItalic', s:palette.none, s:palette.none, 'italic')
highlight! link htmlTag Green
highlight! link htmlEndTag Blue
highlight! link htmlTagN OrangeItalic
highlight! link htmlTagName OrangeItalic
highlight! link htmlArg Aqua
highlight! link htmlScriptTag Purple
highlight! link htmlSpecialTagName RedItalic
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link htmlTSText TSNone
if has('nvim-0.8.0')
  highlight! link @text.html htmlTSText
endif
" }}}
" syn_end
" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
