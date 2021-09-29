function [traindata,testdata] = featnorm( traindata,testdata)
% [NORMTRAIN,NORMTEST] = FEATNORM( TRAINDATA, TESTDATA)
% 
% Normalizes traindata values (by column) from -1 to 1 
% (NORMTRAIN), then uses this to normalize testdata (by 
% column) (NORMTEST). NORMTEST is finally truncate so 
% values from are bounded between 0 to 1. 
% 
% Last modified Justin Newberg 23 October 2007

% Copyright (C) 2006  Murphy Lab
% Carnegie Mellon University
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published
% by the Free Software Foundation; either version 2 of the License,
% or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
%
% For additional information visit http://murphylab.web.cmu.edu or
% send email to murphy@cmu.edu

MItrain = min(traindata,[],1);
MAtrain = MItrain;
for i=1:size(traindata,2)
        traindata(:,i) = traindata(:,i) - MItrain(i);
        MAtrain(i) = max(traindata(:,i));
        traindata(:,i) = traindata(:,i) / MAtrain(i);
end

for i=1:size(testdata,2)
        testdata(:,i) = testdata(:,i) - MItrain(i);
        testdata(:,i) = testdata(:,i) / MAtrain(i);
end
testdata(testdata>1)=1;
testdata(testdata<0)=0;

