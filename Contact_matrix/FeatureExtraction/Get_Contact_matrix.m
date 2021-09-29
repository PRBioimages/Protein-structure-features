function Get_Contact_matrix()

% Extract feature of contact distance matrix,If you delete
% pdbmodel_demo.mat by mistake, please uncomment the following and re-run the code.

% modelfname = '.\Contact_matrix\Data\pdbmodel_demo.mat';
% list = '.\Contact_matrix\Data\list_demo.txt';
% ramtrainPerResidue('list',list, 'modelfname', modelfname);

load('.\Contact_matrix\Data\pdbmodel_demo.mat');
for i=1:1052
    disp(i);
    for m=1:20
        for n=m:20
            a=reshape(contactMaps(i,m,n,:),1,8);
            if sum(a)==0
                
            else
                a=a/sum(a);
            end
            contactMaps(i,m,n,:)=a;
        end
    end
end

contact_features=[];
for i=1:1052
    disp(i);
    mid_feature=[];
    for j=1:8
        a=contactMaps(i,:,:,:);
        b=reshape(a,20,20,8);
        pro_Features=[];
        per_haralickfeatures=[];
        
        c=reshape(b(:,:,j),20,20);
        for m=1:20
            for n=m:20
                pro_Features=[pro_Features c(m,n)];
            end
        end
        mid_feature=[mid_feature pro_Features];
        
    end
    contact_features(i,:)=mid_feature;
end

save('.\Feature\contact_features.mat','contact_features');
