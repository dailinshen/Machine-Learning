function loss = hw3_test_adaboost(f,t,a,Predict,test_data)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    n=size(f,2);
    m=size(test_data,1);
    ini=test_data(:,58)==0;
    test_data(ini,58)=-1;
        for i=1:n
            row=test_data(:,f(1,i))>t(1,i);
            test_data(row,59)=Predict(1,i);
            test_data(~row,59)=-Predict(1,i);
            store=[];
            for j=1:m
                store(j,i)=a(1,i)*test_data(j,59);
            end
        end
        for i=1:m
            if sum(store(i,end))>0
                test_data(i,60)=1;
            else
                test_data(i,60)=-1;
            end
        end
        com= test_data(:,60)~=test_data(:,58);
        loss=nnz(com);
        loss=loss/m;
end

