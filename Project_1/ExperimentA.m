%% exp1a.m starts here.

clear all;
close all;
clc;

%% importing LDA, PCA and label data
load LDA_scores.mat 
load PCA_scores.mat 
load label.mat

%% MAX valuation.
for i=1:200
     for j=1:200
         tempmat=[LDA1_test_scores(i,j),PCA1_train_vs_test_scores(i,j)];
         max_score(i,j)=max(tempmat);
     end;
 end;
 
 %% MIN valuation
 for i=1:200
     for j=1:200
         tempmat=[LDA1_test_scores(i,j),PCA1_train_vs_test_scores(i,j)];
         min_score(i,j)=min(tempmat);%Min score rule
     end;
 end;
 
 
%% Average valuation
avg_score=(LDA1_test_scores+PCA1_train_vs_test_scores)/2;


%% ROC Compilation
roc_LDA=ezroc3(LDA1_test_scores,label,2,'LDA',1);
roc_PCA=ezroc3(PCA1_train_vs_test_scores(:),label(:),2,'PCA',1);
roc_MAX=ezroc3(max_score,label,2,'MAX',1);
roc_MIN=ezroc3(min_score,label,2,'MIN',1);
roc_AVG=ezroc3(avg_score,label,2,'AVG',1);

%% Combining all figures to single
figure(), plot(roc_MAX(2,:),roc_MAX(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]);
hold on
 plot(roc_MIN(2,:),roc_MIN(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 plot(roc_AVG(2,:),roc_AVG(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 plot(roc_PCA(2,:),roc_PCA(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 plot(roc_LDA(2,:),roc_LDA(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 legend('max rule','min rule','average rule','pca','lda');

%% exp1a.m ends here