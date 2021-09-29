clear all
load('D:\2020_10_30\PeerJ-master\Data\bin=8 span=8È¥¸ßË¹\pdbmodel_demo.mat');
for i=1:1087
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
for j=1:8
    for i=1:1087
        disp(i);
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
        contact_features(i,:)=pro_Features;
    end
    path=['contact_features',num2str(j),'.mat'];
    save(path,'contact_features');
end

