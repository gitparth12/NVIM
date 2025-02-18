return {

  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local nvcat_header = {
      [[ ███╗░░██╗██╗░░░██╗░█████╗░░█████╗░████████╗ ]],
      [[ ████╗░██║██║░░░██║██╔══██╗██╔══██╗╚══██╔══╝ ]],
      [[ ██╔██╗██║╚██╗░██╔╝██║░░╚═╝███████║░░░██║░░░ ]],
      [[ ██║╚████║░╚████╔╝░██║░░██╗██╔══██║░░░██║░░░ ]],
      [[ ██║░╚███║░░╚██╔╝░░╚█████╔╝██║░░██║░░░██║░░░ ]],
      [[ ╚═╝░░╚══╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░ ]],
    }
    local cat_header = {
      [[ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ]],
      [[ ░░░░░░░░░░▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄░░░░░░░░░ ]],
      [[ ░░░░░░░░▄▀░░░░░░░░░░░░▄░░░░░░░▀▄░░░░░░░ ]],
      [[ ░░░░░░░░█░░▄░░░░▄░░░░░░░░░░░░░░█░░░░░░░ ]],
      [[ ░░░░░░░░█░░░░░░░░░░░░▄█▄▄░░▄░░░█░▄▄▄░░░ ]],
      [[ ░▄▄▄▄▄░░█░░░░░░▀░░░░▀█░░▀▄░░░░░█▀▀░██░░ ]],
      [[ ░██▄▀██▄█░░░▄░░░░░░░██░░░░▀▀▀▀▀░░░░██░░ ]],
      [[ ░░▀██▄▀██░░░░░░░░▀░██▀░░░░░░░░░░░░░▀██░ ]],
      [[ ░░░░▀████░▀░░░░▄░░░██░░░▄█░░░░▄░▄█░░██░ ]],
      [[ ░░░░░░░▀█░░░░▄░░░░░██░░░░▄░░░▄░░▄░░░██░ ]],
      [[ ░░░░░░░▄█▄░░░░░░░░░░░▀▄░░▀▀▀▀▀▀▀▀░░▄▀░░ ]],
      [[ ░░░░░░█▀▀█████████▀▀▀▀████████████▀░░░░ ]],
      [[ ░░░░░░████▀░░███▀░░░░░░▀███░░▀██▀░░░░░░ ]],
      [[ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ]],
    }
    local nvim_header = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.header.val = nvim_header

    _Gopts = {
      position = "center",
      hl = "Type",
      -- wrap = "overflow";
    }

    local function footer()
      return "Javascript can suck mo' nads"
    end

    dashboard.section.footer.val = footer()

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
