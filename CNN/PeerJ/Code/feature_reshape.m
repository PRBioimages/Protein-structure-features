load('contactfeatures.mat');
a=size(contactfeatures);

feature=[];
for i=1:1903
   feature_mid=reshape(contactfeatures(:,:,:,i),1,6);
   feature=[feature;feature_mid];
end
contact_features=[feature(1:383,:);zeros(1,6);feature(384:end,:)];
save('contact_features.mat','contact_features');

load('anglefeatures.mat');
a=size(anglefeatures);
feature=[];
for i=1:1903
   feature_mid=reshape(anglefeatures(:,:,:,i),1,6);
   feature=[feature;feature_mid];
end
angle_features=[feature(1:383,:);zeros(1,6);feature(384:end,:)];
save('angle_features.mat','angle_features');

