function [is_bad,s,c_f] = algorithm(n,A)
is_bad = 0;
c_f = 0;
C = A;
%создание переменных
p = zeros(1,n); %вектор цен предметов
s = zeros(n,1); %вектор предмет-человек
i2h = zeros(n,1);% вектор человек-предмет

quantity = 0; 
%количество назначений: quantity = n - условие окончани€
current = 1; %текуший человек
iter = 0; %количество итераций цикла
stop = 1000; %!!!!!!надо сделать чтобы зависела от n !!! например 3n
while (quantity!=n&&iter<stop)
  iter+=1;
  i = current; %обрабатываем текущего человека
  [max_el,ix] = max(A(i,:)); %максимальный элемент и его индекс дл€ i
  if (i2h(ix)==0)%предмет свободен
    s(i) = ix; %закрепл€ем этот предмет за i
    i2h(ix) = i; %предмет теперь зан€т
    quantity = quantity+1;
    current = quantity+1;%текущим становитс€ человек следующий, за всеми просмотренными
    continue;
  endif
  %предмет max_el зан€т
  assi = i2h(ix); %кем зан€т
  [v_i,ix_i,v_assi,ix_assi] = dispute(A(i,:),A(assi,:),ix); 
  %дальше решение через второй незан€тый максимум
  if (v_i == 0 && v_assi == 0)
    if (i2h(ix_assi)==0) 
      i2h(ix_assi) = assi;
      s(assi) = ix_assi;
      s(i) = ix;
      i2h(ix)= ix_assi;
      quantity = quantity+1;
      current = quantity+1;
      continue;
    endif
    if (i2h(ix_i)==0)
      i2h(ix_i) = i;
      s(i) = ix_i;
      quantity = quantity+1;
      current = quantity+1;
      continue;
    endif
  endif

  if (v_assi >= v_i)
%назначение не мен€етс€ у assi, мен€етс€ вектор цен и матрица
%i-му ничего не отдаем
  p(ix) = p(ix)+v_assi;
  A(:,ix) = A(:,ix) - v_assi;
  continue;
  endif
%i выиграл спор
%мен€етс€ вектор цен, предмет у assi-го отдаем i-му, мен€ем матрицу
  p(ix) = p(ix) + v_i; 
  s(assi) = 0;
  s(i) = ix;
  i2h(ix) =i;
  A(:,ix) = A(:,ix) - v_i;
  current = assi; 
endwhile

if (iter==stop)
  is_bad = 1;
else
%значение целевой функции
  for i=1:n
    c_f = c_f + C(i,s(i));
  endfor
endif
endfunction