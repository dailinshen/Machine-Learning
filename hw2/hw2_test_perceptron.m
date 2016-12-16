function loss = hw2_test_perceptron( weights,test_data )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    test_data(:,59)=test_data(:,58);
    test_data(:,58)=1;
    row_indexx=test_data(:,59)==0;
    test_data(row_indexx,59)=-1;
    count=0;
    for i=1:size(test_data,1)
        if dot(weights,test_data(i,1:58))*test_data(i,59)<=0
            count=count+1;
        end
    end
    loss=count/size(test_data,1);
end

