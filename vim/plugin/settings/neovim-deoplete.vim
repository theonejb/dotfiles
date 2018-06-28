if has('nvim')
    let g:deoplete#omni_patterns = {}
    let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
    let g:deoplete#enable_at_startup = 1
    set completeopt=menu
    call deoplete#initialize()
end
