%% sampleInfoCr200.m
% Modified by Mallory Jensen 2014 May 27

%%

% MAJ
% C:\Users\Mallory\Documents\Chromium study\output

% Synchrotron Run and Hi-res scan numbers
% Cr187, gettered by extended process 920C+600C LTA, 2014-03 Synchrotron
% Run, 2idd_0080.h5, scan 80, 2idd_0082.h5, scan 82
% Cr188, gettered by standard process 845C, 2014-03 Synchrotron Run,
% 2idd_0065.h5, scan 65, 2idd_0071.h5, scan 71
     
Samples = {'Cr187G_1','Cr187G_2','Cr188G_1','Cr188G_2','Cr187G_3'}; %Exclude the last 189 scan because no particles were found
hiResScans = {'0080','0082','0065','0071','0088'}; 
% Samples = {'Cr187G_1','Cr187G_2','Cr187G_3'}; %Exclude the last 189 scan because no particles were found
% hiResScans = {'0080','0082','0088'}; 
% Samples = {'Cr188G_1','Cr188G_2'}; %Exclude the last 189 scan because no particles were found
% hiResScans = {'0065','0071'}; 


channels = {'Si','Cr','s_e'};


%% END
