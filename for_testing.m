A = [18 18 18 19;
16 17 18 19;
16 16 17 17;
17 17 17 16]
[n,n1] = size(A);

for i = 1:n
  v = maxx(A(i,:))
endfor
