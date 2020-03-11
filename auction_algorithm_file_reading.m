%ВСЕ ГОТОВО - НЕ ИСПРАВЛЯТЬ
%решение задачи о назначениях (максимизация)
%аукционный алгоритм для квадратной матрицы
data="input6.txt";
result="output6.txt";
%ввод из файла матрицы стоимости 
A = dlmread(data)
[n,n1] = size(A);%размерность
C = A;
%создание переменных
p = zeros(1,n); %вектор цен предметов
s = zeros(n,1); %вектор предмет-человек
i2h = zeros(n,1);% вектор человек-предмет

quantity = 0; 
%количество назначений: quantity=n - условие окончания
current = 1; %текуший человек
iter=0;
while (quantity!=n)
  iter++;
  if (iter>=n*5)
    f = fopen(result, "w");
    fprintf(f,"Looping: %s", data);
    fclose(f);
    dbquit
   end
i = current; %обрабатываем текущего человека
[max_el,ix] = max(A(i,:)); %максимальный элемент и его индекс для i
if (i2h(ix)==0)%предмет свободен
  s(i) = ix; %закрепляем этот предмет за i
  i2h(ix) = i; %предмет теперь занят
  quantity ++;
  current = quantity+1;%текущим становится человек следующий, за всеми просмотренными
  continue;
endif
%предмет max_el занят
assi = i2h(ix); %кем занят
[v_i,ix_i,v_assi,ix_assi] = dispute(A(i,:),A(assi,:),ix); 
if (v_assi >= v_i)
%назначение не меняется у assi, меняется вектор цен и матрица
%i-му ничего не отдаем
p(ix) += v_assi;
A(:,ix) = A(:,ix) - v_assi;
continue;
endif
%i выиграл спор
%меняется вектор цен, предмет у assi-го отдаем i-му, меняем матрицу
p(ix) += v_i; 
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
f = fopen(result, "w");
fprintf(f,"Good task: %s\n", data);
fprintf(f,"Iteration =  %d\n", iter);
fprintf(f,"Objective function = %d\n", c_f);
fprintf(f,"Human <-> Object | Price\n");
for l=1:n
  fprintf(f,"%d <-> %d |  %d\n",l,s(l),p(l));
endfor
fclose(f);
