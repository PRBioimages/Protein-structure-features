function Get_Dihedral_angle_features()

% Extract feature of dihedral angles

Dihedral_angle_features=[];
num=1;
str2='.pdb';
pdb_list=importdata('.\Dataset\protein_name.xlsx');
%     error_protein{num}=loc{k};
%     num=num+1;
for j=1:length(pdb_list.textdata)
    disp(j);
    str1=lower(pdb_list.textdata{j,1});
    str=strcat(str1,str2);
    str_final=strcat('.\Dataset\\pdb\',str);
    pdb_file=pdbread(str_final);
    try
        Rall = ramachandran(pdb_file, 'plot', 'none');
        R = Rall(1);
        for i=2:numel(Rall)
            if ~ismember(Rall(i).Chain,R.Chain)
                R.Angles = [R.Angles; Rall(i).Angles];
                R.ResidueNum = [R.ResidueNum; Rall(i).ResidueNum];
                R.ResidueName = [R.ResidueName; Rall(i).ResidueName];
                R.Chain = [R.Chain; Rall(i).Chain];
            end
        end
        
        delete = find(isempty(R.ResidueName) | isnan(sum(R.Angles,2)) );
        R.Angles(delete,:)=[];
        R.ResidueNum(delete)=[];
        R.ResidueName(delete)=[];
        %             subplot(2,1,1);
        %             plot(R.Angles(:,1));
        %             subplot(2,1,2);
        %             plot(R.Angles(:,2));
        E1=curve_feature(R.Angles(:,1)');
        E2=curve_feature(R.Angles(:,2)');
        feature=[E1 E2];
    catch
        feature=zeros(1,30);
    end
    Dihedral_angle_features=[Dihedral_angle_features;feature];
end
save('.\Feature\Dihedral_angle_features.mat','Dihedral_angle_features');
