function ACC_and_F1=cal_confusion(final_confusion)

ACC_and_F1=zeros(10,2);
number=1;
for k=1:10
    a=final_confusion{1,k};
    a_trace=trace(a);
    ACC=a_trace/sum(a(:));
    F1_score=zeros(1,4);
    for i=1:4
        if a(i,i)==0
            F1_score(i)=0;
            continue
        end
        p=a(i,i)/(sum(a(:,i)));
        r=a(i,i)/(sum(a(i,:)));
        F1_score(i)=2*(p*r)/(p+r);
    end
    F1_ave=sum(F1_score(1,:))/4;
    ACC_and_F1(number,1)=ACC;
    ACC_and_F1(number,2)=F1_ave;
    number=number+1;
end