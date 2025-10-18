return {
    { 
        'nvim-mini/mini.surround',
        opts = {
            mappings = {
                add = 'gsa',
                delete = 'gsd',
                fwnd = 'gsf',
                find_left = 'gsF',
                highlight = 'gsh',
                replace = 'gsr',
                update_n_lines = 'gsn'
            }
        },
        config = true
    },
    {
        'nvim-mini/mini.pairs',
        config = true
    },
    {
        'nvim-mini/mini.splitjoin',
        config = true
    }
}
