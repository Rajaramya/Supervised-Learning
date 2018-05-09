%% inputs.m starts here.
clear all;
close all;
clc;
%% Loading folder links
Data = imageSet('ATT_faces','recursive');
train_data=cell(1,200);
test_data=cell(1,200);
cnt = 1;

%% importing training images
 for j=1:40     
     for i=1:5     
         img= read(Data(j),i);
         train_data{cnt} = double(img(:));
         cnt = cnt + 1;
     end;
 end;
 cnt=1;
 
 %% importing test Images
  for j=1:40       
     for i=6:10    
         img= read(Data(j),i);
         test_data{cnt} = double(img(:));
         cnt = cnt + 1;
     end;
 end;

%% cell to mat conversion
train_data=cell2mat(train_data); 
test_data=cell2mat(test_data);

save('inputs.mat','train_data','test_data');

%% inputs.m ends here... 