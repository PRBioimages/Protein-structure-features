function anglefeatures(outpath)
%  acc = arch1_evaluate(outpath)
% It merges the features from all Convolution Neural Networks and performs classification 
% using either SVM (linear and rbf) or kNN


netfnames=[{'angles1Dropout1relu1'}];
iter = 0 ;
retrain = 1; % 0 if you want to use precalculated results

for i=1:length(netfnames) 
    iter = iter +1;
    clear imdb net indtrain indtest

    netfname = netfnames{i};      
    angles = netfname(7); % string = '0' or '1'      
    load(fullfile(outpath, netfname,'options.mat'), 'opts') ;
    load(fullfile(opts.imdbPath,['imdb_' angles '.mat']), 'imdb') ;  
    indtrain = imdb.images.set == 1;
    indtest = imdb.images.set == 3;

    %% Network initialization  
    load(fullfile(opts.train.expDir, ['net-epoch-' num2str(opts.train.numEpochs) '.mat'])); % net, info loaded
    %vl_simplenn_display(net, 'batchSize', opts.train.batchSize) ;
    net.layers{end}.type = 'softmax'; % 'softmax', 'relu', 'sigmoid' % net.layers(end)=[];   
    %% Network evaluate on test data   
    modelfname='C:\Users\Dell\Desktop\PeerJ-master\Data\pdbmodel_demo.mat';
    perc_test=1;
    angles=1;
    [testdata, ~, ~] = convertMat2imdb(modelfname, angles, perc_test);
    res_test = vl_simplenn(net, testdata.images.data, [], [], 'accumulate', false) ;
    anglefeatures=res_test(16).x;
%     features_test = double((squeeze(res_test(end).x))'); % [numSamples x 6]
end
save('anglefeatures.mat','anglefeatures');
