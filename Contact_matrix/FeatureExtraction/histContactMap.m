function [contactMap,mean_contactMap] = histContactMap(PDBStruct)
%contactMap = histContactMap(PDBStruct)
%contactMap:  [numResidues x numResidues x numBins] = [20 x 20 x 8]
%   


% check if the specified model contains a single model
if length(PDBStruct.Model) > 1
    warning('Multiple models in the PDB structure');
    PDBStruct.Model = PDBStruct.Model(1);
end

symbols = aminoAcidSymbols(); 
bins =  linspace(5, 40, 8); % step=5
kernel = fspecial('gaussian',[3 1]) ;

% check if specified amino acid names are correct
alphaCarbonIndices = ismember({PDBStruct.Model.Atom.AtomName}, {'CA'});
atom = PDBStruct.Model.Atom(alphaCarbonIndices);
aminoAcids = {atom.resName};


contactMap = zeros(length(symbols), length(symbols), length(bins)); 
mean_contactMap=zeros(length(symbols), length(symbols));
coords = [cell2mat({atom.X})'  cell2mat({atom.Y})' cell2mat({atom.Z})'];
for i=1:length(symbols)
    indi = ismember(aminoAcids, symbols{i});
    coords_i = coords(indi,:);
    for j=i:length(symbols)
        indj = ismember(aminoAcids, symbols{j});
        coords_j = coords(indj,:);
        D = pdist2(coords_i,coords_j);
        h = hist(D(:),bins);
        contactMap(i,j,:) =h;
        mean_contactMap(i,j)=mean(D(:));
%         contactMap(i,j,:) = conv2(h, kernel, 'same');      
    end
    for k=2:length(symbols)
        for j=1:k-1
            contactMap(k,j,:) = contactMap(j,k,:);
            mean_contactMap(k,j)=mean_contactMap(j,k);
        end
    end
    
        
end
end

