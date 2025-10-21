return {
    { 
        'nvim-mini/mini.surround',
        event =  { 'BufReadPre', 'BufNewFile' },
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
        event = 'InsertEnter',
        config = true
    },
    {
        'nvim-mini/mini.splitjoin',
        event =  { 'BufReadPre', 'BufNewFile' },
        config = true
    }
}
