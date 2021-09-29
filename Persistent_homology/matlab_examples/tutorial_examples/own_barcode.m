function feature=own_barcode(endpoints,max_filtration_value,dimension)

feature=[];

step1=1;

if dimension==0
    if isempty(endpoints)
        feature=zeros(1,8);
    else
        for i=1:length(endpoints(:,2))
            if endpoints(i,2)==Inf
                endpoints(i,2)=7;
            end
        end
        
        for i=1:6
            end_points=find(endpoints(:,2)>(i-1)*step1&endpoints(:,2)<i*step1);
            feature=[feature length(end_points)];
        end
        feature=[feature mean(endpoints(:,2)) length(endpoints(:,2))];
    end
end

step2=1;

if dimension==1
    if isempty(endpoints)
        feature=zeros(1,21);
    else
        for i=1:length(endpoints(:,2))
            if endpoints(i,2)==Inf
                endpoints(i,2)=2;
            end
        end

        for i=1:7
            end_points=find(endpoints(:,2)>(i-1)*step2&endpoints(:,2)<i*step2);
            feature=[feature length(end_points)];
        end
        for n=1:7
            start_end_points=find(endpoints(:,1)>(n-1)*max_filtration_value/7&endpoints(:,2)<n*max_filtration_value/7);
            feature=[feature length(start_end_points)];
        end
        persistence_length=endpoints(:,2)-endpoints(:,1);
        min_loction=min(endpoints(:,1));
        max_loction=max(endpoints(:,2));
        min_length=min(persistence_length);
        max_length=max(persistence_length);
        feature=[feature min_loction max_loction min_length max_length];
        
        feature=[feature mean(endpoints(:,1)) mean(endpoints(:,2)) length(endpoints(:,1))];
    end
end

if dimension==2
    if isempty(endpoints)
        feature=zeros(1,5);
    else
        for i=1:length(endpoints(:,2))
            if endpoints(i,2)==Inf
                endpoints(i,2)=7;
            end
        end
        min_loction=min(endpoints(:,1));
        max_loction=max(endpoints(:,2));
        feature=[min_loction max_loction];
        feature=[feature mean(endpoints(:,1)) mean(endpoints(:,2)) length(endpoints(:,1))];
    end
end



