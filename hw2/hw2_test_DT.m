function loss = hw2_test_DT(test_data )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here


loss = size(test_data(test_data(:,58)~=test_data(:,59)),1)/size(test_data,1)
end

