function res = maxx(row)
  max_el = -1;
  res = [];
  [n1,n] = size(row);
  for i=1:n
    if (row(i)>max_el)
      res = i;
      max_el = row(i);
      continue;
    endif
    if (row(i)==max_el)
      res = [res,i];
      continue;
    endif
  endfor
endfunction
