function [result]=jb_2gridSearch(allK,gnd,kfold,tcv,fcv)
% input
%   gnd: class label.
%   kfold: the number of fold.
%   tcv: training set.  for partition.
%   fcv: test set
% output
%   the weight .
parak='-t 4';
flag=0;
if(nargin<4)
    flag=1;
end
coef=0.1;
%allpos=[]; 
         aaa=1;
         n=10;
         maxacc=-1;  
         for i1=0:aaa:10       
                 i2=n-i1;%                
                     sss=[i1 i2 ];
                                icc=0;                                
                                beta=sss*coef
                                truel=[];
                                restmp=[];
                                p=[];
                                for ttcc=1:5
                                    if(flag==1)
                                        [tr,te]=jb_kfold(gnd,5,ttcc);
                                    else
                                        tr=tcv{ttcc}';
                                        te=fcv{ttcc}'; 
                                    end
                                    nte=length(te);
                                   [a,b,c]=jb_classfyWithGramMatrixLinearMKL(allK,gnd',tr,te,beta);                                                                             
                                   restmp(ttcc,1)=a;
                                   prel=b;
                                   p(icc+1:icc+nte,:)=c(1:end,:);
                                   gnd1=gnd';
                                   truel(icc+1:icc+nte,1)=gnd1(te,:); 
                                   icc=icc+nte;
                                end
                                tmp=mean(restmp);         
                                
                                auc_sum=0;
%                                 for r=1:10
%                                     [xc,yc,T,auc]=perfcurve(truel,-p(:,r),1); 
%                                     auc_sum=auc_sum+auc;
%                                 end
%                                 [xc,yc,T,auc]=perfcurve(truel,-p',1); 
                                accSet(i1+1, i2+1)=tmp;  %add
%                                 aucSet(i1+1, i2+1)=auc_sum/10;  %add
                                if(tmp>maxacc)
                                    maxacc=tmp;
                                end
                                
                                
                                
                                
                                
         end
         % compute the coefficents.
         % anlaysis
        maxauc=-1; 
        for i1=0:aaa:n
            i2=n-i1;%
            acc=accSet(i1+1, i2+1);%, i4+1);
            if(acc>=maxacc)
                %                         auc=aucSet(i1+1, i2+1);%, i4+1);%);
                %                         if(aucSet(i1+1, i2+1)>maxauc)
                tmppos=[i1 i2];
                %                         end
            end
            
        end
        %allpos=[allpos;[tmppos maxacc maxauc]];
        beta=tmppos*coef;
        K=allK;
        tK=K(:,:,1)*beta(1);
        for ii=2:length(beta)
            tK=tK+K(:,:,ii)*beta(ii);
        end
        model = svmtrain(gnd1, [(1:length(gnd))', tK], parak);
       [pred_label,accuracy,p] = svmpredict(gnd1,[(1:length(gnd))', tK], model);
        result.model=model;
        result.beta=beta;
        result.acc=accuracy;
        
        