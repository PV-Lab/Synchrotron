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
% filename = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\particle details.xlsx';
% 
% data_Fe = xlsread(filename,'precipitate locations'); 
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

%Threshold noise limit values
threshold_Fe_A1 = 0.093244284362155; 
threshold_Fe_A2 = 0.007541577476058;
threshold_Fe_C2 = 0.007278278987801; 

%UCF low tau
lowt_elastic = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Si_2idd_0157.h5.txt';
lowt_Ca = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ca_2idd_0157.h5.txt';
lowt_Ti = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ti_2idd_0157.h5.txt';
lowt_Fe = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Fe_2idd_0157.h5.txt';
lowt_Ni = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ni_2idd_0157.h5.txt';
lowt_Cu = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Cu_2idd_0157.h5.txt';
lowt_Cr = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Cr_2idd_0157.h5.txt';

% %ANU T1-A2
% ANU_T1_A2_elastic = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Si_2idd_0123.h5.txt';
% ANU_T1_A2_Ca = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Ca_2idd_0123.h5.txt';
% ANU_T1_A2_Ti = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Ti_2idd_0123.h5.txt';
% ANU_T1_A2_Fe = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Fe_2idd_0123.h5.txt';
% ANU_T1_A2_Ni = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Ni_2idd_0123.h5.txt';
% ANU_T1_A2_Cu = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Cu_2idd_0123.h5.txt';
% ANU_T1_A2_Mn = 'C:\Users\Mallory Jensen\Documents\Synchrotron\ANU T1\output\ASCII_Mn_2idd_0123.h5.txt';

%% After we run the above section, then we get all of the data we specified

%Get all the maps for UCF low tau
[maplowt_elastic] = processAsciiFile(lowt_elastic,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Ca] = processAsciiFile(lowt_Ca,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Ti] = processAsciiFile(lowt_Ti,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Fe] = processAsciiFile(lowt_Fe,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Ni] = processAsciiFile(lowt_Ni,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Cu] = processAsciiFile(lowt_Cu,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Cr] = processAsciiFile(lowt_Cr,cutoff_flag,cutoff_min,cutoff_max);

%Get all the maps for ANU T1-A2
% [mapANU_T1_A2_elastic] = processAsciiFile(ANU_T1_A2_elastic,cutoff_flag,cutoff_min,cutoff_max);
% [mapANU_T1_A2_Ca] = processAsciiFile(ANU_T1_A2_Ca,cutoff_flag,cutoff_min,cutoff_max);
% [mapANU_T1_A2_Ti] = processAsciiFile(ANU_T1_A2_Ti,cutoff_flag,cutoff_min,cutoff_max);
% [mapANU_T1_A2_Fe] = processAsciiFile(ANU_T1_A2_Fe,cutoff_flag,cutoff_min,cutoff_max);
% [mapANU_T1_A2_Ni] = processAsciiFile(ANU_T1_A2_Ni,cutoff_flag,cutoff_min,cutoff_max);
% [mapANU_T1_A2_Cu] = processAsciiFile(ANU_T1_A2_Cu,cutoff_flag,cutoff_min,cutoff_max);
% [mapANU_T1_A2_Mn] = processAsciiFile(ANU_T1_A2_Mn,cutoff_flag,cutoff_min,cutoff_max);

%% UCF low tau

%Elastic first
hFig=figure;
image(maplowt_elastic.xValue,maplowt_elastic.yValue,maplowt_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([110 155]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','UCF_lowt_elastic');
savefig(hFig,'UCF_lowt_elastic.fig');

%Ca first
logged = log(maplowt_Ca.counts.*1e3);
% logged = maplowt_Ca.counts;
Ca=figure;
image(maplowt_Ca.xValue,maplowt_Ca.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-4 max(max(logged))]);
caxis([3 10]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
colorbar; 

%Ti first
logged = log(maplowt_Ti.counts.*1e3);
% logged = maplowt_Ti.counts;
Ti=figure;
image(maplowt_Ti.xValue,maplowt_Ti.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-6 max(max(logged))]);
caxis([1 9]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Fe first
logged = log(maplowt_Fe.counts.*1e3);
% logged = maplowt_Fe.counts;
Fe=figure;
image(maplowt_Fe.xValue,maplowt_Fe.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-6 max(max(logged))]);
caxis([0 9]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Ni first
logged = log(maplowt_Ni.counts.*1e3);
% logged = maplowt_Ni.counts;
Ni=figure;
image(maplowt_Ni.xValue,maplowt_Ni.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-5.5 max(max(logged))]);
caxis([1 5]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Cu first
logged = log(maplowt_Cu.counts.*1e3);
% logged = maplowt_Cu.counts;
Cu=figure;
image(maplowt_Cu.xValue,maplowt_Cu.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-5.5 max(max(logged))]);
caxis([0 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Cr
logged = log(maplowt_Cr.counts.*1e3);
% logged = maplowt_Cr.counts;
Cr=figure;
image(maplowt_Cr.xValue,maplowt_Cr.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-5.5 max(max(logged))]);
caxis([1 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

% %Get the particle information
% index_Cu = find(data_Cu(:,1)==scans(1));
% x_Fe = data_Fe(:,1);
% y_Fe = data_Fe(:,2);
% if strcmp(circle_parts,'Y')==1
%     %Plot the particles on top of the XRF image
%     figure(Fe); 
%     %Pick out each particle automatically and draw a circle around it
%     for i = 1:length(x_Fe)
%         x_now = (x_Fe(i)-radius):(radius/1000):(x_Fe(i)+radius);
% 
%         %Calculate respective y-values
%         y_now = sqrt((radius^2)-((x_now-x_Fe(i)).^2))+y_Fe(i); 
%         y_now_opp = -sqrt((radius^2)-((x_now-x_Fe(i)).^2))+y_Fe(i);
% 
%         hold all; 
%         plot(x_now,y_now,'r','LineWidth',linewidth); 
%         hold all;
%         plot(x_now,y_now_opp,'r','LineWidth',linewidth);
%     end
% end
% threshold_Fe = data_Cu(index_Cu,8); %Choose the noise limit
%Make the new thresholded image
% A1_Fe_thresh = imbinarize(maplowt_Fe.counts,threshold_Fe_A1); 
% Fe_thresh = figure; 
% image(maplowt_Fe.xValue,maplowt_Fe.yValue,A1_Fe_thresh,'CDataMapping','scaled');
% axis image; 

set(Ca,'PaperPositionMode','auto');
print(Ca,'-dpng','-r0','UCF_lowt_Ca');
savefig(Ca,'UCF_lowt_Ca.fig');
set(Fe,'PaperPositionMode','auto');
print(Fe,'-dpng','-r0','UCF_lowt_Fe');
savefig(Fe,'UCF_lowt_Fe.fig');
set(Ti,'PaperPositionMode','auto');
print(Ti,'-dpng','-r0','UCF_lowt_Ti');
savefig(Ti,'UCF_lowt_Ti.fig');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','UCF_lowt_Ni');
savefig(Ni,'UCF_lowt_Ni.fig');
set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','UCF_lowt_Cu');
savefig(Cu,'UCF_lowt_Cu.fig');
set(Cr,'PaperPositionMode','auto');
print(Cr,'-dpng','-r0','UCF_lowt_Cr');
savefig(Cr,'UCF_lowt_Cr.fig');
% set(Fe_thresh,'PaperPositionMode','auto');
% print(Fe_thresh,'-dpng','-r0','UCF_lowt_Fe_thresh'); 
% savefig(Fe_thresh,'UCF_lowt_Fe_thresh.fig');
%% ANU T1-A2

%Elastic first
hFig=figure;
image(mapANU_T1_A2_elastic.xValue,mapANU_T1_A2_elastic.yValue,mapANU_T1_A2_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([120 146]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','ANU_T1-A2_elastic');
savefig(hFig,'ANU_T1-A2_elastic.fig');

%Ca first
logged = log(mapANU_T1_A2_Ca.counts.*1e3);
% logged = mapANU_T1_A2_Ca.counts;
Ca=figure;
image(mapANU_T1_A2_Ca.xValue,mapANU_T1_A2_Ca.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-3.5 max(max(logged))]);
caxis([3 6]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
colorbar; 

%Ti first
logged = log(mapANU_T1_A2_Ti.counts.*1e3);
% logged = mapANU_T1_A2_Ti.counts;
Ti=figure;
image(mapANU_T1_A2_Ti.xValue,mapANU_T1_A2_Ti.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-5 max(max(logged))]);
caxis([1 5]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Fe first
logged = log(mapANU_T1_A2_Fe.counts.*1e3);
% logged = mapANU_T1_A2_Fe.counts;
Fe=figure;
image(mapANU_T1_A2_Fe.xValue,mapANU_T1_A2_Fe.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-6.5 max(max(logged))]);
caxis([0 3]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Ni first
logged = log(mapANU_T1_A2_Ni.counts.*1e3);
% logged = mapANU_T1_A2_Ni.counts;
Ni=figure;
image(mapANU_T1_A2_Ni.xValue,mapANU_T1_A2_Ni.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-5.75 max(max(logged))]);
caxis([1 3]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Cu first
logged = log(mapANU_T1_A2_Cu.counts.*1e3);
% logged = mapANU_T1_A2_Cu.counts;
Cu=figure;
image(mapANU_T1_A2_Cu.xValue,mapANU_T1_A2_Cu.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-6.5 max(max(logged))]);
caxis([0 3]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Mn
logged = log(mapANU_T1_A2_Mn.counts.*1e3);
% logged = mapANU_T1_A2_Mn.counts;
Mn=figure;
image(mapANU_T1_A2_Mn.xValue,mapANU_T1_A2_Mn.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([-6.5 max(max(logged))]);
caxis([1 3]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

% %Get the particle information
% index_Cu = find(data_Cu(:,1)==scans(1));
x_Fe = data_Fe(:,5);
y_Fe = data_Fe(:,6);
if strcmp(circle_parts,'Y')==1
    %Plot the particles on top of the XRF image
    figure(Fe); 
    %Pick out each particle automatically and draw a circle around it
    for i = 1:length(x_Fe)
        x_now = (x_Fe(i)-radius):(radius/1000):(x_Fe(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Fe(i)).^2))+y_Fe(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Fe(i)).^2))+y_Fe(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
% threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
%Make the new thresholded image
A2_Fe_thresh = imbinarize(mapANU_T1_A2_Fe.counts,threshold_Fe_A2); 
Fe_thresh = figure; 
image(mapANU_T1_A2_Fe.xValue,mapANU_T1_A2_Fe.yValue,A2_Fe_thresh,'CDataMapping','scaled');
axis image; 

set(Ca,'PaperPositionMode','auto');
print(Ca,'-dpng','-r0','ANU_T1-A2_Ca');
savefig(Ca,'ANU_T1-A2_Ca.fig');
set(Fe,'PaperPositionMode','auto');
% print(Fe,'-dpng','-r0','ANU_T1-A2_Fe');
% savefig(Fe,'ANU_T1-A2_Fe.fig');
print(Fe,'-dpng','-r0','ANU_T1-A2_Fe_particles');
savefig(Fe,'ANU_T1-A2_Fe_particles.fig');
set(Ti,'PaperPositionMode','auto');
print(Ti,'-dpng','-r0','ANU_T1-A2_Ti');
savefig(Ti,'ANU_T1-A2_Ti.fig');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','ANU_T1-A2_Ni');
savefig(Ni,'ANU_T1-A2_Ni.fig');
set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','ANU_T1-A2_Cu');
savefig(Cu,'ANU_T1-A2_Cu.fig');
set(Mn,'PaperPositionMode','auto');
print(Mn,'-dpng','-r0','ANU_T1-A2_Mn');
savefig(Mn,'ANU_T1-A2_Mn.fig');
set(Fe_thresh,'PaperPositionMode','auto');
print(Fe_thresh,'-dpng','-r0','ANU_T1-A2_Fe_thresh'); 
savefig(Fe_thresh,'ANU_T1-A2_Fe_thresh.fig');

