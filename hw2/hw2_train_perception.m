function wt = hw2_train_perception( train_data,passes )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    train_data(:,59)=train_data(:,58);
    train_data(:,58)=1;
    row_index=train_data(:,59)==0;
    train_data(row_index,59)=-1;
    wt(1,1:58)=0;     
    for p=1:passes
        for i=1:size(train_data,1)    
            if dot(wt,train_data(i,1:58))*train_data(i,59)<=0
                wt=wt+train_data(i,59)*train_data(i,1:58);
            end
        end
    end
end

