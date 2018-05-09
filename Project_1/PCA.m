%% sample_pca.m file starts here

clear all;
close all;
clc;

load inputs.mat;
%% determining mean of training data
m=mean(train_data,2); 
 
%%removing mean from actual training data
train_data_rm=train_data-repmat(m,1,200); 
 
%% covariance matrix calculation.
cov=train_data_rm*train_data_rm';
 
%% determining eigen values and eigen vector.
[eigvector,eigvl]=eig(cov);
 
%% aranging eigen values in increasing passion.
eigvalue = diag(eigvl);
[junk, index] = sort(eigvalue,'descend');

%% determining eigen values greater than zero. 
count1=0;
for i=1:size(eigvalue,1)
    if(eigvalue(i)>0)
        count1=count1+1;
    end
end
% And also we can use the eigen vectors that the corresponding eigen values is greater than zero(Threshold) and this method will decrease the
% computation time and complixity
e_vec=eigvector(:,index(1:200));
 
%% training data projection on new dimensions
train_proj=e_vec'*train_data_rm; %train projection

%% Test data projection on new dimensions
test_data=test_data-repmat(mean(test_data,2),1,200);% performing the mean of the test matrix and subtracting the mean from each image(centering the data)
ts_pro=e_vec'*test_data; %test projection
 
%% Use Euclidean distance as distance metrics for mapping train_data towards train_data.
D=pdist2(train_proj',train_proj','Euclidean');
 
%% Normalizing the projected train data.
norm=max(D(:));
normmat=1/norm*(D);

%% Finding euclidian distance for projected test_data
euc=pdist2(ts_pro',ts_pro');

%% Normalizing projected train and test data
m=max(euc(:));
euc=1/m*euc;
normmat=normmat';
j=1;
for i=0:5:195
score_train(:,j)=mean(normmat(:,i+1:i+5),2); %to find the scores of PCA at each level
j=j+1;
end;
euc=euc';
 
j=1;
for i=0:5:195
score_test(:,j)=mean(euc(:,i+1:i+5),2);
j=j+1;
end;
PCA2_test_scores=score_test;
PCA2_train_scores=score_train;
PCA1_test_scores=euc;
PCA1_train_scores=D;
%% Saving the results.
%% Use Euclidean distance as distance metrics for mapping train_data towards train_data.
D=pdist2(ts_pro',train_proj','Euclidean');
 
%% Normalizing the projected train data.
norm=max(D(:));
PCA1_train_vs_test_scores=1/norm*(D);

j=1;
for i=0:5:195
score_train(:,j)=mean(PCA1_train_vs_test_scores(:,i+1:i+5),2); %to find the scores of PCA at each level
j=j+1;
end;
euc=euc';

PCA2_train_vs_test_scores=euc;


save('PCA_scores','PCA2_test_scores','PCA2_train_scores','PCA1_test_scores','PCA1_train_scores','PCA1_train_vs_test_scores','PCA2_train_vs_test_scores');
%% sample_pca.m file ends here
