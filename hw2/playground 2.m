train_data = train_spam;
test_data=test_spam;
passes=50;
ww = hw2_train_perception( train_data,passes )
weights=ww(end,:);
losstest=hw2_test_perceptron(weights, test_data)
losstrain=hw2_test_perceptron(weights, train_data)