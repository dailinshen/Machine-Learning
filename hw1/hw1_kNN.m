function loss = hw1_kNN(k,train_data,test_data)
[m,n]=size(train_data);
[x,y]=size(test_data);
number=0;
for j=1:1000
    result=pdist2(train_data(:,1:n-1),test_data(j,1:n-1));
    [original mindex]=sort(result);
    kindex=mindex(1:k);
    label=mode(train_data(kindex,n));
    if test_data(j,n)~=label
        number=number+1;
    end
end
loss = number/x
end



