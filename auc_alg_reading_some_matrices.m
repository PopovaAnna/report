%������� ������ � ����������� (������������)
%���������� �������� ��� ���������� �������
%
%���������� ������ (���������� �����) � ����� � ����� � ����

fin = fopen('input_some_matrices.txt' ,'rt');
number_of_matrices = fscanf(fin, '%d', 1);
matrix_size = fscanf(fin, '%d', 1);

for k = 1:number_of_matrices % ���� �� ���������� ������
  
for i = 1:matrix_size
    A(i,:) = fscanf(fin, '%d', matrix_size);%��������� � i-� ������ matrix_size ���������
endfor

[is_bad,s,c_f] = algorithm(matrix_size,A);

fout = fopen("output_some_matrices.txt", "w");
%����� �������� �������
for i=1:matrix_size
  for j=1:matrix_size
    fprintf(fout, "%d ",A(i,j));
  endfor
  fprintf(fout, "\n");
endfor

if (is_bad == 1)
  fprintf(fout, "This matrix is bad\n");
else
  fprintf(fout,"\nObjective function = %d\n", c_f);
  fprintf(fout,"Human <-> Object\n");
  for l=1:matrix_size
    fprintf(fout,"%d <-> %d\n",l,s(l));
  endfor
endif

endfor
fclose(fin);
fclose(fout);
