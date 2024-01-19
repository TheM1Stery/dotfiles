require('Comment').setup({
    toggler = {
        -- if you're using other terminals use '<C-_>' but for some reason in kitty this didn't work, so i used '<C-/>'
        line = '<C-/>',
        block = '<C-\\>',
    },
    opleader = {
        -- look at the comment above
        line = '<C-/>',
        block = '<C-\\>',
    },
})

