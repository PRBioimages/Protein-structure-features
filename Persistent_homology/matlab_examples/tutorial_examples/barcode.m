function feature=barcode(endpoints,max_filtration_value)

feature=[];

if isempty(endpoints)
    feature=zeros(1,42);
else
    for n=1:14
        start_points=find(endpoints(:,1)>(n-1)*max_filtration_value/14&endpoints(:,1)<n*max_filtration_value/14);
        feature=[feature length(start_points)];
    end
    
    for n=1:14
        end_points=find(endpoints(:,2)>(n-1)*max_filtration_value/14&endpoints(:,2)<n*max_filtration_value/14);
        feature=[feature length(end_points)];
    end
    
    for n=1:14
        start_end_points=find(endpoints(:,1)<(n-1)*max_filtration_value/14&endpoints(:,2)>n*max_filtration_value/14);
        feature=[feature length(start_end_points)];
    end
end