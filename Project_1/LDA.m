%% sample_lda.m file starts here
clear all;
close all;
clc;

%% importing input data
load inputs.mat

%% calculating mean for train_data
m=mean(train_data,2); 

%% Calculating Mean of Each Class%%
j=1;
for i=0:5:195
    n_m(:,j)=mean(train_data(:,i+1:i+5),2);
    mean_class(:,i+1:i+5)=repmat(n_m(:,j),[1,5]);    
    j=j+1;
end;
 
%% Calculate the within class scatter (SW)
     tmp=zeros(10304,10304);
     wsca=zeros(10304,10304);
 for i =0:5:195
     tmp=(train_data(:,i+1:i+5)-mean_class(:,i+1:i+5))*((train_data(:,i+1:i+5)-mean_class(:,i+1:i+5))');
     wsca=tmp+wsca;                
 end;
 
 v=pinv(wsca);
 
%%  Calculate the within class scatter (SW)
 
  %%Calculating between scatter matrix%%
  temp=zeros(10304,10304);
  bsca=zeros(10304,10304);
 for i=1:40
     temp=(tmp(:,i)-m)*((tmp(:,i)-m)');
     bsca=temp+bsca;            
 
  end;
 
%% removing mean from train_data
m_train_data=train_data-repmat(m,1,200); %for the training set
 
%% Removing mean from test data
test_data=test_data-repmat(mean(test_data,2),1,200);% performing the mean of the test matrix and subtracting the mean from each image(centering the data)
 
%% determining eiven values and eigen vectors
[evec,eval]=eig(v*bsca);
 
%% Sort the eigen vectors according to the eigen values
eigvalue = diag(eval);
[junk, index] = sort(eigvalue,'descend');
 
%% eigen values greater than 'o'
cnt=0;
for i=1:size(eigvalue,1)
    if(eigvalue(i)>0)
        cnt=cnt+1;
    end
end
 
%% And also we can use the eigen vectors that the corresponding eigen values is greater than zero(Threshold) and this method will decrease the
% computation time and complixity 
e_vec=evec(:,index(1:40)); %Number of principal components used
 
%% train data projection on new dimensions
train_pro=e_vec'*m_train_data; 

%% Test data projection on new dimensions.
test_pro=e_vec'*test_data; %test projection
train_pro=abs(train_pro);
test_pro=abs(test_pro);

%% determining eucludian distance for train data
D=pdist2(train_pro',train_pro','Euclidean');

%% Normalizing distances.
norm=max(D(:));
normmat=1/norm*(D);
euc=pdist2(test_pro',test_pro');
%euc=squareform(euc);
m=max(euc(:));
euc=1/m*euc;
normmat=normmat';
j=1;
for i=0:5:195
score_train(:,j)=mean(normmat(:,i+1:i+5),2); %%to find the scores of LDA at each level
j=j+1;
end;
euc=euc';
j=1;
for i=0:5:195
score_test(:,j)=mean(euc(:,i+1:i+5),2);
j=j+1;
end;

%% saving data
LDA1_train_scores=D;
LDA1_test_scores=euc;
LDA2_train_scores=score_train;
LDA2_test_scores=score_test;


D=pdist2(test_pro',train_pro','Euclidean');
norm=max(D(:));
normmat=1/norm*(D); 
j=1;
for i=0:5:195
score_train(:,j)=mean(normmat(:,i+1:i+5),2); %%to find the scores of LDA at each level
j=j+1;
end;

LDA1_train_vs_test_scores=normmat;
LDA2_train_vs_test_scores=score_train;



save('LDA_scores.mat','LDA2_train_scores','LDA2_test_scores','LDA1_train_scores','LDA1_test_scores','LDA1_train_vs_test_scores','LDA2_train_vs_test_scores');

%% sample_lda.m file ends here