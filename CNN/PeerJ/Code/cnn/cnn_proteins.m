function [net, opts] = cnn_proteins(modelfname, fold,k, arch, varargin)
% [net, opts] = cnn_proteins(modelfname, fold)
% [net, opts] = cnn_proteins(modelfname, fold, opts)
%
% modelfname : input features. It will be converted to imdb structure the first time
% fold: Depending on the fold number (integer) a different set of samples (20%)
%       will be used for testing. If you want to train the network using all samples, put fold=0.
%       fold>=1 => cross validation
%       fold=0  => training (one sample is left out to avoid error messages b/c of empty structures)
%       fold<0  => testing, i.e. the imdb structure will be saved and then exit
%

demo = 0;
%% --------------------------------------------------------------------
%  Define options
opts.fold = fold;
opts.arch = arch;

% The current directory is the Code folder
opts.imdbPath = fullfile('.','CNN','PeerJ','Data');
if ~exist(opts.imdbPath, 'dir')%判断Code目录中有没有opts.imdbPath
    mkdir(opts.imdbPath);
end
opts.expDir = fullfile('.','CNN','PeerJ','Results',['fold' num2str(fold)]);
if ~exist(opts.expDir, 'dir')
    mkdir(opts.expDir) ;
end
expDir = [];
for i=1:length(varargin)
    expDir=[expDir num2str(varargin{i})];
end
disp(['Processing ' expDir]);
opts.expDir = fullfile(opts.expDir, expDir);
if ~exist(opts.expDir, 'dir')
    mkdir(opts.expDir) ;
end

opts.SPnorm = false ;
opts.Dropout = false;
opts.relu = false;
opts.angles = false;
[opts, varargin] = vl_argparse(opts, varargin) ;


if demo
    opts.train.batchSize = 30 ;
    opts.train.numEpochs = 40 ;
else
    if opts.arch==1   % Architecture 1
        opts.train.batchSize = 50 ;
        if opts.angles==0
            opts.train.numEpochs = 100 ;
        end
        if opts.angles==1
            opts.train.numEpochs = 50 ;
        end
    else              % Architecture 2
        opts.train.batchSize = 100 ;
        opts.train.numEpochs = 150 ;
    end
end

opts.train.continue = true ;
opts.train.gpus = [] ;
opts.train.learningRate = 0.0001;
% opts.train.learningRate = 0.001;

opts.train.expDir = fullfile(opts.expDir, 'train') ;
if ~exist(opts.train.expDir, 'dir')
    mkdir(opts.train.expDir) ;
end

opts = vl_argparse(opts, varargin) ; % here varargin={}
save(fullfile(opts.expDir,'options.mat'), 'opts') ;

%% --------------------------------------------------------------------
%% Convert model.mat to imdb structure
if fold>0,        perc_test = 0.2;
elseif fold==0,   perc_test = 0;
else              perc_test = 1;
end

imdbfname = fullfile(opts.imdbPath,['imdb_' num2str(opts.angles) '.mat']);
if ~exist(imdbfname,'file')
    [imdb, fnamestrain, fnamestest] = convertMat2imdb(modelfname, opts.angles, perc_test,k);
    save(imdbfname, 'imdb', 'fnamestrain', 'fnamestest') ;
end

%% load imdb structure in training or testing mode
load(imdbfname, 'imdb') ;
imdb.meta.fold = max(fold,1);
if fold<0
    disp([filename ' for testing created. Continue with cnn_predict.m ']);
    return
end


%% --------------------------------------------------------------------
if opts.arch==1
    % --------------------------------------------------------------------
    %       Train the network using all channels
    % --------------------------------------------------------------------
    
    %  Initialize network
    %     net = cnn_proteins_init(opts);
    if opts.angles==1
        load('.\CNN\PeerJ\Results\fold0\arch1\angles1Dropout1relu1\train\net-epoch-300.mat');
        for i=15:-1:10
            net.layers(i) = [];
        end
        f=1/100;
        numLastFilters=500;
        numLabels=4;
        numFilters=20;
        
        %         net.layers{end+1} = struct('type', 'bnorm', ...
        %                                     'weights', {{ones(numFilters, 1, 'single'), zeros(numFilters, 1, 'single')}});
        %
        %         net.layers{end+1} = struct('type', 'relu') ;
        %
        %         net.layers{end+1} = struct('type', 'pool', ...
        %                                    'method', 'max', ...
        %                                    'pool', [2 2], ...
        %                                    'stride', 2, ...
        %                                    'pad', 0) ;
        %
        %
        %         net.layers{end+1} = struct('type', 'conv', ...
        %                                    'weights', {{f*randn(5,5,numFilters,50, 'single'),zeros(1,50,'single')}}, ...
        %                                    'stride', 1, ...
        %                                    'pad', 0) ;
        %         net.layers{end+1} = struct('type', 'bnorm', ...
        %                                     'weights', {{ones(50, 1, 'single'), zeros(50, 1, 'single')}});
        %
        %         net.layers{end+1} = struct('type', 'relu') ;
        %
        %         net.layers{end+1} = struct('type', 'dropout','rate', 0.2) ; %0.5
        %
        %         net.layers{end+1} = struct('type', 'pool', ...
        %                                    'method', 'max', ...
        %                                    'pool', [2 2], ...
        %                                    'stride', 2, ...
        %                                    'pad', 0) ;
        
        net.layers{end+1} = struct('type', 'conv', ...
            'weights', {{f*randn(2,2,50,numLastFilters, 'single'),  zeros(1,numLastFilters,'single')}}, ...
            'stride', 1, ...
            'pad', 0) ;
        net.layers{end+1} = struct('type', 'bnorm', ...
            'weights', {{ones(numLastFilters, 1, 'single'), zeros(numLastFilters, 1, 'single')}});
        
        net.layers{end+1} = struct('type', 'relu') ;
        net.layers{end+1} = struct('type', 'dropout','rate', 0.2) ; %0.5
        net.layers{end+1} = struct('type', 'conv', ...
            'weights', {{f*randn(1,1,numLastFilters,numLabels, 'single'), zeros(1,numLabels,'single')}}, ...
            'stride', 1, ...
            'pad', 0) ;
        net.layers{end+1} = struct('type', 'softmaxloss') ;
        
        
    else
        load('.\CNN\PeerJ\Results\fold0\arch1\angles0Dropout0relu1\train\net-epoch-300.mat');
        for i=13:-1:9
            net.layers(i) = [];
        end
        f=1/100;
        numLastFilters=500;
        numLabels=4;
        numFilters=20;
        
        %         net.layers{end+1} = struct('type', 'bnorm', ...
        %                                     'weights', {{ones(numFilters, 1, 'single'), zeros(numFilters, 1, 'single')}});
        %
        %         net.layers{end+1} = struct('type', 'relu') ;
        %
        %         net.layers{end+1} = struct('type', 'pool', ...
        %                                    'method', 'max', ...
        %                                    'pool', [2 2], ...
        %                                    'stride', 2, ...
        %                                    'pad', 0) ;
        %
        %
        %         net.layers{end+1} = struct('type', 'conv', ...
        %                                    'weights', {{f*randn(5,5,numFilters,50, 'single'),zeros(1,50,'single')}}, ...
        %                                    'stride', 1, ...
        %                                    'pad', 0) ;
        %         net.layers{end+1} = struct('type', 'bnorm', ...
        %                                     'weights', {{ones(50, 1, 'single'), zeros(50, 1, 'single')}});
        %
        %         net.layers{end+1} = struct('type', 'relu') ;
        %
        %
        %         net.layers{end+1} = struct('type', 'pool', ...
        %                                    'method', 'max', ...
        %                                    'pool', [2 2], ...
        %                                    'stride', 2, ...
        %                                    'pad', 0) ;
        
        net.layers{end+1} = struct('type', 'conv', ...
            'weights', {{f*randn(2,2,50,numLastFilters, 'single'),  zeros(1,numLastFilters,'single')}}, ...
            'stride', 1, ...
            'pad', 0) ;
        net.layers{end+1} = struct('type', 'bnorm', ...
            'weights', {{ones(numLastFilters, 1, 'single'), zeros(numLastFilters, 1, 'single')}});
        
        net.layers{end+1} = struct('type', 'relu') ;
        net.layers{end+1} = struct('type', 'conv', ...
            'weights', {{f*randn(1,1,numLastFilters,numLabels, 'single'), zeros(1,numLabels,'single')}}, ...
            'stride', 1, ...
            'pad', 0) ;
        net.layers{end+1} = struct('type', 'softmaxloss') ;
        
        
    end
    %  Train
    
    net = cnn_train(net, imdb, @getBatch, opts.train, ...
        'val', find(imdb.images.set == 3)) ;
    
    
elseif opts.arch==2
    % --------------------------------------------------------------------
    %       Train one network per channel
    % --------------------------------------------------------------------
    
    % Initialize network
    net = cnn_proteins_init_perChannel(opts);
    
    %  Train
    numChannels = size(imdb.images.data,3);
    path2fold = opts.expDir;
    for c=1:numChannels
        opts.expDir = fullfile(path2fold, ['c' num2str(c)]);
        opts.train.expDir = fullfile(opts.expDir, 'train') ;
        if ~exist(opts.train.expDir, 'dir')
            mkdir(opts.train.expDir) ;
        end
        opts.train.expDir = fullfile(opts.expDir, 'train') ;
        if ~exist(opts.train.expDir, 'dir')
            mkdir(opts.train.expDir) ;
        end
        opts = vl_argparse(opts, varargin) ; % here varargin={}
        save(fullfile(opts.expDir,'options.mat'), 'opts') ;
        
        imdb1 = imdb;
        imdb1.images.data = imdb.images.data(:,:,c,:);
        imdb1.images.data_mean = imdb.images.data_mean(:,:,c);
        
        %% Train using the previous network as pre-training
        net = cnn_train(net, imdb1, @getBatch, opts.train, ...
            'val', find(imdb.images.set == 3)) ;
    end
end
