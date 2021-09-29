function [adj_matrix, Amino_acid, coordinates]=Adjacency(pdb_file)
Amino_acid={};
coordinates=[];
CA_number=0;
for i=1:length(pdb_file.Model(1).Atom)
    if strcmp(pdb_file.Model(1).Atom(i).AtomName,'CA')==1
        CA_number=CA_number+1;
    end
end
adj_matrix=zeros(CA_number,CA_number);

CA_order=1;
for i=1:length(pdb_file.Model(1).Atom)
    if CA_order==1
        if strcmp(pdb_file.Model(1).Atom(i).AtomName,'CA')==1
            Amino_acid=[Amino_acid;pdb_file.Model(1).Atom(i).resName];
            x0=pdb_file.Model(1).Atom(i).X;
            y0=pdb_file.Model(1).Atom(i).Y;
            z0=pdb_file.Model(1).Atom(i).Z;
            coordinates=[coordinates;[pdb_file.Model(1).Atom(i).X pdb_file.Model(1).Atom(i).Y pdb_file.Model(1).Atom(i).Z]];
            chainID=pdb_file.Model(1).Atom(i).chainID;
            CA_order=CA_order+1;
        end
    else
        if strcmp(pdb_file.Model(1).Atom(i).AtomName,'CA')==1
            Amino_acid=[Amino_acid;pdb_file.Model(1).Atom(i).resName];
            coordinates=[coordinates;[pdb_file.Model(1).Atom(i).X pdb_file.Model(1).Atom(i).Y pdb_file.Model(1).Atom(i).Z]];
            if strcmp(pdb_file.Model(1).Atom(i).chainID,chainID)==1
                adj_matrix(CA_order-1,CA_order)=norm([pdb_file.Model(1).Atom(i).X-x0 pdb_file.Model(1).Atom(i).Y-y0 pdb_file.Model(1).Atom(i).Z-z0]);
                x0=pdb_file.Model(1).Atom(i).X;
                y0=pdb_file.Model(1).Atom(i).Y;
                z0=pdb_file.Model(1).Atom(i).Z;
                CA_order=CA_order+1;
            else
                x0=pdb_file.Model(1).Atom(i).X;
                y0=pdb_file.Model(1).Atom(i).Y;
                z0=pdb_file.Model(1).Atom(i).Z;
                chainID=pdb_file.Model(1).Atom(i).chainID;
                CA_order=CA_order+1;
            end
        end
    end
end

alphaCarbonIndices = ismember({pdb_file.Model(1).Atom.AtomName}, {'CA'});
atom = pdb_file.Model(1).Atom(alphaCarbonIndices);

for i=1:length(atom)-2
    x0=atom(i).X;
    y0=atom(i).Y;
    z0=atom(i).Z;
    for j=i+2:length(atom)
        distance=norm([atom(j).X-x0 atom(j).Y-y0 atom(j).Z-z0]);
%         if distance<=7
            adj_matrix(i,j)=distance;
%         end
    end
end
