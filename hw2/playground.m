
%[i,value,type,leafl,leafr,loss] = hw2_train_DT( train_spam, 1 )

global feature3
global value3
global typee3
global traindata
global testdata
traindata=train_spam
testdata=test_spam
for i=1:3601
    traindata(i,60)=i;
end

for i=1:1000
    testdata(i,60)=i;
end
testspam=testdata
traindata1=traindata
[type,leafl,leafr] = hw2_train_DT(traindata1, testspam, 6 )

f=feature3
v=value3
t=typee3
loss=hw2_test_DT(testdata)
