% load('D:\2021_2_20\off_diagonal_submatrix\sub_matrix_step5_size10\1\7.mat');
% matrix1=submatrix;
% load('D:\2021_2_20\off_diagonal_submatrix\sub_matrix_step5_size10\1\2.mat');
% matrix2=submatrix;

% matrix1=X(1,:);
% matrix2=X(9,:);
% 
% t_distance=norm(matrix1(:)-matrix2(:));

selected_pro=[];
for i =1:1904
   if pro_num(i,1)==2
       selected_pro=[selected_pro i];
   end
end
