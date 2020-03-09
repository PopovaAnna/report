%������� ������ � ����������� (������������)
%���������� �������� ��� ���������� �������

%���� �� ����� ������� ��������� 
A = dlmread("input1.txt");
[n,n1] = size(A);%�����������
C = A;
%�������� ����������
p = zeros(1,n); %������ ��� ���������
s = zeros(n,1); %������ �������-�������
i2h = zeros(n,1);% ������ �������-�������

quantity = 0; 
%���������� ����������: quantity=n - ������� ���������
current = 1; %������� �������
while (quantity!=n)
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
%�������� ������� �������
c_f = 0;
for i=1:n
  c_f += C(i,s(i));
endfor
%�����
f = fopen("output.txt", "w");
fprintf(f,"Objective function = %d\n", c_f);
fprintf(f,"Human <-> Object\n");
for l=1:n
  fprintf(f,"%d <-> %d\n",l,s(l));
endfor
fclose(f);
