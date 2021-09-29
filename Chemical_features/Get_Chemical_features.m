function Get_Chemical_features()

error_protein=[];
variance_matrix=[];
coordinates=[];
num=1;
num2=1;
str2='.pdb';
pdb_list=importdata('.\Dataset\protein_name.xlsx');
for i=1:length(pdb_list.textdata)
    disp(i);
    str1=lower(pdb_list.textdata{i,1});
    str=strcat(str1,str2);
    str1='.\Dataset\pdb\';
    str_final=strcat(str1,str);
    try
        Amino_acid=Get_Amino_acid(str_final);
        [E,coordinates]=distance_get_ball(str_final,Amino_acid);
        if length(variance_matrix)==0
            variance_matrix=E;
        else
            variance_matrix=[variance_matrix;E];
        end
        if max(E)==0
            error_protein(num)=i;
            num=num+1;
        end
    catch
        error_protein(num)=i;
        num=num+1;
    end
end
save('.\Chemical_features\variance_matrix.mat','variance_matrix')
save('.\Chemical_features\error_protein.mat','error_protein')


surface_atom=zeros(1052,20);
for i=1:1052
    surface_atom(i,:)=variance_matrix(i,:)/sum(variance_matrix(i,:));
end

goal={'ARG LYS ASP GLU','GLN ASN HIS SER THR TYR CYS MET TRP','ALA LLE LUE PHE VAL PRO GLY',...
    'TYR TRP ALA LLE LUE PHE VAL PRO GLY','CYS MET','ARG LYS ASP GLU GLN ASN SER THR',...
    'GLN ASN SER THR CYS MET','TYR TRP PHE','ALA LLE LUE VAL','ASP GLU',...
    'ARG LYS HIS','ASP GLU','GLN ASN SER THR TYR CYS MET TRP ALA LLE LUE PHE VAL PRO GLY',...
    'ARG LYS HIS','LYS MET TRP ALA LUE PHE VAL GLY','LYS GLU CYS LLE PRO'};
acid=[{'ARG'},'LYS','ASP','GLU','GLN','ASN','HIS','SER','THR','TYR','CYS','MET','TRP','ALA','ILE','LUE','PHE','VAL','PRO','GLY'];
NH2=[9 10 9.6 10 9 9 9 9 9 9 11 9.2 9.4 9.9 10 9.6 9 9.7 11 9.6];
COOH=[2 9 1.9 2 2 2 2 2 2 2 1.7 2.3 2.4 2.4 2 2.4 3 2.3 2 2.3];
acid_feature=zeros(1052,16);
for i=1:1052
    for j=1:14
        for k=1:20
            if isempty(strfind(char(goal(1,j)),char(acid(1,k))))==0
                acid_feature(i,j)=surface_atom(i,k)+acid_feature(i,j);
            end
        end
    end
end
for i=1:1052
    for k=1:20
        acid_feature(i,15)=acid_feature(i,15)+surface_atom(i,k)*NH2(k);
    end
end
for i=1:1052
    for k=1:20
        acid_feature(i,16)=acid_feature(i,16)+surface_atom(i,k)*COOH(k);
    end
end

acid=[{'R'},'K','D','E','Q','N','H','S','T','Y','C','M','W','A','I','L','F','V','P','G'];
Dehydrating_hydrophobic_feature=zeros(1052,6);
for i=1:1052
    for k=1:20
        if (isempty(strfind('R D E N Q K H',char(acid(k))))==0)%Strong hydrophilicity
            Dehydrating_hydrophobic_feature(i,1)=Dehydrating_hydrophobic_feature(i,1)+surface_atom(i,k);
        end
        if (isempty(strfind('L I V A M F',char(acid(k))))==0)%Strong hydrophobicity
            Dehydrating_hydrophobic_feature(i,2)=Dehydrating_hydrophobic_feature(i,2)+surface_atom(i,k);
        end
        if (isempty(strfind('S T Y W',char(acid(k))))==0)%Weakly hydrophilic or weakly hydrophobic
            Dehydrating_hydrophobic_feature(i,3)=Dehydrating_hydrophobic_feature(i,3)+surface_atom(i,k);
        end
        if (isempty(strfind('P',char(acid(k))))==0)%Proline
            Dehydrating_hydrophobic_feature(i,4)=Dehydrating_hydrophobic_feature(i,4)+surface_atom(i,k);
        end
        if (isempty(strfind('G',char(acid(k))))==0)%Glycine
            Dehydrating_hydrophobic_feature(i,5)=Dehydrating_hydrophobic_feature(i,5)+surface_atom(i,k);
        end
        if (isempty(strfind('C',char(acid(k))))==0)%Cysteine
            Dehydrating_hydrophobic_feature(i,6)=Dehydrating_hydrophobic_feature(i,6)+surface_atom(i,k);
        end
    end
end

Chemical_features=[surface_atom acid_feature Dehydrating_hydrophobic_feature];
save('.\Feature\Chemical_features.mat','Chemical_features');