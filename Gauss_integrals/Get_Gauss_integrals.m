function Get_Gauss_integrals()
% git_match
clear all
loc={'cyt','mit',...
    'nuc','pla'};
pdb_list=importdata('.\Dataset\protein_name.xlsx');
match_num=0;
Gauss_integral_features=zeros(1052,31);
for i=1:length(loc)
    disp(loc{i});
    path=['.\Gauss_integrals\Git_result\',loc{i},'.git'];
    git_list=importdata(path);
    for j=1:length(git_list.textdata)
        for k=1:length(pdb_list.textdata)
            if ~contains(char(git_list.textdata(j)),char(pdb_list.textdata{k,1}))==0
                match_num=match_num+1;
                Gauss_integral_features(match_num,:)=git_list.data(j,2:32);
            end
        end
    end
    disp(match_num);
end
save('.\Feature\Gauss_integral_features.mat','Gauss_integral_features');