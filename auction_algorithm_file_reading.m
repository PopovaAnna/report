%��� ������ - �� ����������
%������� ������ � ����������� (������������)
%���������� �������� ��� ���������� �������
data="input6.txt";
result="output6.txt";
%���� �� ����� ������� ��������� 
A = dlmread(data)
[n,n1] = size(A);%�����������
C = A;
%�������� ����������
p = zeros(1,n); %������ ��� ���������
s = zeros(n,1); %������ �������-�������
i2h = zeros(n,1);% ������ �������-�������

quantity = 0; 
%���������� ����������: quantity=n - ������� ���������
current = 1; %������� �������
iter=0;
while (quantity!=n)
  iter++;
  if (iter>=n*5)
    f = fopen(result, "w");
    fprintf(f,"Looping: %s", data);
    fclose(f);
    dbquit
   end
i = current; %������������ �������� ��������
[max_el,ix] = max(A(i,:)); %������������ ������� � ��� ������ ��� i
if (i2h(ix)==0)%������� ��������
  s(i) = ix; %���������� ���� ������� �� i
  i2h(ix) = i; %������� ������ �����
  quantity ++;
  current = quantity+1;%������� ���������� ������� ���������, �� ����� ��������������
  continue;
endif
%������� max_el �����
assi = i2h(ix); %��� �����
[v_i,ix_i,v_assi,ix_assi] = dispute(A(i,:),A(assi,:),ix); 
if (v_assi >= v_i)
%���������� �� �������� � assi, �������� ������ ��� � �������
%i-�� ������ �� ������
p(ix) += v_assi;
A(:,ix) = A(:,ix) - v_assi;
continue;
endif
%i ������� ����
%�������� ������ ���, ������� � assi-�� ������ i-��, ������ �������
p(ix) += v_i; 
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
f = fopen(result, "w");
fprintf(f,"Good task: %s\n", data);
fprintf(f,"Iteration =  %d\n", iter);
fprintf(f,"Objective function = %d\n", c_f);
fprintf(f,"Human <-> Object | Price\n");
for l=1:n
  fprintf(f,"%d <-> %d |  %d\n",l,s(l),p(l));
endfor
fclose(f);
