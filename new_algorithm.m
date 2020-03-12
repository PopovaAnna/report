# ����� ��������:
# ����� ������ ��� ��������, ���� ���� ��������, �� ����������,
# �������� ��� ��� � ����� ����� �� ���������

data="newin.txt";
result="newout.txt";
%���� �� ����� ������� ��������� 
A = dlmread(data);
[n,n1] = size(A);%�����������
C = A;
%�������� ����������
p = zeros(1,n); %������ ��� ���������
s = zeros(n,1); %������ �������-�������
i2h = zeros(n,1);% ������ �������-�������

%������ ������ - �������� �� ������� ���������
for i=1:n
  [max_el,ix] = max(A(i,:));
  if (i2h(ix)==0)%������� ��������
    s(i) = ix; %���������� ���� ������� �� i
    i2h(ix) = i; %������� ������ �����
    %A(:,ix) = 0;
    continue;
  endif
endfor
for i=1:n
  if (s(i)!=0)
    A(:,s(i))=0;
  endif
endfor
%������ ������ - ����� �� ������� ����� ���������
for i=1:n
  if (s(i)==0)
    [max_el,ix] = max(A(i,:));
    s(i) = ix; 
    i2h(ix) = i;
    A(:,ix) = 0;
  endif
endfor
%�������� ������� �������
c_f = 0;
for i=1:n
  c_f += C(i,s(i));
endfor
%�����
f = fopen(result, "w");
fprintf(f,"Objective function = %d\n", c_f);
fprintf(f,"Human <-> Object\n");
for l=1:n
  fprintf(f,"%d <-> %d\n",l,s(l));
endfor
fclose(f);