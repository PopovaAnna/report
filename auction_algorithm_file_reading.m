%решение задачи о назначениях (максимизация)
%аукционный алгоритм для квадратной матрицы

%ввод из файла матрицы стоимости 
A = dlmread("input1.txt");
[n,n1] = size(A);%размерность
C = A;
%создание переменных
p = zeros(1,n); %вектор цен предметов
s = zeros(n,1); %вектор предмет-человек
i2h = zeros(n,1);% вектор человек-предмет

quantity = 0; 
%количество назначений: quantity=n - условие окончания
current = 1; %текуший человек
while (quantity!=n)
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
%значение целевой функции
c_f = 0;
for i=1:n
  c_f += C(i,s(i));
endfor
%вывод
f = fopen("output.txt", "w");
fprintf(f,"Objective function = %d\n", c_f);
fprintf(f,"Human <-> Object\n");
for l=1:n
  fprintf(f,"%d <-> %d\n",l,s(l));
endfor
fclose(f);
