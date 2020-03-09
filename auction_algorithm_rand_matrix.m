%решение задачи о назначениях (максимизация)
%аукционный алгоритм для квадратной матрицы
clc
%считывание размера матрицы с консоли
n = input ("Please print matrix size less than 20\n");
%случайная матрица размера n
A = randi(20,n);%!!!!!!!!!зависимлсть от n 
C = A;
%создание переменных
p = zeros(1,n); %вектор цен предметов
s = zeros(n,1); %вектор предмет-человек
i2h = zeros(n,1);% вектор человек-предмет

quantity = 0; 
%количество назначений: quantity = n - условие окончания
current = 1; %текуший человек
iter = 0; %количество итераций цикла
stop = 1000; %!!!!!!надо сделать чтобы зависела от n !!! например 3n
while (quantity!=n&&iter<stop)
iter+=1;
i = current; %обрабатываем текущего человека
[max_el,ix] = max(A(i,:)); %максимальный элемент и его индекс для i
if (i2h(ix)==0)%предмет свободен
  s(i) = ix; %закрепляем этот предмет за i
  i2h(ix) = i; %предмет теперь занят
  quantity = quantity+1;
  current = quantity+1;%текущим становится человек следующий, за всеми просмотренными
  continue;
endif
%предмет max_el занят
assi = i2h(ix); %кем занят
[v_i,ix_i,v_assi,ix_assi] = dispute(A(i,:),A(assi,:),ix); 
%дальше решение через второй незанятый максимум
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
%назначение не меняется у assi, меняется вектор цен и матрица
%i-му ничего не отдаем
p(ix) = p(ix)+v_assi;
A(:,ix) = A(:,ix) - v_assi;
continue;
endif
%i выиграл спор
%меняется вектор цен, предмет у assi-го отдаем i-му, меняем матрицу
p(ix) = p(ix) + v_i; 
s(assi) = 0;
s(i) = ix;
i2h(ix) =i;
A(:,ix) = A(:,ix) - v_i;
current = assi; 
endwhile

%вывод
disp("Look at the file output.txt")
f2 = fopen("output.txt", "w"); %открыли файл
%вывод исходной матрицы
for i=1:n
  for j=1:n
    fprintf(f2, "%d ",C(i,j));
  endfor
  fprintf(f2, "\n");
endfor

if (iter==stop)
  fprintf(f2, "This matrix is bad");
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