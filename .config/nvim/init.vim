function! Dot(path)
  return "~/.config/nvim/" . a:path
endfunction

for file in split(glob(Dot('rc.d/*.vim')), '\n')
  exec 'source' file
endfor
