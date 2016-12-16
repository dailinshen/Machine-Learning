train_data=train_spam;
%test_data=train_spam;
%test_data_=test_spam;
num_round=4;
[f,t,a,Predict,z]= hw3_train_adaboost( train_data, num_round )
%loss_train = hw3_test_adaboost(f,t,a,Predict,test_data)
%loss_test = hw3_test_adaboost(f,t,a,Predict,test_data_)