function [is_bad,s,c_f] = algorithm(n,A)
is_bad = 0;
c_f = 0;
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

if (iter==stop)
  is_bad = 1;
else
%�������� ������� �������
  for i=1:n
    c_f = c_f + C(i,s(i));
  endfor
endif
endfunction