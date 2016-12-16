function [f,t,a,kkk,D,z,Predict]= hw3_train_adaboost_copy( train_data, num_round )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [m,n]=size(train_data);
    %   Initialize D1(x,y):=1/S for each (x,y) in S
    D=ones(m,1)*(1/m);
    t=[];f=[];a=[];z=[];Predict=[];
    ini_row=train_data(:,n)==0;
    train_data(ini_row,n)=(-1);
    for round=1:num_round
       min=inf;
       temp_z=0;
       for num=1:n-1
            temp=unique(train_data(:,num));

            for range=1:size(temp,1)
                flag=temp(range,1);
                
                bigrow=train_data(:,num)>flag;
                smallrow=~bigrow;
                train_data(bigrow,n+1)=1;
                train_data(smallrow,n+1)=-1;
                
                bigone=train_data(:,n+1)==1 & train_data(:,n)==1;
                bigzero=train_data(:,n+1)==1 & train_data(:,n)==-1;
                smallone=train_data(:,n+1)==-1 & train_data(:,n)==1;
                smallzero=train_data(:,n+1)==-1 & train_data(:,n)==-1;
                
                SO=sum(D(smallone,round));
                SZ=sum(D(smallzero,round));
                BO=sum(D(bigone,round));
                BZ=sum(D(bigzero,round));
                if SO>SZ
                    error_s=SZ;
                    k=1;
                else
                    error_s=SO;
                    k=-1;
                end
                if BO>BZ
                    error_b=BZ;
                    q=1;
                else
                    error_b=BO;
                    q=-1;
                end
                error=error_b+error_s;
                if error<min
                    min=error;
                    mark_f=num;
                    mark_t=flag;
                    s=k;
                    b=q;
                end
            end
        end
        t=[t,mark_t];
        f=[f,mark_f];
        
        rowww=train_data(:,f(end))>t(end)
        train_data(rowww,n+1)=b;
        train_data(~rowww,n+1)=s;
        
        Predict=[Predict,train_data(:,n+1)];
        for i=1:m
            temp_z=temp_z+D(i,round)*train_data(i,n)*train_data(i,n+1);
        end
        z=[z,temp_z];
        temp_a=(1/2)*log((1+temp_z)/(1-temp_z));
        a=[a,temp_a];
        for i=1:m
            D(i,round+1)=D(i,round)*exp(dot(-a(end),train_data(i,n)*train_data(i,n+1)));
        end
        
        kk=sum(D(:,end));
        D(:,round+1)=D(:,round+1)/kk;
        kkk=sum(D(:,end));
    end
end
    