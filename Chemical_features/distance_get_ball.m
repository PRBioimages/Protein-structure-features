function  [feature,coordinates]=distance_get_ball(str,Amino_acid)
pdb=pdbread(str);
acid=[{'ARG'},'LYS','ASP','GLU','GLN','ASN','HIS','SER','THR','TYR','CYS','MET','TRP','ALA','ILE','LEU','PHE','VAL','PRO','GLY'];
feature=zeros(1,20);
coordinates=[];
stay_Amino_acid={};

if length(pdb.Model)==1
    %flag=1;
    n=length(pdb.Model.Atom);
end

if length(pdb.Model)>1
    %flag=1;
    n=length(pdb.Model(1,1).Atom);
end


x=[];
y=[];
z=[];

if length(pdb.Model)==1
    num=1;
    n=length(pdb.Model.Atom);
    for i=1:n-1
        if(strcmp(pdb.Model.Atom(1,i).AtomName,'CA')==1)
            x(num)=pdb.Model.Atom(1,i).X;
            y(num)=pdb.Model.Atom(1,i).Y;
            z(num)=pdb.Model.Atom(1,i).Z;
            num=num+1;
        end
    end
end

if length(pdb.Model)>1
    num=1;
    n=length(pdb.Model(1,1).Atom);
    for i=1:n-1
        if(strcmp(pdb.Model(1,1).Atom(1,i).AtomName,'CA')==1)
            x(num)=pdb.Model(1,1).Atom(1,i).X;
            y(num)=pdb.Model(1,1).Atom(1,i).Y;
            z(num)=pdb.Model(1,1).Atom(1,i).Z;
            num=num+1;
        end
    end
end

xm=zeros(num-1,1);
ym=zeros(num-1,1);
zm=zeros(num-1,1);
for i=1:num-1
    for k=1:num-1
        xm(k)=x(k)-x(i);
        ym(k)=y(k)-y(i);
        zm(k)=z(k)-z(i);
    end
    xf=zeros(num-1,1);
    yf=zeros(num-1,1);
    zf=zeros(num-1,1);
    for k=1:num-1
        [xf(k),yf(k),zf(k)]=cart2sph(xm(k),ym(k),zm(k));
    end
    
    num2=1;
    judgment=zeros(1,12);
    step=90;
    step2=60;
    for azimuth=0:step:270
        for elevation=0:step2:120
            for j=1:num-1
                if  (xf(j)>=(azimuth-180)*(pi/180))&&(xf(j)<=(azimuth-180+step)*(pi/180))
                    if (yf(j)>=(elevation-90)*(pi/180))&&(yf(j)<=(elevation-90+step2)*(pi/180))
                        judgment(num2)=judgment(num2)+1;
                        num2=num2+1;
                        break;
                    end
                end
            end
        end
    end
    if min(judgment)==0
        coordinates=[coordinates;[x(i),y(i),z(i)]];
        stay_Amino_acid=[stay_Amino_acid;Amino_acid(i)];
    end
end

for i=1:length(stay_Amino_acid)
    for k=1:length(acid)
        if strcmp(stay_Amino_acid{i,1},acid{1,k})==1
            feature(k)=feature(k)+1;
            break;
        end
    end
end



