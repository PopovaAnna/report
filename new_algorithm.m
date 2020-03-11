# новый алгоритм:
# берем каждый раз максимум, если есть конфликт, то пропускаем,
# проходим еще раз и опять берем по максимуму

data="newin.txt";
result="newout.txt";
%ввод из файла матрицы стоимости 
A = dlmread(data);
[n,n1] = size(A);%размерность
C = A;
%создание переменных
p = zeros(1,n); %вектор цен предметов
s = zeros(n,1); %вектор предмет-человек
i2h = zeros(n,1);% вектор человек-предмет

%первый проход - выбираем не занятые максимумы
for i=1:n
  [max_el,ix] = max(A(i,:));
  if (i2h(ix)==0)%предмет свободен
    s(i) = ix; %закрепляем этот предмет за i
    i2h(ix) = i; %предмет теперь занят
    continue;
  endif
endfor
%второй проход - среди не занятых берем максимумы
for i=1:n
  if (s(i)==0)
    max_vacant = 0;
    for j=1:n
      if ((A(i,j)>max_vacant) && (i2h(j)==0))
        max_vacant = A(i,j);
        i2h(j) = i;
        s(i) = j;
      endif
    endfor
  endif
endfor
%значение целевой функции
c_f = 0;
for i=1:n
  c_f += C(i,s(i));
endfor
%вывод
f = fopen(result, "w");
fprintf(f,"Objective function = %d\n", c_f);
fprintf(f,"Human <-> Object\n");
for l=1:n
  fprintf(f,"%d <-> %d\n",l,s(l));
endfor
fclose(f);