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
filename = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\quantification from Barry\scan_particle_summary.xlsx';

data_Cu = xlsread(filename,'Cu'); 
data_Ni = xlsread(filename,'Ni'); 
%scan numbers in order of our analysis
scans = [189,190,204,205,206,213,102];
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
dir = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\XRF with Kapton\output'; 
%SAL-1 (scans 189, 190)
Cu_SAL1_1 = [dir '\ASCII_Cu_2idd_0189.h5.txt']; 
Cu_SAL1_2 = [dir '\ASCII_Cu_2idd_0190.h5.txt']; 
Ni_SAL1_1 = [dir '\ASCII_Ni_2idd_0189.h5.txt']; 
Ni_SAL1_2 = [dir '\ASCII_Ni_2idd_0190.h5.txt']; 
elastic_SAL1_1 = [dir '\ASCII_s_e_2idd_0189.h5.txt']; 
elastic_SAL1_2 = [dir '\ASCII_s_e_2idd_0190.h5.txt']; 
Cu_small_SAL1 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\no filter\output\ASCII_Cu_2idd_0191.h5.txt';
Ni_small_SAL1 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\no filter\output\ASCII_Ni_2idd_0191.h5.txt';

%SAH-1 (scans 204, 205)
Cu_SAH1_1 = [dir '\ASCII_Cu_2idd_0204.h5.txt']; 
Cu_SAH1_2 = [dir '\ASCII_Cu_2idd_0205.h5.txt']; 
Ni_SAH1_1 = [dir '\ASCII_Ni_2idd_0204.h5.txt']; 
Ni_SAH1_2 = [dir '\ASCII_Ni_2idd_0205.h5.txt']; 
elastic_SAH1_1 = [dir '\ASCII_s_e_2idd_0204.h5.txt']; 
elastic_SAH1_2 = [dir '\ASCII_s_e_2idd_0205.h5.txt']; 
Cu_small_SAH1 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\no filter\output\ASCII_Cu_2idd_0206.h5.txt';
Ni_small_SAH1 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c3\fitted\no filter\output\ASCII_Ni_2idd_0206.h5.txt';

%S-1 as-grown (2016c2 scans 206 for Cu/Ni, scan 213 for Ti)
Cu_S1_1 = [dir '\ASCII_Cu_2idd_0206.h5.txt']; 
Cu_S1_2 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Cu_2idd_0213.h5.txt'; 
Ni_S1_1 = [dir '\ASCII_Ni_2idd_0206.h5.txt']; 
Ni_S1_2 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ni_2idd_0213.h5.txt'; 
elastic_S1_1 = [dir '\ASCII_s_e_2idd_0206.h5.txt']; 
elastic_S1_2 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_s_e_2idd_0213.h5.txt'; 
Ti_S1_1 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ti_2idd_0206.h5.txt'; 
Ti_S1_2 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ti_2idd_0213.h5.txt'; 
Cu_small_S1 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Cu_2idd_0207.h5.txt';
Ni_small_S1 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\2-ID-D 2016c2\MIT.16c2.img.dat\output\ASCII_Ni_2idd_0207.h5.txt';

%Phosphorous diffusion PS1 (2016c3 scan 102)
Cu_PS1 = [dir '\ASCII_Cu_2idd_0102.h5.txt']; 
Ni_PS1 = [dir '\ASCII_Ni_2idd_0102.h5.txt']; 
elastic_PS1 = [dir '\ASCII_s_e_2idd_0102.h5.txt']; 

%26-ID-C data
Cu_26 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\26-ID-C 2016c3\output\ASCII_Cu_26idbSOFT_0153.h5.txt';
Ni_26 = 'C:\Users\Mallory Jensen\Documents\LeTID\XRF\26-ID-C 2016c3\output\ASCII_Ni_26idbSOFT_0153.h5.txt';

%% After we run the above section, then we get all of the data we specified

%Get all of the maps for SAL-1
[mapSAL1_1_Cu] = processAsciiFile(Cu_SAL1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_2_Cu] = processAsciiFile(Cu_SAL1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_1_Ni] = processAsciiFile(Ni_SAL1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_2_Ni] = processAsciiFile(Ni_SAL1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_1_elastic] = processAsciiFile(elastic_SAL1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_2_elastic] = processAsciiFile(elastic_SAL1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_small_Cu] = processAsciiFile(Cu_small_SAL1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAL1_small_Ni] = processAsciiFile(Ni_small_SAL1,cutoff_flag,cutoff_min,cutoff_max);

%Get all of the maps for SAH-1
[mapSAH1_1_Cu] = processAsciiFile(Cu_SAH1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_2_Cu] = processAsciiFile(Cu_SAH1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_1_Ni] = processAsciiFile(Ni_SAH1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_2_Ni] = processAsciiFile(Ni_SAH1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_1_elastic] = processAsciiFile(elastic_SAH1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_2_elastic] = processAsciiFile(elastic_SAH1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_small_Cu] = processAsciiFile(Cu_small_SAH1,cutoff_flag,cutoff_min,cutoff_max);
[mapSAH1_small_Ni] = processAsciiFile(Ni_small_SAH1,cutoff_flag,cutoff_min,cutoff_max);

%Get all of the maps for S1
[mapS1_1_Cu] = processAsciiFile(Cu_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_Cu] = processAsciiFile(Cu_S1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_1_Ni] = processAsciiFile(Ni_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_Ni] = processAsciiFile(Ni_S1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_1_elastic] = processAsciiFile(elastic_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_elastic] = processAsciiFile(elastic_S1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_1_Ti] = processAsciiFile(Ti_S1_1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_2_Ti] = processAsciiFile(Ti_S1_2,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_small_Cu] = processAsciiFile(Cu_small_S1,cutoff_flag,cutoff_min,cutoff_max);
[mapS1_small_Ni] = processAsciiFile(Ni_small_S1,cutoff_flag,cutoff_min,cutoff_max);

%Get all of the maps for PS1
[mapPS1_Cu] = processAsciiFile(Cu_PS1,cutoff_flag,cutoff_min,cutoff_max);
[mapPS1_Ni] = processAsciiFile(Ni_PS1,cutoff_flag,cutoff_min,cutoff_max);
[mapPS1_elastic] = processAsciiFile(elastic_PS1,cutoff_flag,cutoff_min,cutoff_max);

%26 maps
[map26_Cu] = processAsciiFile(Cu_26,cutoff_flag,cutoff_min,cutoff_max);
[map26_Ni] = processAsciiFile(Ni_26,cutoff_flag,cutoff_min,cutoff_max);

%% SAL-1

%Cu first
logged = log10(mapSAL1_1_Cu.counts.*1e3);
Cu=figure;
image(mapSAL1_1_Cu.xValue,mapSAL1_1_Cu.yValue,logged,'CDataMapping','scaled');
% image(mapSAL1_1_Cu.xValue,mapSAL1_1_Cu.yValue,mapSAL1_1_Cu.counts,'CDataMapping','scaled');
hold all; 
logged = log10(mapSAL1_2_Cu.counts.*1e3);
image(mapSAL1_2_Cu.xValue,mapSAL1_2_Cu.yValue,logged,'CDataMapping','scaled');
% image(mapSAL1_2_Cu.xValue,mapSAL1_2_Cu.yValue,mapSAL1_2_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.01]);
% caxis([0 2.5]); %log
caxis([0 1.1]); %log10
%trying to make backgrounds comparable
% caxis([0.75*8.37e-1 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
% colorbar;

%Ni next
logged = log10(mapSAL1_1_Ni.counts.*1e3);
Ni=figure;
image(mapSAL1_1_Ni.xValue,mapSAL1_1_Ni.yValue,logged,'CDataMapping','scaled');
% image(mapSAL1_1_Ni.xValue,mapSAL1_1_Ni.yValue,mapSAL1_1_Ni.counts,'CDataMapping','scaled');
hold all; 
logged = log10(mapSAL1_2_Ni.counts.*1e3);
image(mapSAL1_2_Ni.xValue,mapSAL1_2_Ni.yValue,logged,'CDataMapping','scaled');
% image(mapSAL1_2_Ni.xValue,mapSAL1_2_Ni.yValue,mapSAL1_2_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.01]);
% caxis([0 2.5]);%log
caxis([0 1.1]); %log10
%trying to make backgrounds comparable
% caxis([0.75*6.79e-1 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
% colorbar;

%Elastic next
logged = log10(mapSAL1_1_elastic.counts);
hFig=figure;
image(mapSAL1_1_elastic.xValue,mapSAL1_1_elastic.yValue,mapSAL1_1_elastic.counts,'CDataMapping','scaled');
hold all; 
logged = log10(mapSAL1_2_elastic.counts);
image(mapSAL1_2_elastic.xValue,mapSAL1_2_elastic.yValue,mapSAL1_2_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([2500 6200]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','SAL-1_elastic');

%Get the particle information
index_Cu = find(data_Cu(:,1)==scans(1));
x_Cu = data_Cu(index_Cu,2);
y_Cu = data_Cu(index_Cu,3);
if strcmp(circle_parts,'Y')==1
    %Plot the particles on top of the XRF image
    figure(Cu); 
    %Pick out each particle automatically and draw a circle around it
    for i = 1:length(x_Cu)
        x_now = (x_Cu(i)-radius):(radius/1000):(x_Cu(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
%Make the new thresholded image
SAL1_1_Cu = imbinarize(mapSAL1_1_Cu.counts,threshold_Cu(1)); 
%Do the same for Ni
index_Ni = find(data_Ni(:,1)==scans(1));
x_Ni = data_Ni(index_Ni,2);
y_Ni = data_Ni(index_Ni,3);
if strcmp(circle_parts,'Y')==1
    figure(Ni); 
    for i = 1:length(x_Ni)
        x_now = (x_Ni(i)-radius):(radius/1000):(x_Ni(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Ni = data_Ni(index_Ni,8); %Choose the noise limit
%Make the new thresholded image
SAL1_1_Ni = imbinarize(mapSAL1_1_Ni.counts,threshold_Ni(1)); 
Cu_thresh = figure; 
image(mapSAL1_1_Cu.xValue,mapSAL1_1_Cu.yValue,SAL1_1_Cu,'CDataMapping','scaled');
Ni_thresh = figure; 
image(mapSAL1_1_Ni.xValue,mapSAL1_1_Ni.yValue,SAL1_1_Ni,'CDataMapping','scaled');


%Repeat the above for the second scan on this sample
index_Cu = find(data_Cu(:,1)==scans(2));
x_Cu = data_Cu(index_Cu,2);
y_Cu = data_Cu(index_Cu,3);
if isempty(x_Cu) ~= 1
    if strcmp(circle_parts,'Y')==1
        figure(Cu); 
        for i = 1:length(x_Cu)
            x_now = (x_Cu(i)-radius):(radius/1000):(x_Cu(i)+radius);

            %Calculate respective y-values
            y_now = sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i); 
            y_now_opp = -sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i);

            hold all; 
            plot(x_now,y_now,'r','LineWidth',linewidth); 
            hold all;
            plot(x_now,y_now_opp,'r','LineWidth',linewidth);
        end
    end
    threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
    %Make the new thresholded image
    SAL1_2_Cu = imbinarize(mapSAL1_2_Cu.counts,threshold_Cu(1)); 
    figure(Cu_thresh)
    hold all; 
    image(mapSAL1_2_Cu.xValue,mapSAL1_2_Cu.yValue,SAL1_2_Cu,'CDataMapping','scaled');
    axis('image'); 
end
%Do the same for Ni
index_Ni = find(data_Ni(:,1)==scans(2));
x_Ni = data_Ni(index_Ni,2);
y_Ni = data_Ni(index_Ni,3);
if strcmp(circle_parts,'Y')==1
    figure(Ni); 
    for i = 1:length(x_Ni)
        x_now = (x_Ni(i)-radius):(radius/1000):(x_Ni(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Ni = data_Ni(index_Ni,8); %Choose the noise limit
%Make the new thresholded image
SAL1_2_Ni = imbinarize(mapSAL1_2_Ni.counts,threshold_Ni(1)); 
figure(Ni_thresh);
hold all; 
image(mapSAL1_2_Ni.xValue,mapSAL1_2_Ni.yValue,SAL1_2_Ni,'CDataMapping','scaled');
axis('image'); 

set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','SAL-1_Cu');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','SAL-1_Ni');

%Plot the small maps
hFig=figure;
image(mapSAL1_small_Cu.xValue,mapSAL1_small_Cu.yValue,mapSAL1_small_Cu.counts,'CDataMapping','scaled');
colormap(parula);
axis image; 
caxis([0 0.01]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
set(hFig,'PaperPositionMode','auto');
print('-dpng','-r0','SAL-1_Cu_small');

hFig=figure;
image(mapSAL1_small_Ni.xValue,mapSAL1_small_Ni.yValue,mapSAL1_small_Ni.counts,'CDataMapping','scaled');
colormap(parula);
axis image; 
caxis([0 0.01]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
set(hFig,'PaperPositionMode','auto');
print('-dpng','-r0','SAL-1_Ni_small');
%% SAH-1

%Cu first
logged = log10(mapSAH1_1_Cu.counts.*1e3);
Cu=figure;
image(mapSAH1_1_Cu.xValue,mapSAH1_1_Cu.yValue,logged,'CDataMapping','scaled');
% image(mapSAH1_1_Cu.xValue,mapSAH1_1_Cu.yValue,mapSAH1_1_Cu.counts,'CDataMapping','scaled');
hold all; 
logged = log10(mapSAH1_2_Cu.counts.*1e3);
image(mapSAH1_2_Cu.xValue,mapSAH1_2_Cu.yValue,logged,'CDataMapping','scaled');
% image(mapSAH1_2_Cu.xValue,mapSAH1_2_Cu.yValue,mapSAH1_2_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.01]);
% caxis([0 2.5]);%log
caxis([0 1.1]); %log10
%trying to make backgrounds comparable
% caxis([0.75*8.87e-1 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
% colorbar;

%Ni next
logged = log10(mapSAH1_1_Ni.counts.*1e3);
Ni=figure;
image(mapSAH1_1_Ni.xValue,mapSAH1_1_Ni.yValue,logged,'CDataMapping','scaled');
% image(mapSAH1_1_Ni.xValue,mapSAH1_1_Ni.yValue,mapSAH1_1_Ni.counts,'CDataMapping','scaled');
hold all; 
logged = log10(mapSAH1_2_Ni.counts.*1e3);
image(mapSAH1_2_Ni.xValue,mapSAH1_2_Ni.yValue,logged,'CDataMapping','scaled');
% image(mapSAH1_2_Ni.xValue,mapSAH1_2_Ni.yValue,mapSAH1_2_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.01]);
% caxis([0 2.5]);%log
caxis([0 1.1]); %log10
%trying to make backgrounds comparable
% caxis([0.75*6.99e-1 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
% colorbar; 

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
caxis([2500 5900]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','SAH-1_elastic');

%Get the particle information
index_Cu = find(data_Cu(:,1)==scans(3));
x_Cu = data_Cu(index_Cu,2);
y_Cu = data_Cu(index_Cu,3);
if strcmp(circle_parts,'Y')==1
    figure(Cu); 
    %Pick out each particle automatically and draw a circle around it
    for i = 1:length(x_Cu)
        x_now = (x_Cu(i)-radius):(radius/1000):(x_Cu(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
%Make the new thresholded image
SAH1_1_Cu = imbinarize(mapSAH1_1_Cu.counts,threshold_Cu(1)); 
%Do the same for Ni
index_Ni = find(data_Ni(:,1)==scans(3));
x_Ni = data_Ni(index_Ni,2);
y_Ni = data_Ni(index_Ni,3);
if strcmp(circle_parts,'Y')==1
    figure(Ni); 
    for i = 1:length(x_Ni)
        x_now = (x_Ni(i)-radius):(radius/1000):(x_Ni(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Ni = data_Ni(index_Ni,8); %Choose the noise limit
%Make the new thresholded image
SAH1_1_Ni = imbinarize(mapSAH1_1_Ni.counts,threshold_Ni(1)); 
Cu_thresh = figure; 
image(mapSAH1_1_Cu.xValue,mapSAH1_1_Cu.yValue,SAH1_1_Cu,'CDataMapping','scaled');
Ni_thresh = figure; 
image(mapSAH1_1_Ni.xValue,mapSAH1_1_Ni.yValue,SAH1_1_Ni,'CDataMapping','scaled');

%Repeat the above for the second scan on this sample
index_Cu = find(data_Cu(:,1)==scans(4));
x_Cu = data_Cu(index_Cu,2);
y_Cu = data_Cu(index_Cu,3);
if strcmp(circle_parts,'Y')==1
    figure(Cu); 
    %Pick out each particle automatically and draw a circle around it
    for i = 1:length(x_Cu)
        x_now = (x_Cu(i)-radius):(radius/1000):(x_Cu(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
%Make the new thresholded image
SAH1_2_Cu = imbinarize(mapSAH1_2_Cu.counts,threshold_Cu(1)); 
%Do the same for Ni
index_Ni = find(data_Ni(:,1)==scans(4));
x_Ni = data_Ni(index_Ni,2);
y_Ni = data_Ni(index_Ni,3);
if strcmp(circle_parts,'Y')==1
    figure(Ni); 
    for i = 1:length(x_Ni)
        x_now = (x_Ni(i)-radius):(radius/1000):(x_Ni(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Ni = data_Ni(index_Ni,8); %Choose the noise limit
%Make the new thresholded image
SAH1_2_Ni = imbinarize(mapSAH1_2_Ni.counts,threshold_Ni(1)); 
figure(Cu_thresh)
hold all; 
image(mapSAH1_2_Cu.xValue,mapSAH1_2_Cu.yValue,SAH1_2_Cu,'CDataMapping','scaled');
axis('image'); 
figure(Ni_thresh);
hold all; 
image(mapSAH1_2_Ni.xValue,mapSAH1_2_Ni.yValue,SAH1_2_Ni,'CDataMapping','scaled');
axis('image'); 

set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','SAH-1_Cu');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','SAH-1_Ni');

%Plot the small maps
hFig=figure;
image(mapSAL1_small_Cu.xValue,mapSAL1_small_Cu.yValue,mapSAL1_small_Cu.counts,'CDataMapping','scaled');
colormap(parula);
axis image; 
caxis([0 0.01]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
set(hFig,'PaperPositionMode','auto');
print('-dpng','-r0','SAH-1_Cu_small');

hFig=figure;
image(mapSAL1_small_Ni.xValue,mapSAL1_small_Ni.yValue,mapSAL1_small_Ni.counts,'CDataMapping','scaled');
colormap(parula);
axis image; 
caxis([0 0.01]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
set(hFig,'PaperPositionMode','auto');
print('-dpng','-r0','SAH-1_Ni_small');
%% S1 2016c2 - these we plot separately because they are in different locations

%Cu first
logged = log10(mapS1_1_Cu.counts.*1e3);
Cu=figure;
image(mapS1_1_Cu.xValue,mapS1_1_Cu.yValue,logged,'CDataMapping','scaled');
% image(mapS1_1_Cu.xValue,mapS1_1_Cu.yValue,mapS1_1_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.75]);
% caxis([1 6]);%log
caxis([0.5 2.6]);%log10
%trying to make backgrounds comparable
% caxis([0.75*1.39 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
% colorbar; 

hFig=figure; 
logged = log10(mapS1_2_Cu.counts.*1e3);
image(mapS1_2_Cu.xValue,mapS1_2_Cu.yValue,logged,'CDataMapping','scaled');
% image(mapS1_2_Cu.xValue,mapS1_2_Cu.yValue,mapS1_2_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.04]);
caxis([0 max(max(logged))]);
%trying to make backgrounds comparable
% caxis([0.75*1.39 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','S-1_2_Cu');

%Ni next
logged = log10(mapS1_1_Ni.counts.*1e3);
Ni=figure;
image(mapS1_1_Ni.xValue,mapS1_1_Ni.yValue,logged,'CDataMapping','scaled');
% image(mapS1_1_Ni.xValue,mapS1_1_Ni.yValue,mapS1_1_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.75]);
% caxis([1 6]);%log
caxis([0.5 2.6]);%log10
%trying to make backgrounds comparable
% caxis([0.75*1.21 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
% colorbar; 

hFig = figure; 
logged = log10(mapS1_2_Ni.counts.*1e3);
image(mapS1_2_Ni.xValue,mapS1_2_Ni.yValue,logged,'CDataMapping','scaled');
% image(mapS1_2_Ni.xValue,mapS1_2_Ni.yValue,mapS1_2_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.04]);
caxis([0 max(max(logged))]);%log
%trying to make backgrounds comparable
% caxis([0.75*1.21 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','S-1_2_Ni');

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
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','S-1_1_elastic');

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
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','S-1_2_elastic');

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
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','S-1_1_Ti');

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
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','S-1_2_Ti');

%Get the particle information
index_Cu = find(data_Cu(:,1)==scans(5));
x_Cu = data_Cu(index_Cu,2);
y_Cu = data_Cu(index_Cu,3);
if strcmp(circle_parts,'Y')==1
    figure(Cu); 
    %Pick out each particle automatically and draw a circle around it
    for i = 1:length(x_Cu)
        x_now = (x_Cu(i)-radius):(radius/1000):(x_Cu(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
%Make the new thresholded image
S1_1_Cu = imbinarize(mapS1_1_Cu.counts,threshold_Cu(1)); 
%Do the same for Ni
index_Ni = find(data_Ni(:,1)==scans(5));
x_Ni = data_Ni(index_Ni,2);
y_Ni = data_Ni(index_Ni,3);
if strcmp(circle_parts,'Y')==1
    figure(Ni); 
    for i = 1:length(x_Ni)
        x_now = (x_Ni(i)-radius):(radius/1000):(x_Ni(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Ni = data_Ni(index_Ni,8); %Choose the noise limit
%Make the new thresholded image
S1_1_Ni = imbinarize(mapS1_1_Ni.counts,threshold_Ni(1)); 
Cu_thresh = figure; 
image(mapS1_1_Cu.xValue,mapS1_1_Cu.yValue,S1_1_Cu,'CDataMapping','scaled');
axis('image'); 
Ni_thresh = figure; 
image(mapS1_1_Ni.xValue,mapS1_1_Ni.yValue,S1_1_Ni,'CDataMapping','scaled');
axis('image'); 

set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','S-1_1_Cu');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','S-1_1_Ni');

%Plot the small maps
hFig=figure;
image(mapSAL1_small_Cu.xValue,mapSAL1_small_Cu.yValue,mapSAL1_small_Cu.counts,'CDataMapping','scaled');
colormap(parula);
axis image; 
caxis([0 0.01]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
set(hFig,'PaperPositionMode','auto');
print('-dpng','-r0','S1_Cu_small');

hFig=figure;
image(mapSAL1_small_Ni.xValue,mapSAL1_small_Ni.yValue,mapSAL1_small_Ni.counts,'CDataMapping','scaled');
colormap(parula);
axis image; 
caxis([0 0.01]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
set(hFig,'PaperPositionMode','auto');
print('-dpng','-r0','S1_Ni_small');
%% PS1

%Cu first
logged = log10(mapPS1_Cu.counts.*1e3);
Cu=figure;
image(mapPS1_Cu.xValue,mapPS1_Cu.yValue,logged,'CDataMapping','scaled');
% image(mapPS1_Cu.xValue,mapPS1_Cu.yValue,mapPS1_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.01]);
% caxis([0 2.5]);
caxis([0 1.1]); %log10
%trying to make backgrounds comparable
% caxis([0.75*1.07 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
% colorbar; 

%Ni next
logged = log10(mapPS1_Ni.counts.*1e3);
Ni=figure;
image(mapPS1_Ni.xValue,mapPS1_Ni.yValue,logged,'CDataMapping','scaled');
% image(mapPS1_Ni.xValue,mapPS1_Ni.yValue,mapPS1_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 0.01]);
% caxis([0 2.5]);%log
caxis([0 1.1]); %log10
%trying to make backgrounds comparable
% caxis([0.75*9.83e-1 max(max(logged))]); 
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
% colorbar;

%elastic next
% logged = log(mapPS1_elastic.counts);
hFig=figure;
% image(mapPS1_elastic.xValue,mapPS1_elastic.yValue,logged,'CDataMapping','scaled');
image(mapPS1_elastic.xValue,mapPS1_elastic.yValue,mapPS1_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([1750 5770]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','PS1_elastic');

%Get the particle information
index_Cu = find(data_Cu(:,1)==scans(7));
x_Cu = data_Cu(index_Cu,2);
y_Cu = data_Cu(index_Cu,3);
if strcmp(circle_parts,'Y')==1
    figure(Cu); 
    %Pick out each particle automatically and draw a circle around it
    for i = 1:length(x_Cu)
        x_now = (x_Cu(i)-radius):(radius/1000):(x_Cu(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Cu(i)).^2))+y_Cu(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Cu = data_Cu(index_Cu,8); %Choose the noise limit
%Make the new thresholded image
PS1_Cu = imbinarize(mapPS1_Cu.counts,threshold_Cu(1)); 
%Do the same for Ni
index_Ni = find(data_Ni(:,1)==scans(7));
x_Ni = data_Ni(index_Ni,2);
y_Ni = data_Ni(index_Ni,3);
if strcmp(circle_parts,'Y')==1
    figure(Ni); 
    for i = 1:length(x_Ni)
        x_now = (x_Ni(i)-radius):(radius/1000):(x_Ni(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x_Ni(i)).^2))+y_Ni(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); 
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end
threshold_Ni = data_Ni(index_Ni,8); %Choose the noise limit
%Make the new thresholded image
PS1_Ni = imbinarize(mapPS1_Ni.counts,threshold_Ni(1)); 
Cu_thresh = figure; 
image(mapPS1_Cu.xValue,mapPS1_Cu.yValue,PS1_Cu,'CDataMapping','scaled');
axis('image'); 
Ni_thresh = figure; 
image(mapPS1_Ni.xValue,mapPS1_Ni.yValue,PS1_Ni,'CDataMapping','scaled');
axis('image'); 

set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','PS1_Cu');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','PS1_Ni');

%% 26-ID-C maps
Cu=figure;
logged = log(map26_Cu.counts.*1e-1.*1e3);
image(map26_Cu.xValue,map26_Cu.yValue,logged,'CDataMapping','scaled');
% image(map26_Cu.xValue,map26_Cu.yValue,map26_Cu.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image;
caxis([1 7]);
% caxis([1 7]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

Ni=figure;
logged = log(map26_Ni.counts.*1e-1.*1e3); 
image(map26_Ni.xValue,map26_Ni.yValue,logged,'CDataMapping','scaled');
% image(map26_Ni.xValue,map26_Ni.yValue,map26_Ni.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([0 2.7]);
caxis([0 6.5]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;

set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','26IDC_Cu');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','26IDC_Ni');
