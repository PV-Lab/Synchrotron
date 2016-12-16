%{
MIT License

Copyright (c) [2016] [Mallory Ann Jensen, jensenma@alum.mit.edu]
Note: File contents from David P. Fenning. 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
%}

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
     
Samples = {'Cr187','Cr189'}; %Exclude the last 189 scan because no particles were found
hiResScans = {'0076','0089'}; 
% Samples = {'Cr187G_1','Cr187G_2','Cr187G_3'}; %Exclude the last 189 scan because no particles were found
% hiResScans = {'0080','0082','0088'}; 
% Samples = {'Cr188G_1','Cr188G_2'}; %Exclude the last 189 scan because no particles were found
% hiResScans = {'0065','0071'}; 


channels = {'Si','Cr','s_e'};


%% END
