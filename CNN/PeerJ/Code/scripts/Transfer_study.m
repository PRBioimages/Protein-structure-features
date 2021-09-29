load('D:\2020_10_30\PeerJ\Results\fold0\arch1\angles1Dropout1relu1\train\net-epoch-300.mat');
% f=1/100;
% numLastFilters=500;
% numLabels=5;
% net.layers{12} = struct('type', 'conv', ...
%                            'weights', {{f*randn(1,1,numLastFilters,numLabels, 'single'), zeros(1,numLabels,'single')}}, ...
%                            'stride', 1, ...
%                            'pad', 0) ;
% net.layers{13} = struct('type', 'softmaxloss') ;

% net.layers(13) = [];
