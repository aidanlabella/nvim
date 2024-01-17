-- vim.api.nvim_exec(
-- [[
--     let g:dashboard_default_executive ='telescope'
-- 
-- ]],
-- false)

db = {
    theme = 'doom',
    config = {
        header = {
         '         //                 /*          ',
         '      ,(/(//,               *###        ',
         '    ((((((////.             /####%*     ',
         ' ,/(((((((/////*            /########   ',
         '/*///((((((//////.          *#########/ ',
         '//////((((((((((((/         *#########/.',
         '////////((((((((((((*       *#########/.',
         '/////////(/(((((((((((      *#########(.',
         '//////////.,((((((((((/(    *#########(.',
         '//////////.  /(((((((((((,  *#########(.',
         '(////////(.    (((((((((((( *#########(.',
         '(////////(.     ,#((((((((((##########(.',
         '((//////((.       /#((((((((##%%######(.',
         '((((((((((.         #(((((((####%%##%#(.',
         '((((((((((.          ,((((((#####%%%%%(.',
         ' .#(((((((.            (((((#######%%   ',
         '    /(((((.             .(((#%##%%/*    ',
         '      ,(((.               /(#%%#        ',
         '        ./.                 #*          ',
         '',
         '',
         '',
         '',
         '',
         '',
        },
        center = {
            {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Find File(s)',
                desc_hl = 'String',
                key = '1',
                keymap = 'SPC f f',
                key_hl = 'Number',
                action = 'Telescope find_files'
            },
            {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Recent Files',
                desc_hl = 'String',
                key = '2',
                keymap = 'SPC f r',
                key_hl = 'Number',
                action = 'Telescope oldfiles'
            },
            {
                icon = '󱏒 ',
                icon_hl = 'Title',
                desc = 'Edit Directory (oil)',
                desc_hl = '@function',
                key = '3',
                keymap = 'SPC f o',
                key_hl = 'Number',
                action = 'Oil'
            },
            {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Recent Commands',
                desc_hl = '@function',
                key = '4',
                keymap = 'SPC n h',
                key_hl = 'Number',
                action = 'Telescope command_history'
            },
            {
                icon = ' ',
                desc = 'Open Git Status',
                key = '5',
                desc_hl = '@keyword',
                keymap = 'SPC g g',
                action = 'Neogit'
            },
            {
                icon = ' ',
                desc = 'Open Git Log (tree format)',
                key = '6',
                desc_hl = '@keyword',
                keymap = 'SPC g v',
                action = 'GV'
            },
        },
        footer = {
            '',
            '',
            '',
            '',
            '🔥🔥 NeoVim - Aidan\'s IDE! 🔥🔥',
            'Authored and maintained by Aidan LaBella.',
            '🐻 alabella@brown.edu 🐅',
        }
    }
}

require('dashboard').setup(db)
