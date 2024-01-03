# setting vim.opts

/* lua */ ''
vim.g.mapleader = " "

-- save screenspace
vim.o.showmode = false -- remove the ' -- INSERT -- ' line at the bottom
vim.o.cmdheight = 0
vim.o.showtabline = 0

-- no mouse
vim.opt.mouse = ""

-- system clip
vim.opt.clipboard = "unnamed,unnamedplus"

-- line num
vim.opt.nu = false
vim.opt.relativenumber = false

-- split direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- tab settings
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- undo hist
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir/"
vim.opt.undofile = true

-- annoying persistent search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- scrolloff
vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 3

-- fold and conceal
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99 -- depth at which to start folding on file open
vim.opt.conceallevel = 1 -- conceals links and stuff
vim.opt.concealcursor = "n"

-- other
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.updatetime = 50
vim.opt.gcr = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.colorcolumn = "0"
vim.opt.timeoutlen = 500
vim.opt.showmode = false
''
