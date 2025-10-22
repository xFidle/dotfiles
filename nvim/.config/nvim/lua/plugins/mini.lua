return {
    {
        'nvim-mini/mini.surround',
        event =  { 'BufReadPre', 'BufNewFile' },
        opts = {}
    },
    {
        'nvim-mini/mini.pairs',
        event = 'InsertEnter',
        opts = {}
    },
    {
        'nvim-mini/mini.splitjoin',
        event =  { 'BufReadPre', 'BufNewFile' },
        opts = {}
    }
}
