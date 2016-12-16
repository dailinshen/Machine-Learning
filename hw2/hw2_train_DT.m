function [type,leafl,leafr] = hw2_train_DT( train_data,test_data,depth )
global traindata
global testdata
global feature3
global value3
global typee3
notion='Entropy';
switch notion
    case 'Gini_index'
        reduction_ = -inf;
        t=1;
        
        threshold_=0.0000000000000001;
        index = train_data(:,58) == 0; 
        p=size(train_data(index,:),1)/size(train_data,1);
        us=2*p*(1-p);
            for j=1:(size(train_data,2)-3)
                sort1=unique(train_data(:,j));  %threshold???
                for i=1:(size(sort1,1)-1)   
                    row_index = train_data(:,j) <= sort1(i,1); 
                    left=train_data(row_index,:); %????????threshold????  ????
                    right=train_data(~row_index,:); %????????threshold????  ????
                    rightnum=size(right,1);   %???????
                    leftnum=size(left,1);         %  ???????
                    row_indexleft_0 = left(:,58) == 0;
                    left_0 = left(row_indexleft_0,:);     %????????label?0????
                    leftnum_0=size(left_0,1);       % ?????
                    row_indexright_0 = right(:,58) ==0;
                    right_0=right(row_indexright_0,:); %????????label?0????
                    rightnum_0=size(right_0,1);% ?????
                    uncertainty_left = 2*leftnum_0/leftnum*(1-leftnum_0/leftnum);
                    uncertainty_right = 2*rightnum_0/rightnum*(1-rightnum_0/rightnum);
                    reduction=us-(leftnum/size(train_data,1)*uncertainty_left+rightnum/size(train_data,1)*uncertainty_right);
                    if reduction>reduction_
                        reduction_ = reduction;
                        threshold_ =sort1(i,1);
                        t=j;
                    else
                    end
                end
            end
            feature3 =[feature3,t]
            value3 = [value3,threshold_]
            depth=depth-1
            newrow_index = train_data(:,feature3(1,end)) <= value3(1,end); 
            test_index=test_data(:,feature3(1,end))<=value3(1,end);
            test_left=test_data(test_index,:);
            test_right=test_data(~test_index,:);
            newleft=train_data(newrow_index,:);
            newright=train_data(~newrow_index,:);
            newleftnum=size(newleft,1); 
            newrightnum=size(newright,1);
            newrow_indexleft_0 = newleft(:,58) == 0;
            newrow_indexright_0 = newright(:,58)==0;
            newleft_0=newleft(newrow_indexleft_0,:);
            newright_0=newright(newrow_indexright_0,:);
            newrightnum_0=size(newright_0,1);
            newleftnum_0=size(newleft_0,1);
            if p>=0.5
                type='spam'
                leafl='spam'
                leafr ='spam'
                
            else
                type= 'email'
                leafl='email'
                leafr ='email'
            end
            if depth~=0
                if size(newleft)~=0
                    [type,leafl,leafr]=hw2_train_DT(newleft,test_left,depth);
                else return;
                end
                if size(newright)~=0
                  [type,leafl,leafr]=hw2_train_DT(newright,test_right,depth);
                else return;
                end
               % [xi,valuei] = hw2_train_DT( left,depth );
               % [xj,valuej] = hw2_train_DT( right,depth );
            else 
                if newleftnum_0/newleftnum>=0.5
                    leafl='spam'
                    typee3=[typee3,0]
                    testdata(test_data(test_index,60),59)=0;
                    traindata(train_data(newrow_index,60),59)=0;
                    if newrightnum_0/newrightnum>=0.5
                        leafr='spam'
                        
                    typee3=[typee3,0]
                    
                    testdata(test_data(~test_index,60),59)=0;
                    traindata(train_data(~newrow_index,60),59)=0;
                    else
                        leafr='email'
                        
                    typee3=[typee3,1]
                    
                    testdata(test_data(~test_index,60),59)=1;
                    traindata(train_data(~newrow_index,60),59)=1;
                    end
                    return;
                else
                        leafl='email'
                        
                    typee3=[typee3,1]
                    
                    testdata(test_data(test_index,60),59)=1;
                    traindata(train_data(newrow_index,60),59)=1;
           
                    if newrightnum_0/newrightnum>=0.5
                        leafr='spam'
                        
                    typee3=[typee3,0]
                    
                    testdata(test_data(~test_index,60),59)=0;
                    traindata(train_data(~newrow_index,60),59)=0;
                    else
                        leafr='email'
                        
                    typee3=[typee3,1]
                    traindata(train_data(~newrow_index,60),59)=1;
                    end
                    return;
                end
            end
    case 'Classification_error'

     
        reduction_ = -inf;
        t=1;
        
        threshold_=0.0000000000000001;
        index = train_data(:,58) == 0; 
        p=size(train_data(index,:),1)/size(train_data,1);
         us=min(p,1-p);
            for j=1:(size(train_data,2)-3)
                sort1=unique(train_data(:,j));  %threshold???
                for i=1:(size(sort1,1)-1)   
                    row_index = train_data(:,j) <= sort1(i,1); 
                    left=train_data(row_index,:); %????????threshold????  ????
                    right=train_data(~row_index,:); %????????threshold????  ????
                    rightnum=size(right,1);   %???????
                    leftnum=size(left,1);         %  ???????
                    row_indexleft_0 = left(:,58) == 0;
                    left_0 = left(row_indexleft_0,:);     %????????label?0????
                    leftnum_0=size(left_0,1);       % ?????
                    row_indexright_0 = right(:,58) ==0;
                    right_0=right(row_indexright_0,:); %????????label?0????
                    rightnum_0=size(right_0,1);% ?????
                    
                    uncertainty_left = min(leftnum_0/leftnum,(1-leftnum_0/leftnum));
                    uncertainty_right = min(rightnum_0/rightnum,(1-rightnum_0/rightnum));
                    reduction=us-(leftnum/size(train_data,1)*uncertainty_left+rightnum/size(train_data,1)*uncertainty_right);
                    if reduction>reduction_
                        reduction_ = reduction;
                        threshold_ =sort1(i,1);
                        t=j;
                    else
                    end
                end
            end
            feature3 =[feature3,t]
            value3 = [value3,threshold_]
            depth=depth-1
            newrow_index = train_data(:,feature3(1,end)) <= value3(1,end); 
            test_index=test_data(:,feature3(1,end))<=value3(1,end);
            test_left=test_data(test_index,:);
            test_right=test_data(~test_index,:);
            newleft=train_data(newrow_index,:);
            newright=train_data(~newrow_index,:);
            newleftnum=size(newleft,1); 
            newrightnum=size(newright,1);
            newrow_indexleft_0 = newleft(:,58) == 0;
            newrow_indexright_0 = newright(:,58)==0;
            newleft_0=newleft(newrow_indexleft_0,:);
            newright_0=newright(newrow_indexright_0,:);
            newrightnum_0=size(newright_0,1);
            newleftnum_0=size(newleft_0,1);
            if p>=0.5
                type='spam'
                leafl='spam'
                leafr ='spam'
                
            else
                type= 'email'
                leafl='email'
                leafr ='email'
            end
            if depth~=0
                if size(newleft)~=0
                    [type,leafl,leafr]=hw2_train_DT(newleft,test_left,depth);
                else return;
                end
                if size(newright)~=0
                  [type,leafl,leafr]=hw2_train_DT(newright,test_right,depth);
                else return;
                end
               % [xi,valuei] = hw2_train_DT( left,depth );
               % [xj,valuej] = hw2_train_DT( right,depth );
            else 
                if newleftnum_0/newleftnum>=0.5
                    leafl='spam'
                    typee3=[typee3,0]
                    testdata(test_data(test_index,60),59)=0;
                    traindata(train_data(newrow_index,60),59)=0;
                    if newrightnum_0/newrightnum>=0.5
                        leafr='spam'
                        
                    typee3=[typee3,0]
                    
                    testdata(test_data(~test_index,60),59)=0;
                    traindata(train_data(~newrow_index,60),59)=0;
                    else
                        leafr='email'
                        
                    typee3=[typee3,1]
                    
                    testdata(test_data(~test_index,60),59)=1;
                    traindata(train_data(~newrow_index,60),59)=1;
                    end
                    return;
                else
                        leafl='email'
                        
                    typee3=[typee3,1]
                    
                    testdata(test_data(test_index,60),59)=1;
                    traindata(train_data(newrow_index,60),59)=1;
           
                    if newrightnum_0/newrightnum>=0.5
                        leafr='spam'
                        
                    typee3=[typee3,0]
                    
                    testdata(test_data(~test_index,60),59)=0;
                    traindata(train_data(~newrow_index,60),59)=0;
                    else
                        leafr='email'
                        
                    typee3=[typee3,1]
                    traindata(train_data(~newrow_index,60),59)=1;
                    end
                    return;
                end
            end
    case 'Entropy'
        
        
           
                     reduction_ = -inf;
        t=1;
        
        threshold_=0.0000000000000001;
        index = train_data(:,58) == 0; 
        p=size(train_data(index,:),1)/size(train_data,1);
        us=p*log(1/p)+(1-p)*log(1/(1-p));
            for j=1:(size(train_data,2)-3)
                sort1=unique(train_data(:,j));  %threshold???
                for i=1:(size(sort1,1)-1)   
                    row_index = train_data(:,j) <= sort1(i,1); 
                    left=train_data(row_index,:); %????????threshold????  ????
                    right=train_data(~row_index,:); %????????threshold????  ????
                    rightnum=size(right,1);   %???????
                    leftnum=size(left,1);         %  ???????
                    row_indexleft_0 = left(:,58) == 0;
                    left_0 = left(row_indexleft_0,:);     %????????label?0????
                    leftnum_0=size(left_0,1);       % ?????
                    row_indexright_0 = right(:,58) ==0;
                    right_0=right(row_indexright_0,:); %????????label?0????
                    rightnum_0=size(right_0,1);% ?????
                    uncertainty_left = leftnum_0/leftnum*log(1/(leftnum_0/leftnum))+(1-(leftnum_0/leftnum))*log(1/(1-(leftnum_0/leftnum)));
                uncertainty_right = rightnum_0/rightnum*log(1/(rightnum_0/rightnum))+(1-(rightnum_0/rightnum))*log(1/(1-(rightnum_0/rightnum)));
               reduction=us-(leftnum/size(train_data,1)*uncertainty_left+rightnum/size(train_data,1)*uncertainty_right);
                    if reduction>reduction_
                        reduction_ = reduction;
                        threshold_ =sort1(i,1);
                        t=j;
                    else
                    end
                end
            end
            feature3 =[feature3,t]
            value3 = [value3,threshold_]
            depth=depth-1
            newrow_index = train_data(:,feature3(1,end)) <= value3(1,end); 
            test_index=test_data(:,feature3(1,end))<=value3(1,end);
            test_left=test_data(test_index,:);
            test_right=test_data(~test_index,:);
            newleft=train_data(newrow_index,:);
            newright=train_data(~newrow_index,:);
            newleftnum=size(newleft,1); 
            newrightnum=size(newright,1);
            newrow_indexleft_0 = newleft(:,58) == 0;
            newrow_indexright_0 = newright(:,58)==0;
            newleft_0=newleft(newrow_indexleft_0,:);
            newright_0=newright(newrow_indexright_0,:);
            newrightnum_0=size(newright_0,1);
            newleftnum_0=size(newleft_0,1);
            if p>=0.5
                type='spam'
                leafl='spam'
                leafr ='spam'
                
            else
                type= 'email'
                leafl='email'
                leafr ='email'
            end
            if depth~=0
                if size(newleft)~=0
                    [type,leafl,leafr]=hw2_train_DT(newleft,test_left,depth);
                else return;
                end
                if size(newright)~=0
                  [type,leafl,leafr]=hw2_train_DT(newright,test_right,depth);
                else return;
                end
               % [xi,valuei] = hw2_train_DT( left,depth );
               % [xj,valuej] = hw2_train_DT( right,depth );
            else 
                if newleftnum_0/newleftnum>=0.5
                    leafl='spam'
                    typee3=[typee3,0]
                    testdata(test_data(test_index,60),59)=0;
                    traindata(train_data(newrow_index,60),59)=0;
                    if newrightnum_0/newrightnum>=0.5
                        leafr='spam'
                        
                    typee3=[typee3,0]
                    
                    testdata(test_data(~test_index,60),59)=0;
                    traindata(train_data(~newrow_index,60),59)=0;
                    else
                        leafr='email'
                        
                    typee3=[typee3,1]
                    
                    testdata(test_data(~test_index,60),59)=1;
                    traindata(train_data(~newrow_index,60),59)=1;
                    end
                    return;
                else
                        leafl='email'
                        
                    typee3=[typee3,1]
                    
                    testdata(test_data(test_index,60),59)=1;
                    traindata(train_data(newrow_index,60),59)=1;
           
                    if newrightnum_0/newrightnum>=0.5
                        leafr='spam'
                        
                    typee3=[typee3,0]
                    
                    testdata(test_data(~test_index,60),59)=0;
                    traindata(train_data(~newrow_index,60),59)=0;
                    else
                        leafr='email'
                        
                    typee3=[typee3,1]
                    traindata(train_data(~newrow_index,60),59)=1;
                    end
                    return;
                end
            end
end


