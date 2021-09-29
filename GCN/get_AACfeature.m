function AACfeature=get_AACfeature(aminoAcids,T)
acid_eigenvector=[0.171 -0.361 0.107 -0.258 -0.364;
    0.243 -0.339 -0.044 -0.325 -0.027;
    0.303 -0.057 -0.014 0.225 0.156;
    0.221 -0.280 -0.315 0.157 0.303;
    0.149 -0.184 -0.030 0.035 -0.112;
    0.255 0.038 0.117 0.118 -0.055;
    0.023 -0.177 0.041 0.280 -0.021;
    0.199 0.238 -0.015 -0.068 -0.196;
    0.068 0.147 -0.015 -0.132 -0.274;
    -0.141 -0.057 0.425 -0.096 -0.091;
    -0.132 0.174 0.070 0.565 -0.374;
    -0.239 -0.141 -0.155 0.321 0.077;
    -0.296 -0.186 0.389 0.083 0.297;
    0.008 0.134 -0.475 -0.039 0.181;
    -0.353 0.071 -0.088 -0.195 -0.107;
    -0.267 0.018 -0.265 -0.274 0.206;
    -0.329 -0.023 0.072 -0.002 0.208;
    -0.274 0.136 -0.187 -0.196 -0.299;
    0.173 0.286 0.407 -0.215 0.384;
    0.218 0.562 -0.024 0.018 0.106];
AACfeature=[];
acid={'ARG','LYS','ASP','GLU','GLN','ASN','HIS','SER','THR','TYR','CYS','MET','TRP','ALA','ILE','LEU','PHE','VAL','PRO','GLY'};
mid_feature=zeros(1,20);
for i=1:T
    for k=1:length(acid)
        if strcmp(aminoAcids{1,i},acid{1,k})==1
            mid_feature(k)=mid_feature(k)+1;
        end
    end
end
mid_AACfeature=mid_feature;


goal={'ARG LYS ASP GLU','GLN ASN HIS SER THR TYR CYS MET TRP','ALA LLE LUE PHE VAL PRO GLY',...
    'TYR TRP ALA LLE LUE PHE VAL PRO GLY','CYS MET','ARG LYS ASP GLU GLN ASN SER THR',...
    'GLN ASN SER THR CYS MET','TYR TRP PHE','ALA LLE LUE VAL','ASP GLU',...
    'ARG LYS HIS','ASP GLU','GLN ASN SER THR TYR CYS MET TRP ALA LLE LUE PHE VAL PRO GLY',...
    'ARG LYS HIS','LYS MET TRP ALA LUE PHE VAL GLY','LYS GLU CYS LLE PRO'};

NH2=[9 10 9.6 10 9 9 9 9 9 9 11 9.2 9.4 9.9 10 9.6 9 9.7 11 9.6];
COOH=[2 9 1.9 2 2 2 2 2 2 2 1.7 2.3 2.4 2.4 2 2.4 3 2.3 2 2.3];
acid_feature=zeros(1,16);

for j=1:14
    for k=1:20
        if isempty(strfind(char(goal(1,j)),char(acid(1,k))))==0
            acid_feature(1,j)=mid_AACfeature(1,k)+acid_feature(1,j);
        end
    end
end

for k=1:20
    acid_feature(1,15)=acid_feature(1,15)+mid_AACfeature(1,k)*NH2(k);
end
for k=1:20
    acid_feature(1,16)=acid_feature(1,16)+mid_AACfeature(1,k)*COOH(k);
end

acid=[{'R'},'K','D','E','Q','N','H','S','T','Y','C','M','W','A','I','L','F','V','P','G'];
Dehydrating_hydrophobic_feature=zeros(1,6);

for k=1:20
    if (isempty(strfind('R D E N Q K H',char(acid(k))))==0)
        Dehydrating_hydrophobic_feature(1,1)=Dehydrating_hydrophobic_feature(1,1)+mid_AACfeature(1,k);
    end
    if (isempty(strfind('L I V A M F',char(acid(k))))==0)
        Dehydrating_hydrophobic_feature(1,2)=Dehydrating_hydrophobic_feature(1,2)+mid_AACfeature(1,k);
    end
    if (isempty(strfind('S T Y W',char(acid(k))))==0)
        Dehydrating_hydrophobic_feature(1,3)=Dehydrating_hydrophobic_feature(1,3)+mid_AACfeature(1,k);
    end
    if (isempty(strfind('P',char(acid(k))))==0)
        Dehydrating_hydrophobic_feature(1,4)=Dehydrating_hydrophobic_feature(1,4)+mid_AACfeature(1,k);
    end
    if (isempty(strfind('G',char(acid(k))))==0)
        Dehydrating_hydrophobic_feature(1,5)=Dehydrating_hydrophobic_feature(1,5)+mid_AACfeature(1,k);
    end
    if (isempty(strfind('C',char(acid(k))))==0)
        Dehydrating_hydrophobic_feature(1,6)=Dehydrating_hydrophobic_feature(1,6)+mid_AACfeature(1,k);
    end
end

AACfeature=[mid_AACfeature/T,acid_feature/T,Dehydrating_hydrophobic_feature/T];