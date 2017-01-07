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
filename = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\particle_details.xlsx';

data = xlsread(filename); 
codes = {'187 AG' '188 AG' '187 G1' '187 G2' '187 G3' '188 G1' '188 G2'};

%Make plots for publication. 
radius = 0.00075; 
linewidth = 4; %4 for pub
macroscale = 10; %display pixels/data pixel, for sizing picture to screen
nSigma = 4;
cutOff = 99;
cutoff_flag = 0;
cutoff_min = 88;
cutoff_max = 95;

%SAL-1 (scans 189, 190)
Cu_SAL1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Cu_2idd_0189.h5.txt'; 
Cu_SAL1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Cu_2idd_0190.h5.txt'; 
Ni_SAL1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Ni_2idd_0189.h5.txt'; 
Ni_SAL1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Ni_2idd_0190.h5.txt'; 
elastic_SAL1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_s_e_2idd_0189.h5.txt'; 
elastic_SAL1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_s_e_2idd_0190.h5.txt'; 

%SAH-1 (scans 204, 205)
Cu_SAH1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Cu_2idd_0204.h5.txt'; 
Cu_SAH1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Cu_2idd_0205.h5.txt'; 
Ni_SAH1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Ni_2idd_0204.h5.txt'; 
Ni_SAH1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_Ni_2idd_0205.h5.txt'; 
elastic_SAH1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_s_e_2idd_0204.h5.txt'; 
elastic_SAH1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\with Filt 1\output\ASCII_s_e_2idd_0205.h5.txt'; 

%S-1 as-grown (2016c2 scans 206 for Cu/Ni, scan 213 for Ti)
Cu_S1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Cu_2idd_0206.h5.txt'; 
Cu_S1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Cu_2idd_0213.h5.txt'; 
Ni_S1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ni_2idd_0206.h5.txt'; 
Ni_S1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ni_2idd_0213.h5.txt'; 
elastic_S1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_s_e_2idd_0206.h5.txt'; 
elastic_S1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_s_e_2idd_0213.h5.txt'; 
Ti_S1_1 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ti_2idd_0206.h5.txt'; 
Ti_S1_2 = 'C:\Users\Malloryj\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ti_2idd_0213.h5.txt'; 

%Get all of the maps for SAL-1
[mapSAL1_1_Cu] = processAsciiFile(Cu_SAL1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_2_Cu] = processAsciiFile(Cu_SAL1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_1_Ni] = processAsciiFile(Ni_SAL1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_2_Ni] = processAsciiFile(Ni_SAL1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_1_elastic] = processAsciiFile(elastic_SAL1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_2_elastic] = processAsciiFile(elastic_SAL1_2,cutoff_flag,cutoff_min,cutoff_max);

%Get all of the maps for SAH-1
[mapSAH1_1_Cu] = processAsciiFile(Cu_SAH1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_2_Cu] = processAsciiFile(Cu_SAH1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_1_Ni] = processAsciiFile(Ni_SAH1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_2_Ni] = processAsciiFile(Ni_SAH1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_1_elastic] = processAsciiFile(elastic_SAH1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_2_elastic] = processAsciiFile(elastic_SAH1_2,cutoff_flag,cutoff_min,cutoff_max);

%Get all of the maps for S1
[mapS1_1_Cu] = processAsciiFile(Cu_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_Cu] = processAsciiFile(Cu_S1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_1_Ni] = processAsciiFile(Ni_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_Ni] = processAsciiFile(Ni_S1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_1_elastic] = processAsciiFile(elastic_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_elastic] = processAsciiFile(elastic_S1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_1_Ti] = processAsciiFile(Ti_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_Ti] = processAsciiFile(Ti_S1_2,cutoff_flag,cutoff_min,cutoff_max);

%% SAL-1

%Cu first
% logged = log(mapSAL1_1_Cu.counts);
hFig=figure;
% image(mapSAL1_1_Cu.xValue,mapSAL1_1_Cu.yValue,logged,'CDataMapping','scaled');
image(mapSAL1_1_Cu.xValue,mapSAL1_1_Cu.yValue,mapSAL1_1_Cu.counts,'CDataMapping','scaled');
hold all; 
% logged = log(mapSAL1_2_Cu.counts);
% image(mapSAL1_2_Cu.xValue,mapSAL1_2_Cu.yValue,logged,'CDataMapping','scaled');
image(mapSAL1_2_Cu.xValue,mapSAL1_2_Cu.yValue,mapSAL1_2_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.007]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 

%Ni next
% logged = log(mapSAL1_1_Ni.counts);
hFig=figure;
% image(mapSAL1_1_Ni.xValue,mapSAL1_1_Ni.yValue,logged,'CDataMapping','scaled');
image(mapSAL1_1_Ni.xValue,mapSAL1_1_Ni.yValue,mapSAL1_1_Ni.counts,'CDataMapping','scaled');
hold all; 
% logged = log(mapSAL1_2_Ni.counts);
% image(mapSAL1_2_Ni.xValue,mapSAL1_2_Ni.yValue,logged,'CDataMapping','scaled');
image(mapSAL1_2_Ni.xValue,mapSAL1_2_Ni.yValue,mapSAL1_2_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.015]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%Elastic next
logged = log(mapSAL1_1_elastic.counts);
hFig=figure;
image(mapSAL1_1_elastic.xValue,mapSAL1_1_elastic.yValue,mapSAL1_1_elastic.counts,'CDataMapping','scaled');
hold all; 
logged = log(mapSAL1_2_elastic.counts);
image(mapSAL1_2_elastic.xValue,mapSAL1_2_elastic.yValue,mapSAL1_2_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([1060 1665]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%% SAH-1

%Cu first
% logged = log(mapSAH1_1_Cu.counts);
hFig=figure;
% image(mapSAH1_1_Cu.xValue,mapSAH1_1_Cu.yValue,logged,'CDataMapping','scaled');
image(mapSAH1_1_Cu.xValue,mapSAH1_1_Cu.yValue,mapSAH1_1_Cu.counts,'CDataMapping','scaled');
hold all; 
% logged = log(mapSAH1_2_Cu.counts);
% image(mapSAH1_2_Cu.xValue,mapSAH1_2_Cu.yValue,logged,'CDataMapping','scaled');
image(mapSAH1_2_Cu.xValue,mapSAH1_2_Cu.yValue,mapSAH1_2_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.01]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%Ni next
% logged = log(mapSAH1_1_Ni.counts);
hFig=figure;
% image(mapSAH1_1_Ni.xValue,mapSAH1_1_Ni.yValue,logged,'CDataMapping','scaled');
image(mapSAH1_1_Ni.xValue,mapSAH1_1_Ni.yValue,mapSAH1_1_Ni.counts,'CDataMapping','scaled');
hold all; 
% logged = log(mapSAH1_2_Ni.counts);
% image(mapSAH1_2_Ni.xValue,mapSAH1_2_Ni.yValue,logged,'CDataMapping','scaled');
image(mapSAH1_2_Ni.xValue,mapSAH1_2_Ni.yValue,mapSAH1_2_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.014]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%elastic next
% logged = log(mapSAH1_1_elastic.counts);
hFig=figure;
% image(mapSAH1_1_elastic.xValue,mapSAH1_1_elastic.yValue,logged,'CDataMapping','scaled');
image(mapSAH1_1_elastic.xValue,mapSAH1_1_elastic.yValue,mapSAH1_1_elastic.counts,'CDataMapping','scaled');
hold all; 
% logged = log(mapSAH1_2_elastic.counts);
% image(mapSAH1_2_elastic.xValue,mapSAH1_2_elastic.yValue,logged,'CDataMapping','scaled');
image(mapSAH1_2_elastic.xValue,mapSAH1_2_elastic.yValue,mapSAH1_2_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([1054 1572]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%% S1 2016c2 - these we plot separately because they are in different locations

%Cu first
% logged = log(mapS1_1_Cu.counts);
hFig=figure;
% image(mapS1_1_Cu.xValue,mapS1_1_Cu.yValue,logged,'CDataMapping','scaled');
image(mapS1_1_Cu.xValue,mapS1_1_Cu.yValue,mapS1_1_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 1.34]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

hFig=figure; 
% logged = log(mapS1_2_Cu.counts);
% image(mapS1_2_Cu.xValue,mapS1_2_Cu.yValue,logged,'CDataMapping','scaled');
image(mapS1_2_Cu.xValue,mapS1_2_Cu.yValue,mapS1_2_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.04]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%Ni next
% logged = log(mapS1_1_Ni.counts);
hFig=figure;
% image(mapS1_1_Ni.xValue,mapS1_1_Ni.yValue,logged,'CDataMapping','scaled');
image(mapS1_1_Ni.xValue,mapS1_1_Ni.yValue,mapS1_1_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.34]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

hFig = figure; 
% logged = log(mapS1_2_Ni.counts);
% image(mapS1_2_Ni.xValue,mapS1_2_Ni.yValue,logged,'CDataMapping','scaled');
image(mapS1_2_Ni.xValue,mapS1_2_Ni.yValue,mapS1_2_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.04]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%elastic next
% logged = log(mapS1_1_elastic.counts);
hFig=figure;
% image(mapS1_1_elastic.xValue,mapS1_1_elastic.yValue,logged,'CDataMapping','scaled');
image(mapS1_1_elastic.xValue,mapS1_1_elastic.yValue,mapS1_1_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([2800 100000]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

hFig = figure; 
% logged = log(mapS1_2_elastic.counts);
% image(mapS1_2_elastic.xValue,mapS1_2_elastic.yValue,logged,'CDataMapping','scaled');
image(mapS1_2_elastic.xValue,mapS1_2_elastic.yValue,mapS1_2_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([2154 4663]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%Ti at last
% logged = log(mapS1_1_Ti.counts);
hFig=figure;
% image(mapS1_1_Ti.xValue,mapS1_1_Ti.yValue,logged,'CDataMapping','scaled');
image(mapS1_1_Ti.xValue,mapS1_1_Ti.yValue,mapS1_1_Ti.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 0.06]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

hFig = figure; 
% logged = log(mapS1_2_Ti.counts);
% image(mapS1_2_Ti.xValue,mapS1_2_Ti.yValue,logged,'CDataMapping','scaled');
image(mapS1_2_Ti.xValue,mapS1_2_Ti.yValue,mapS1_2_Ti.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([0 44.2]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

%% 187 As-grown

%Pick out the relevant x,y data for this scan
index4 = find(data4(:,1)==1);
x4 = data4(index4,4);
y4 = data4(index4,5);

%First for 4 standard deviations
%Make individual figures for each sample
logged = log(map187_AG.counts);
hFig=figure;
% image(map187_AG.xValue,map187_AG.yValue,map187_AG.counts,'CDataMapping','scaled');
image(map187_AG.xValue,map187_AG.yValue,logged,'CDataMapping','scaled');
colormap(flipud(gray));
% axis([min(map187_AG.xValue) max(map187_AG.xValue) min(map187_AG.yValue) max(map187_AG.yValue)]); 
axis image; 
% cbar = colorbar_log([10^(-max(max(map187_AG.counts))) 10^(-0)]);
% caxis([min(min(map187_AG.counts)) max(max(map187_AG.counts))]);
caxis([-5 -2]);

disp('187 AG limits...'); 
[min(min(map187_AG.counts)) max(max(map187_AG.counts))]

%Pick out each particle automatically and draw a circle around it
for i = 1:length(x4)
    x_now = (x4(i)-radius):(radius/1000):(x4(i)+radius);
    
    %Calculate respective y-values
    y_now = sqrt((radius^2)-((x_now-x4(i)).^2))+y4(i); 
    y_now_opp = -sqrt((radius^2)-((x_now-x4(i)).^2))+y4(i);
    
    hold all; 
    plot(x_now,y_now,'b','LineWidth',linewidth); %Blue for extended
    hold all;
    plot(x_now,y_now_opp,'b','LineWidth',linewidth);
end

%axis equal;
axis off;
title('187 As-grown - sigma 3');
hold on; 
[m,n] = size(map187_AG.counts);
set(gcf,'PaperPositionMode','auto');
set(hFig,'Position',[0 0 n*macroscale m*macroscale]);
box on;
print('-dpng','-r0','187AsGrown_sig4_pub');

%% Use the elastic maps to estimate the grain boundary length (will be used to estimate precipitate density)

figure(EAG187);
disp('Select the y-location of the left edge of the grain boundary and then the right edge of the grain boundary');
[x,y] = ginput(2); 
dx = abs(x(1)-x(2));
dy = abs(y(1)-y(2));
EAG187_length = sqrt((dx^2)+(dy^2))

figure(EAG188);
disp('Select the y-location of the left edge of the grain boundary and then the right edge of the grain boundary');
[x,y] = ginput(2); 
dx = abs(x(1)-x(2));
dy = abs(y(1)-y(2));
EAG188_length = sqrt((dx^2)+(dy^2))

figure(EGett187);
disp('Select the y-location of the left edge of the grain boundary and then the right edge of the grain boundary');
[x,y] = ginput(2); 
dx = abs(x(1)-x(2));
dy = abs(y(1)-y(2));
EGett187_length = sqrt((dx^2)+(dy^2))

figure(EGett188);
disp('Select the y-location of the left edge of the grain boundary and then the right edge of the grain boundary');
[x,y] = ginput(2); 
dx = abs(x(1)-x(2));
dy = abs(y(1)-y(2));
EGett188_length = sqrt((dx^2)+(dy^2))


