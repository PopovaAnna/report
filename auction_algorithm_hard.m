%������� ������ � ����������� (������������)
%���������� �������� ��� ���������� �������
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
%�������� ����������
p = zeros(1,n); %������ ��� ���������
s = zeros(n,1); %������ �������-�������
i2h = zeros(n,1);% ������ �������-�������

random_transposiotion = 0;
quantity = 0; 
%���������� ����������: quantity = n - ������� ���������
current = 1; %������� �������
iter = 0; %���������� �������� �����
stop = 1000;
while (quantity!=n&&iter<stop)
iter+=1;
i = current; %������������ �������� ��������
[max_el,ix] = max(A(i,:)); %������������ ������� � ��� ������ ��� i
if (i2h(ix)==0)%������� ��������
  s(i) = ix; %���������� ���� ������� �� i
  i2h(ix) = i; %������� ������ �����
  quantity = quantity+1;
  current = quantity+1;%������� ���������� ������� ���������, �� ����� ��������������
  continue;
endif
%������� max_el �����
assi = i2h(ix); %��� �����
[v_i,ix_i,v_assi,ix_assi] = dispute(A(i,:),A(assi,:),ix); 
%������ ������� ����� ������ ��������� ��������
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
  % ������ ������ � �������� ��� �������
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
%���������� �� �������� � assi, �������� ������ ��� � �������
%i-�� ������ �� ������
p(ix) = p(ix)+v_assi;
A(:,ix) = A(:,ix) - v_assi;
continue;
endif
%i ������� ����
%�������� ������ ���, ������� � assi-�� ������ i-��, ������ �������
p(ix) = p(ix) + v_i;
s(assi) = 0;
s(i) = ix;
i2h(ix) =i;
A(:,ix) = A(:,ix) - v_i;
current = assi; 
endwhile

%�����
f2 = fopen("output.txt", "w"); %������� ����
%����� �������� �������
for i=1:n
 for j=1:n
    fprintf(f2, "%d ",C(i,j));
 endfor
  fprintf(f2, "\n");
endfor

if (iter==stop)
  fprintf(f2, "Did not work out");
  else
%�������� ������� �������
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