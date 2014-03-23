" http://vim.1045645.n5.nabble.com/HTML-syntax-highlighting-underline-only-single-line-links-td1165249.html
syn clear htmlLink
syn match htmlLink "<a\>\_[^>]*\<href\>.*</a>"me=e-4
\ contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,
\htmlComment,javaScript,@htmlPreproc
