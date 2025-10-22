vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(e)
        local function keymap(mode, keys, func, opts)
            local m = mode or 'n'
            local o = vim.tbl_deep_extend('error', { buffer = e.buf}, opts)
            vim.keymap.set(m, keys, func, o)
        end
        local fzf = require('fzf-lua')

        keymap('n', 'K', vim.lsp.buf.hover, {
            desc = 'Open documentation for symbol under cursor'
        })

        keymap('n', 'grK', vim.lsp.buf.signature_help, {
            desc = 'Open signature help for symbol under cursor'
        })

        keymap('n', 'grd', fzf.lsp_definitions, {
            desc = 'Find definitions'
        })

        keymap('n', 'grD', vim.lsp.buf.declaration, {
            desc = 'Find declarations'
        })

        keymap('n', 'grr', fzf.lsp_references, {
            desc = 'Find references'
        })

        keymap('n', 'gri', fzf.lsp_implementations, {
            desc = 'Goto implementation'
        })

        keymap('n', 'grt', fzf.lsp_typedefs, {
            desc = 'Goto type definition'
        })

        keymap('n', '<leader>cr', vim.lsp.buf.rename,{
            desc = 'Rename all references'
        })

        keymap('n', '<leader>ca', fzf.lsp_code_actions, {
            desc = 'Find possible code actions'
        })

    end
})

vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    float = { border = 'rounded', source = 'if_many' },
    virtual_text = { current_line = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        }
    }
})
