%{
MIT License

Copyright (c) [2016] [Mallory Ann Jensen, jensenma@alum.mit.edu]

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

clear all; close all; clc;

%Read in x,y particle data for each sigma 
% filename = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c3\particle_details.xlsx';
% 
% data_Cu = xlsread(filename,'Cu'); 
% data_Ni = xlsread(filename,'Ni'); 
% %scan numbers in order of our analysis
% scans = [189,190,204,205,206,213,102];
circle_parts = 'N'; 

%Make plots for publication. 
radius = 0.00075; 
linewidth = 4; %4 for pub
macroscale = 10; %display pixels/data pixel, for sizing picture to screen
nSigma = 4;
cutOff = 99;
cutoff_flag = 0;
cutoff_min = 88;
cutoff_max = 95;

%ANU T1-A1
ANU_T1_A1_elastic = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Si_2idd_0113.h5.txt';
ANU_T1_A1_Ca = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Ca_2idd_0113.h5.txt';
ANU_T1_A1_Ti = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Ti_2idd_0113.h5.txt';
ANU_T1_A1_Fe = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Fe_2idd_0113.h5.txt';
ANU_T1_A1_Ni = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Ni_2idd_0113.h5.txt';

%ANU T1-A2
ANU_T1_A2_elastic = '';

%ANU T1-C2
ANU_T1_C2_elastic = ''; 

%% After we run the above section, then we get all of the data we specified

%Get all the maps for ANU T1-A1
[mapANU_T1_A1_elastic] = processAsciiFile(ANU_T1_A1_elastic,cutoff_flag,cutoff_min,cutoff_max);
[mapANU_T1_A1_Ca] = processAsciiFile(ANU_T1_A1_Ca,cutoff_flag,cutoff_min,cutoff_max);
[mapANU_T1_A1_Ti] = processAsciiFile(ANU_T1_A1_Ti,cutoff_flag,cutoff_min,cutoff_max);
[mapANU_T1_A1_Fe] = processAsciiFile(ANU_T1_A1_Fe,cutoff_flag,cutoff_min,cutoff_max);
[mapANU_T1_A1_Ni] = processAsciiFile(ANU_T1_A1_Ni,cutoff_flag,cutoff_min,cutoff_max);

%% ANU T1-A1

%Elastic first
hFig=figure;
image(mapANU_T1_A1_elastic.xValue,mapANU_T1_A1_elastic.yValue,mapANU_T1_A1_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([110 155]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','ANU_T1-A1_elastic');

%Ca first
logged = log(mapANU_T1_A1_Ca.counts);
% logged = mapANU_T1_A1_Ca.counts;
Ca=figure;
image(mapANU_T1_A1_Ca.xValue,mapANU_T1_A1_Ca.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([-4 max(max(logged))]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
colorbar; 

%Ti first
logged = log(mapANU_T1_A1_Ti.counts);
% logged = mapANU_T1_A1_Ti.counts;
Ti=figure;
image(mapANU_T1_A1_Ti.xValue,mapANU_T1_A1_Ti.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([-6 max(max(logged))]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Fe first
logged = log(mapANU_T1_A1_Fe.counts);
% logged = mapANU_T1_A1_Fe.counts;
Fe=figure;
image(mapANU_T1_A1_Fe.xValue,mapANU_T1_A1_Fe.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([-6 max(max(logged))]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Ni first
logged = log(mapANU_T1_A1_Ni.counts);
% logged = mapANU_T1_A1_Ni.counts;
Ni=figure;
image(mapANU_T1_A1_Ni.xValue,mapANU_T1_A1_Ni.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([-5.5 max(max(logged))]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

% %Get the particle information
% index_Cu = find(data_Cu(:,1)==scans(1));
% x_Cu = data_Cu(index_Cu,2);
% y_Cu = data_Cu(index_Cu,3);
% if strcmp(circle_parts,'Y')==1
%     %Plot the particles on top of the XRF image
%     figure(Cu); 
%     %Pick out each particle automatically and draw a circle around it
%     for i = 1:length(x_Cu)
%         x_now = (x_Cu(i)-radius):(radius/1000):(x_Cu(i)+radius);
% 
%         %Calculate respective y-values
%         y_now = sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i); 
%         y_now_opp = -sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i);
% 
%         hold all; 
%         plot(x_now,y_now,'r','LineWidth',linewidth); 
%         hold all;
%         plot(x_now,y_now_opp,'r','LineWidth',linewidth);
%     end
% end
% threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
% %Make the new thresholded image
% SAL1_1_Cu = imbinarize(mapSAL1_1_Cu.counts,threshold_Cu(1)); 
% Cu_thresh = figure; 
% image(mapSAL1_1_Cu.xValue,mapSAL1_1_Cu.yValue,SAL1_1_Cu,'CDataMapping','scaled');

set(Ca,'PaperPositionMode','auto');
print(Ca,'-dpng','-r0','ANU_T1-A1_Ca');
savefig(Ca,'ANU_T1-A1_Ca.fig');
set(Fe,'PaperPositionMode','auto');
print(Fe,'-dpng','-r0','ANU_T1-A1_Fe');
savefig(Fe,'ANU_T1-A1_Fe.fig');
set(Ti,'PaperPositionMode','auto');
print(Ti,'-dpng','-r0','ANU_T1-A1_Ti');
savefig(Ti,'ANU_T1-A1_Ti.fig');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','ANU_T1-A1_Ni');
savefig(Ni,'ANU_T1-A1_Ni.fig');
