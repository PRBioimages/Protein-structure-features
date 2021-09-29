function Get_Persistent_homology_features()

clc; clear all; close all;
% clear import;

javaaddpath('./Persistent_homology/matlab_examples/lib/javaplex.jar');
import edu.stanford.math.plex4.*;

javaaddpath('./Persistent_homology/matlab_examples/lib/plex-viewer.jar');
import edu.stanford.math.plex_viewer.*;

% cd './Persistent_homology/matlab_examples/utility';
% addpath(pwd);
% cd '..';

import edu.stanford.math.plex4.*;

Persistent_homology_features=[];
pro_50=[];
% angle_feature=[];
% error_protein=[];
str2='.pdb';
pro_50=[pro_50;9999];
pdb_list=importdata('.\Dataset\protein_name.xlsx');
%     error_protein{num}=loc{k};
%     num=num+1;
for j=1:length(pdb_list.textdata)%length(pdb_list.textdata.Sheet1)
    disp(j);
    str1=lower(pdb_list.textdata{j,1});%pdb_list.textdata.Sheet1{j,1}
    str=strcat(str1,str2);
    str_final=strcat('.\Dataset\pdb\',str);
    
    PDBStruct=pdbread(str_final);
    alphaCarbonIndices = ismember({PDBStruct.Model(1).Atom.AtomName}, {'CA'});
    atom = PDBStruct.Model(1).Atom(alphaCarbonIndices);
    aminoAcids = {atom.resName};
    
    coords = [cell2mat({atom.X})'  cell2mat({atom.Y})' cell2mat({atom.Z})'];
    
    if size(coords)~=0
        
        min_dimension = 0;
        max_dimension = 3;
        num_landmark_points = 50;
        max_filtration_value = 7;
        nu = 1;
        num_divisions = 1000;
        
        % create a sequential maxmin landmark selector
        if size(coords,1)<50
            landmark_selector = api.Plex4.createMaxMinSelector(coords, size(coords,1));
        else
            landmark_selector = api.Plex4.createMaxMinSelector(coords, num_landmark_points);
        end
        % landmark_selector = api.Plex4.createRandomSelector(coords, num_landmark_points);
        R = landmark_selector.getMaxDistanceFromPointsToLandmarks()
        
        % create a lazy witness stream
        stream = streams.impl.LazyWitnessStream(landmark_selector.getUnderlyingMetricSpace(), landmark_selector, max_dimension, max_filtration_value, nu, num_divisions);
        stream.finalizeStream()
        
        % print out the size of the stream
        num_simplices = stream.getSize()
        
        % get persistence algorithm over Z/2Z
        persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, 2);
        
        % compute the intervals
        intervals = persistence.computeIntervals(stream);
        
        %create the barcode plots
        %         options.filename = str1;
        %         options.max_filtration_value = max_filtration_value;
        %         options.max_dimension = max_dimension - 1;
        %         plot_barcodes(intervals, options);
        
        % feature part
        per_feaure=[];
        for dimension = min_dimension:max_dimension-1
            endpoints = homology.barcodes.BarcodeUtility.getEndpoints(intervals, dimension, false);
            feature=own_barcode(endpoints,max_filtration_value,dimension);
            per_feaure=[per_feaure feature];
        end
        %         path=['C:\Users\Dell\Desktop\javaplex\own_feature\',num2str(num),'.mat'];
        %         save(path,'per_feaure');
        Persistent_homology_features=[Persistent_homology_features;per_feaure];
        
    else
        per_feaure=zeros(1,34);
        Persistent_homology_features=[Persistent_homology_features;per_feaure];
    end
end
save('.\Feature\Persistent_homology_features.mat','Persistent_homology_features');