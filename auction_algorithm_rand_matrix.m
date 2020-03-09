%������� ������ � ����������� (������������)
%���������� �������� ��� ���������� �������
clc
%���������� ������� ������� � �������
n = input ("Please print matrix size less than 20\n");
%��������� ������� ������� n
A = randi(20,n);%!!!!!!!!!����������� �� n 
C = A;
%�������� ����������
p = zeros(1,n); %������ ��� ���������
s = zeros(n,1); %������ �������-�������
i2h = zeros(n,1);% ������ �������-�������

quantity = 0; 
%���������� ����������: quantity = n - ������� ���������
current = 1; %������� �������
iter = 0; %���������� �������� �����
stop = 1000; %!!!!!!���� ������� ����� �������� �� n !!! �������� 3n
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
disp("Look at the file output.txt")
f2 = fopen("output.txt", "w"); %������� ����
%����� �������� �������
for i=1:n
  for j=1:n
    fprintf(f2, "%d ",C(i,j));
  endfor
  fprintf(f2, "\n");
endfor

if (iter==stop)
  fprintf(f2, "This matrix is bad");
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