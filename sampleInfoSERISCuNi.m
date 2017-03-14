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

% MAJ
% C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output

% Synchrotron Run and Hi-res scan numbers
% SAL-1, as-grown + low firing temperature, scans 189-190
% SAH-1, as-grown + high firing temperature, scans 204-205
     
% Samples = {'SAL-1_1','SAL-1_2','SAH-1_1','SAH-1_2'}; %Exclude the last 189 scan because no particles were found
% hiResScans = {'0189','0190','0204','0205'}; 
% Samples = {'SAL_1','SAL_2','SAH_1','SAH_2'}; %Exclude the last 189 scan because no particles were found
% hiResScans = {'0189','0190','0204','0205'}; 
% Samples = {'GB','Grain'};
% hiResScans = {'0206','0213'};

Samples = {'A1','A2','C2'}; 
hiResScans = {'0113','0123','0126'}; 

channels = {'Si','Fe','s_e'};


%% END
