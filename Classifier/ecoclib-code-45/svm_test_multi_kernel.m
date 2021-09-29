function [pred_label,p]=svm_test_multi_kernel(data,classifier,MyClassifparams)
parak='-t 4';
% idx_sda=MyClassifparams.idx_sda;
gamma=MyClassifparams.gamma;
% gamma=[0.9,0.9];
Yt=ones(size(data,1),1);
beta=classifier.result.beta;
model=classifier.result.model;
traindataHaralick=classifier.traindataHaralick;
traindataLBP=classifier.traindataLBP;
testdataHaralick=data(:,1:139);
testdataLBP=data(:,140:end);
Haralick=[traindataHaralick;testdataHaralick];
LBP=[traindataLBP;testdataLBP];
trLab=[1:size(traindataLBP,1)]';
teLab=[size(traindataLBP,1)+1:size(traindataLBP,1)+size(testdataLBP,1)]';
allK(:,:,1)=calckernel('rbf',gamma(1),Haralick); 
allK(:,:,2)=calckernel('rbf',gamma(2),LBP);


K=allK(trLab,trLab,:);
KT=allK(teLab,trLab,:);
tK=K(:,:,1)*beta(1);
tKT=KT(:,:,1)*beta(1);
for ii=2:length(beta)
     tK=tK+K(:,:,ii)*beta(ii);
     tKT=tKT+KT(:,:,ii)*beta(ii);
end
Yt=ones(size(testdataHaralick,1),1);
[pred_label,accuracy,p] = svmpredict(double(Yt), double([(1:length(Yt))', tKT]), model);
