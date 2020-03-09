function [v_i,ix_i,v_assi,ix_assi] = dispute(A_i,A_assi,ix)
  max_i_1 = A_i(ix); %максимум i_го
  max_assi_1 = A_assi(ix);% максимум assi-го
  sss = -2^20;
  A_i(ix) = sss;
  A_assi(ix) = sss;
  [max_i_2,ix_i] = max(A_i); %второй максимум для i
  [max_assi_2,ix_assi]=max(A_assi); %второй максимум для assi
  v_i = max_i_1 - max_i_2; %максимульная надбавка для i
  v_assi = max_assi_1 - max_assi_2;%максимульная надбавка для assi
endfunction
