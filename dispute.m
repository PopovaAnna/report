function [v_i,ix_i,v_assi,ix_assi] = dispute(A_i,A_assi,ix)
  max_i_1 = A_i(ix); %�������� i_��
  max_assi_1 = A_assi(ix);% �������� assi-��
  sss = -2^20;
  A_i(ix) = sss;
  A_assi(ix) = sss;
  [max_i_2,ix_i] = max(A_i); %������ �������� ��� i
  [max_assi_2,ix_assi]=max(A_assi); %������ �������� ��� assi
  v_i = max_i_1 - max_i_2; %������������ �������� ��� i
  v_assi = max_assi_1 - max_assi_2;%������������ �������� ��� assi
endfunction
