%% label_create.m starts here.

clear all;
close all;
clc;
%% this is for exp1a.m
sample=[zeros(1,5),ones(1,195)];
for i=1:200
    
    label(i,:)=circshift(sample,floor((i-1)/5)*5);
    
end
sample_m=[zeros(1,1),ones(1,39)];

%% this is for exp1b.m file
temp=[zeros(1,5),ones(1,195)]';
for i=1:40
        target(:,i)=temp(:,:);
       temp=circshift(temp,5);    %% creating Target value%%
end;

M_label=target;

%% Saving results.
save('label.mat','label','M_label');

%% label_create.m ends here.
