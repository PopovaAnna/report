%решение задачи о назначени€х (максимизаци€)
%аукционный алгоритм дл€ квадратной матрицы
clc
clear all
C = [7 26 35 25 27 23; 
9 4 2 15 31 22; 
28 19 13 23 34 11; 
28 16 10 27 35 5; 
25 11 3 27 24 24;
23 16 24 21 20 17]
A = C;
n = 6;
%создание переменных
p = zeros(1,n); %вектор цен предметов
s = zeros(n,1); %вектор предмет-человек
i2h = zeros(n,1);% вектор человек-предмет

random_transposiotion = 0;
quantity = 0; 
%количество назначений: quantity = n - условие окончани€
current = 1; %текуший человек
iter = 0; %количество итераций цикла
stop = 1000;
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
if (v_i == 0 & v_assi == 0)
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
  % мен€ем строки и начинаем все сначала
  r = randperm(n);
  for k = 1:n
    A(k,:) = C(r(k),:);
  endfor
  C = A;
  p = zeros(1,n);
  s = zeros(n,1); 
  i2h = zeros(n,1);
  quantity = 0; 
  current = 1; 
  random_transposiotion = random_transposiotion + 1; 
  continue;
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

%вывод
f2 = fopen("output.txt", "w"); %открыли файл
%вывод исходной матрицы
for i=1:n
 for j=1:n
    fprintf(f2, "%d ",C(i,j));
 endfor
  fprintf(f2, "\n");
endfor

if (iter==stop)
  fprintf(f2, "Did not work out");
  else
%значение целевой функции
c_f = 0;
  for i=1:n
   c_f = c_f + C(i,s(i));
  endfor
fprintf(f2,"\nObjective function = %d\n", c_f);
fprintf(f2,"Human <-> Object\n");
  for l=1:n
  fprintf(f2,"%d <-> %d\n",l,s(l));
  endfor
endif
fclose(f2);