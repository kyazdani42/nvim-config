local M = {}

function M.get_colors()
  return {
    ['STNormalFlatMD'] = { guifg= '#32374d', guibg='#1b1e2b'},
    ['STNormalFlatInfo'] = { guifg= '#32374d', guibg='#1b1e2b'},

    ['STNormalMD'] = { guifg= '#ffffff', guibg='#292d3e'},
    ['STVisualMD'] = { guibg = '#89bbdd', guifg = '#292d3e' },
    ['STInsertMD'] = { guibg = '#b9a3eb', guifg='#292d3e' },
    ['STReplaceMD'] = { guibg = '#d0e7d0', guifg='#292d3e' },
    ['STTermMD'] = { guibg = '#959dcb', guifg='#292d3e' },

    ['STNormalInfo'] = { guifg= '#ffffff', guibg='#353b52'},
    ['STVisualInfo'] = { guifg = '#89bbdd', guibg='#353b52' },
    ['STInsertInfo'] = { guifg = '#b9a3eb', guibg='#353b52' },
    ['STReplaceInfo'] = { guifg = '#d0e7d0', guibg='#353b52' },
    ['STTermInfo'] = { guifg = '#959dcb', guibg='#353b52' },
    ['STGitBranch'] = { gui = 'bold', guifg = "#1b1e2b", guibg = "#959dcb"  },
  }
end

M.modes = {
  ['n']   = { color = '%#STNormalMD#', val = ' NORMAL ' },
  ['no']  = { color = '%#STNormalMD#', val = ' N-Operator Pending ' },

  ['v']   = { color = '%#STVisualMD#', val = ' VISUAL ' },
  ['V']   = { color = '%#STVisualMD#', val = ' V-LINE ' },
  ['\22'] = { color = '%#STVisualMD#', val = ' V-BLOCK ' },

  ['i']   = { color = '%#STInsertMD#', val = ' INSERT ' },
  ['ic']  = { color = '%#STInsertMD#', val = ' INSERT ' },
  ['ix']  = { color = '%#STInsertMD#', val = ' INSERT ' },

  ['R']   = { color = '%#STReplaceMD#', val = ' REPLACE ' },
  ['Rv']  = { color = '%#STReplaceMD#', val = ' V-REPLACE ' },

  ['t']   = { color = '%#STTermMD#', val = ' TERMINAL ' },

  ['s']   = { color = '%#STNormalFlatMD#', val = ' SELECT ' },
  ['S']   = { color = '%#STNormalFlatMD#', val = ' S-LINE ' },
  ['^S']  = { color = '%#STNormalFlatMD#', val = ' S-BLOCK ' },
  ['c']   = { color = '%#STNormalFlatMD#', val = ' COMMAND ' },
  ['cv']  = { color = '%#STNormalFlatMD#', val = ' VIM EX ' },
  ['ce']  = { color = '%#STNormalFlatMD#', val = ' EX ' },
  ['r']   = { color = '%#STNormalFlatMD#', val = ' PROMPT ' },
  ['rm']  = { color = '%#STNormalFlatMD#', val = ' MORE ' },
  ['r?']  = { color = '%#STNormalFlatMD#', val = ' CONFIRM ' },
  ['!']   = { color = '%#STNormalFlatMD#', val = ' SHELL ' },
}

M.groups = {
  normal = "%#Normal#",
  git = "%#STGitBranch#",
  cursorline = '%#CursorLine#',
  vertsplit = '%#VertSplit#',
  fname = '%#TabLineSel#'
}

return M
