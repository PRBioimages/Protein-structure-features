function CNN()

addpath(genpath('.\CNN\PeerJ\Code'));

addpath(genpath('.\CNN\PeerJ\matconvnet\matlab'))
run vl_setupnn
addpath(genpath('.\CNN\PeerJ\libsvm-master'), '-BEGIN');
addpath(genpath(pwd));
rootpath = pwd;
modelfname = fullfile(rootpath,'CNN','PeerJ','Data','pdbmodel_demo.mat');
list = fullfile(rootpath,'CNN','PeerJ','Data','list_peerj_train.txt');
% ramtrainPerResidue_train('list',list, 'modelfname', modelfname);
list = fullfile(rootpath,'CNN','PeerJ','Data','list_peerj_test.txt');
% ramtrainPerResidue_test('list',list, 'modelfname', modelfname);
fold = 1;
outpath = fullfile(rootpath,'CNN','PeerJ','Results','fold1');
for k=1:10
    try
        rmdir('.\CNN\PeerJ\Results\fold1','s');
        
    catch
        
    end
    opts = run_cnn_proteins(modelfname,fold,1,k);
    acc = arch1_evaluate(outpath,k);
end

Integration1('.\CNN\PeerJ\Results\1052_1000D');


