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

%% sampleInfoSERISCuNi.m
% Modified by Mallory Jensen 2017 Jan 6

%%
%2017c1
% Samples = {'C132_RA18_1','C132_RA18_2','R697_RA18_1','R697_RA18_2','C132_sig9_38'}; %Exclude the last 189 scan because no particles were found
% hiResScans = {'0089','0091','0109','0115','0127'}; 

%2017c2
Samples = {'C132_RA50','C132_sig9_40_1','C132_sig9_40_2','C132_sig9_40_3',...
    'C132_RA_23','C132_sig3_60_1','C132_sig3_60_2','C132_sig3_60_3',...
    'R697_RA_50_1','R697_RA_50_2','R697_RA_50_3','R697_RA_50_4',...
    'R693_sig9_40','R693_sig3_60','R693_RA_23'};
hiResScans = {'0124','0129','0130','0131','0138','0146','0149','0156',...
    '0160','0161','0170','0171','0181','0189','0194'};

channels = {'Si','Fe','Cu','Ni','s_e'};


%% END
