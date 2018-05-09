%% exp1b.m starts here

clear all;
close all;
clc;

%% importing LDA, PCA and label data
load LDA_scores.mat 
load PCA_scores.mat 
load label.mat
% load a.mat


%% ROC without Multi-instance
roc_LDA=ezroc3(LDA1_test_scores,label,2,'LDA',1);
roc_PCA=ezroc3(PCA1_test_scores(:),label(:),2,'PCA',1);

%% ROC with Multi-instance
roc_M_LDA=ezroc3(LDA2_test_scores,M_label,2,'LDA_M',1);
roc_M_PCA=ezroc3(PCA2_test_scores,M_label,2,'PCA_M',1);


figure(),
hold on
 plot(roc_M_LDA(2,:),roc_M_LDA(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 plot(roc_M_PCA(2,:),roc_M_PCA(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 plot(roc_PCA(2,:),roc_PCA(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 plot(roc_LDA(2,:),roc_LDA(1,:),'LineWidth',3),axis([-0.002 1 0 1.002]); hold on;
 
 legend('LDA with Multi-instance','PCA with Multi-instance','PCA without Multi-instance','LDA without Multi-instance');


%% exp1b.m ends here. 