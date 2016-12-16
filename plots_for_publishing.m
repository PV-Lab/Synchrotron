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
filename = 'summary.xlsx';
sheet4 = 5;

data4 = xlsread(filename,sheet4); 
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

%Sample 187 - extended process
Cr187_AG = 'ASCII_Cr_2idd_0052.h5.txt';
Elastic187_AG = 'ASCII_s_e_2idd_0052.h5.txt';
Cr187_Gett1 = 'ASCII_Cr_2idd_0080.h5.txt';
Elastic187_Gett1 = 'ASCII_s_e_2idd_0080.h5.txt';
Cr187_Gett2 = 'ASCII_Cr_2idd_0082.h5.txt';
Elastic187_Gett2 = 'ASCII_s_e_2idd_0082.h5.txt';

%Sample 188 - standard process
Cr188_AG = 'ASCII_Cr_2idd_0155.h5.txt';
Elastic188_AG = 'ASCII_s_e_2idd_0155.h5.txt';
Cr188_Gett1 = 'ASCII_Cr_2idd_0065.h5.txt';
Elastic188_Gett1 = 'ASCII_s_e_2idd_0065.h5.txt';
Cr188_Gett2 = 'ASCII_Cr_2idd_0071.h5.txt';
Elastic188_Gett2 = 'ASCII_s_e_2idd_0071.h5.txt';

%Get all of the maps for 187
[map187_AG] = processAsciiFile(Cr187_AG,cutoff_flag,cutoff_min,cutoff_max);
[map187_EAG] = processAsciiFile(Elastic187_AG,cutoff_flag,cutoff_min,cutoff_max);
[map187_Gett1] = processAsciiFile(Cr187_Gett1,cutoff_flag,cutoff_min,cutoff_max);
[map187_EGett1] = processAsciiFile(Elastic187_Gett1,cutoff_flag,cutoff_min,cutoff_max);
[map187_Gett2] = processAsciiFile(Cr187_Gett2,cutoff_flag,cutoff_min,cutoff_max);
[map187_EGett2] = processAsciiFile(Elastic187_Gett2,cutoff_flag,cutoff_min,cutoff_max);

%Get all of the maps for 188
[map188_AG] = processAsciiFile(Cr188_AG,cutoff_flag,cutoff_min,cutoff_max);
[map188_EAG] = processAsciiFile(Elastic188_AG,cutoff_flag,cutoff_min,cutoff_max);
cutoff_flag = 1;
[map188_Gett1] = processAsciiFile(Cr188_Gett1,0,cutoff_min,cutoff_max);
[map188_EGett1] = processAsciiFile(Elastic188_Gett1,0,cutoff_min,cutoff_max);
cutoff_flag = 0;
[map188_Gett2] = processAsciiFile(Cr188_Gett2,0,cutoff_min,cutoff_max);
[map188_EGett2] = processAsciiFile(Elastic188_Gett2,0,cutoff_min,cutoff_max);

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

%% 188 As-grown

%Pick out the relevant x,y data for this scan
index4 = find(data4(:,1)==2);
x4 = data4(index4,4);
y4 = data4(index4,5);

%4 standard deviations
hFig=figure;
logged = log(map188_AG.counts);
% image(map188_AG.xValue,map188_AG.yValue,map188_AG.counts,'CDataMapping','scaled');
image(map188_AG.xValue,map188_AG.yValue,logged,'CDataMapping','scaled');
colormap(flipud(gray));
% cbar = colorbar_log([10^(-7e-2) 10^(-5e-3)]);
% axis([min(map188_AG.xValue) max(map188_AG.xValue) min(map188_AG.yValue) max(map188_AG.yValue)]);
axis image;
% caxis([min(min(map188_AG.counts)) max(max(map188_AG.counts))]);
% caxis([0.25*0.0245 max(max(map188_AG.counts))]);
caxis([-4.5 -2])
disp('188 AG limits...'); 
[min(min(map188_AG.counts)) max(max(map188_AG.counts))]

%Pick out each particle automatically and draw a circle around it
for i = 1:length(x4)
    x_now = (x4(i)-radius):(radius/1000):(x4(i)+radius);
    
    %Calculate respective y-values
    y_now = sqrt((radius^2)-((x_now-x4(i)).^2))+y4(i); 
    y_now_opp = -sqrt((radius^2)-((x_now-x4(i)).^2))+y4(i);
    
    hold all; 
    plot(x_now,y_now,'r','LineWidth',linewidth); %Blue for extended
    hold all;
    plot(x_now,y_now_opp,'r','LineWidth',linewidth);
end

axis off;
title('188 As-grown  - sigma 4');
hold on;
[m,n] = size(map188_AG.counts);
set(gcf,'PaperPositionMode','auto');
set(hFig,'Position',[0 0 n*macroscale m*macroscale]);
box on;
print('-dpng','-r0','188AsGrown_sig4_pub');

%% 188 Gettered

%Pick out the relevant x,y data for this scan
index4 = find(data4(:,1)==6);
x41 = data4(index4,2);
y41 = data4(index4,3);
index4 = find(data4(:,1)==7);
x42 = data4(index4,2);
y42 = data4(index4,3);

%Shift Gett2 x,y positions
map188_Gett2.xValue = map188_Gett2.xValue+8.5e-4;
map188_Gett2.yValue = map188_Gett2.yValue-1.55e-3;
x42 = data4(index4,2)+8.5e-4;
y42 = data4(index4,3)-1.55e-3;

%sigma 4
hFig=figure;
logged = log(map188_Gett1.counts);
% image(map188_Gett1.xValue,map188_Gett1.yValue,map188_Gett1.counts,'CDataMapping','scaled');
image(map188_Gett1.xValue,map188_Gett1.yValue,logged,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
% axis([min(map188_Gett1.xValue) max(map188_Gett1.xValue) min(map188_Gett1.yValue) max(map188_Gett1.yValue)]);
axis image;
axis off;
[m1,n1] = size(map188_Gett1.counts);
max_x1 = max(max(map188_Gett1.xValue)); 
min_x1 = min(min(map188_Gett1.xValue));
max_y1 = max(max(map188_Gett1.yValue));
min_y1 = min(min(map188_Gett1.yValue));
div_x1 = abs(max_x1-min_x1)/n1; 
div_y1 = abs(max_y1-min_y1)/m1;
set(gcf,'PaperPositionMode','auto');
box on; 
hold on; 
logged = log(map188_Gett2.counts);
% image(map188_Gett2.xValue,map188_Gett2.yValue,map188_Gett2.counts,'CDataMapping','scaled');
image(map188_Gett2.xValue,map188_Gett2.yValue,logged,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
% axis([min(map188_Gett2.xValue) max(map188_Gett2.xValue) min(map188_Gett2.yValue) max(map188_Gett2.yValue)]);
axis image;
% caxis([0 max([max(max(map188_Gett1.counts)),max(max(map188_Gett2.counts))])]);
% caxis([0.25*0.0496 max([max(max(map188_Gett1.counts)),max(max(map188_Gett2.counts))])]);
caxis([-3.5 -2]);

disp('188 Gettered limits...'); 
[0 max([max(max(map188_Gett1.counts)),max(max(map188_Gett2.counts))])]

axis off;
title('188 Gettered');
[m2,n2] = size(map188_Gett2.counts);
max_x2 = max(max(map188_Gett2.xValue)); 
min_x2 = min(min(map188_Gett2.xValue));
max_y2 = max(max(map188_Gett2.yValue));
min_y2 = min(min(map188_Gett2.yValue));
div_x2 = abs(max_x2-min_x2)/n2; 
div_y2 = abs(max_y2-min_y2)/m2;
%true x value is the size of 188 Gett 2
n = n2; 
%true y value is min of 188 Gett 2 to max of 188 Gett 1
m = m2+(abs(min_y1-min_y2)/div_y1);
set(gcf,'PaperPositionMode','auto');
set(hFig,'Position',[0 0 n*macroscale m*macroscale]);
box on; 

%Gettered 2 first because it's on top 
%Pick out each particle automatically and draw a circle around it
for i = 1:length(x42)
    x_now = (x42(i)-radius):(radius/1000):(x42(i)+radius);
    
    %Calculate respective y-values
    y_now = sqrt((radius^2)-((x_now-x42(i)).^2))+y42(i); 
    y_now_opp = -sqrt((radius^2)-((x_now-x42(i)).^2))+y42(i);
    
    hold all; 
    plot(x_now,y_now,'r','LineWidth',linewidth); %Blue for extended
    hold all;
    plot(x_now,y_now_opp,'r','LineWidth',linewidth);
end

%Gettered 1 now because it's on bottom - y position matters
for i = 1:length(x41)
    if y41(i)<=min_y2
        x_now = (x41(i)-radius):(radius/1000):(x41(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x41(i)).^2))+y41(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x41(i)).^2))+y41(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); %Blue for extended
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end

print('-dpng','-r0','188Gettered_sig4_pub');

%% 187 Gettered
%Pick out the relevant x,y data for this scan
index4 = find(data4(:,1)==3);
x41 = data4(index4,2);
y41 = data4(index4,3);
index4 = find(data4(:,1)==4);
x42 = data4(index4,2);
y42 = data4(index4,3);

%sigma 4
hFig=figure;
logged = log(map187_Gett1.counts);
% image(map187_Gett1.xValue,map187_Gett1.yValue,map187_Gett1.counts,'CDataMapping','scaled');
image(map187_Gett1.xValue,map187_Gett1.yValue,logged,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis image;
axis off;
[m1,n1] = size(map187_Gett1.counts);
max_x1 = max(max(map187_Gett1.xValue)); 
min_x1 = min(min(map187_Gett1.xValue));
max_y1 = max(max(map187_Gett1.yValue));
min_y1 = min(min(map187_Gett1.yValue));
div_x1 = abs(max_x1-min_x1)/n1; 
div_y1 = abs(max_y1-min_y1)/m1;
set(gcf,'PaperPositionMode','auto');
box on; 
hold on; 
logged = log(map187_Gett2.counts);
% image(map187_Gett2.xValue,map187_Gett2.yValue,map187_Gett2.counts,'CDataMapping','scaled');
image(map187_Gett2.xValue,map187_Gett2.yValue,logged,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis image;
axis off;
title('187 Gettered');
[m2,n2] = size(map187_Gett2.counts);
max_x2 = max(max(map187_Gett2.xValue)); 
min_x2 = min(min(map187_Gett2.xValue));
max_y2 = max(max(map187_Gett2.yValue));
min_y2 = min(min(map187_Gett2.yValue));
div_x2 = abs(max_x2-min_x2)/n2; 
div_y2 = abs(max_y2-min_y2)/m2;
%true y value is the size of 187 Gett 1
m = m1; 
%true x value is min of 187 Gett 2 to max of 187 Gett 1
n = n1+(abs(min_x1-min_x2)/div_x2);
% caxis([0 max([max(max(map187_Gett1.counts)),max(max(map187_Gett2.counts))])]);
% caxis([0.0305 max([max(max(map187_Gett1.counts)),max(max(map187_Gett2.counts))])]);
caxis([-3.5 -2]);
disp('187 Gettered limits...');
[0 max([max(max(map187_Gett1.counts)),max(max(map187_Gett2.counts))])]

set(hFig,'Position',[0 0 n*macroscale m*macroscale]);
box on; 

%Gettered 2 first because it's on top 
%Pick out each particle automatically and draw a circle around it
for i = 1:length(x42)
    x_now = (x42(i)-radius):(radius/1000):(x42(i)+radius);
    
    %Calculate respective y-values
    y_now = sqrt((radius^2)-((x_now-x42(i)).^2))+y42(i); 
    y_now_opp = -sqrt((radius^2)-((x_now-x42(i)).^2))+y42(i);
    
    hold all; 
    plot(x_now,y_now,'b','LineWidth',linewidth); %Blue for extended
    hold all;
    plot(x_now,y_now_opp,'b','LineWidth',linewidth);
end

%Gettered 1 now because it's on bottom - y position matters
for i = 1:length(x41)
%     if x41(i)<max_x2 && y41(i)>min_y2 && y41(i)<max_y2
%     else
        x_now = (x41(i)-radius):(radius/1000):(x41(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x41(i)).^2))+y41(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x41(i)).^2))+y41(i);

        hold all; 
        plot(x_now,y_now,'b','LineWidth',linewidth); %Blue for extended
        hold all;
        plot(x_now,y_now_opp,'b','LineWidth',linewidth);
%     end
end

print('-dpng','-r0','187Gettered_sig4_pub');

%% Elastic - all 

%Plot 188 Gettered elastic
EGett188=figure;
%Shift EGett2 x,y positions
map188_EGett2.xValue = map188_EGett2.xValue+8.5e-4;
map188_EGett2.yValue = map188_EGett2.yValue-1.55e-3;
image(map188_EGett1.xValue,map188_EGett1.yValue,map188_EGett1.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis([min(map188_EGett1.xValue) max(map188_EGett1.xValue) min(map188_EGett1.yValue) max(map188_EGett1.yValue)]);
axis image;
axis off;
[m1,n1] = size(map188_EGett1.counts);
max_x1 = max(max(map188_EGett1.xValue)); 
min_x1 = min(min(map188_EGett1.xValue));
max_y1 = max(max(map188_EGett1.yValue));
min_y1 = min(min(map188_EGett1.yValue));
div_x1 = abs(max_x1-min_x1)/n1; 
div_y1 = abs(max_y1-min_y1)/m1;
set(gcf,'PaperPositionMode','auto');
box on; 
hold on; 

image(map188_EGett2.xValue,map188_EGett2.yValue,map188_EGett2.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis([min(map188_EGett2.xValue) max(map188_EGett2.xValue) min(map188_EGett2.yValue) max(map188_EGett2.yValue)]);
axis image;
% caxis([0.0538 max([max(max(map188_EGett1.counts)),max(max(map188_EGett2.counts))])]);
caxis([min([min(min(map188_EGett1.counts)),min(min(map188_EGett2.counts))]) max([max(max(map188_EGett1.counts)),max(max(map188_EGett2.counts))])]);
axis off;
title('188 Gettered');
box on; 


[m2,n2] = size(map188_EGett2.counts);
max_x2 = max(max(map188_EGett2.xValue)); 
min_x2 = min(min(map188_EGett2.xValue));
max_y2 = max(max(map188_EGett2.yValue));
min_y2 = min(min(map188_EGett2.yValue));
div_x2 = abs(max_x2-min_x2)/n2; 
div_y2 = abs(max_y2-min_y2)/m2;
%true x value is the size of 188 Gett 2
n = n2; 
%true y value is min of 188 Gett 2 to max of 188 Gett 1
m = m2+(abs(min_y1-min_y2)/div_y1);
set(gcf,'PaperPositionMode','auto');
set(EGett188,'Position',[0 0 n*macroscale m*macroscale]);

% print('-dpng','-r0','188GetteredElastic');

%187 Gettered elastic
EGett187=figure;
image(map187_EGett1.xValue,map187_EGett1.yValue,map187_EGett1.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
axis image;
axis off;
[m1,n1] = size(map187_EGett1.counts);
max_x1 = max(max(map187_EGett1.xValue)); 
min_x1 = min(min(map187_EGett1.xValue));
max_y1 = max(max(map187_EGett1.yValue));
min_y1 = min(min(map187_EGett1.yValue));
div_x1 = abs(max_x1-min_x1)/n1; 
div_y1 = abs(max_y1-min_y1)/m1;

set(gcf,'PaperPositionMode','auto');
%set(hFig,'Position',[0 0 n*macroscale m*macroscale]);
box on; 
hold on; 
image(map187_EGett2.xValue,map187_EGett2.yValue,map187_EGett2.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
axis image;
axis off;
title('187 Gettered');
[m2,n2] = size(map187_EGett2.counts);
max_x2 = max(max(map187_EGett2.xValue)); 
min_x2 = min(min(map187_EGett2.xValue));
max_y2 = max(max(map187_EGett2.yValue));
min_y2 = min(min(map187_EGett2.yValue));
div_x2 = abs(max_x2-min_x2)/n2; 
div_y2 = abs(max_y2-min_y2)/m2;

%true y value is the size of 187 Gett 1
m = m1; 
%true x value is min of 187 Gett 2 to max of 187 Gett 1
n = n1+(abs(min_x1-min_x2)/div_x2);
%set(gcf,'PaperPositionMode','auto');
set(EGett187,'Position',[0 0 n*macroscale m*macroscale]);
box on; 
% print('-dpng','-r0','187GetteredElastic');

%187 As-grown elastic
EAG187=figure;
image(map187_EAG.xValue,map187_EAG.yValue,map187_EAG.counts,'CDataMapping','scaled');
colormap(flipud(gray));
axis([min(map187_EAG.xValue) max(map187_EAG.xValue) min(map187_EAG.yValue) max(map187_EAG.yValue)]); 

%axis equal;
axis off;
title('187 As-grown');
hold on; 
[m,n] = size(map187_EAG.counts);
set(gcf,'PaperPositionMode','auto');
set(EAG187,'Position',[0 0 n*macroscale m*macroscale]);
box on;
% print('-dpng','-r0','187AsGrownElastic');

%188 As-grown elastic
EAG188=figure;
image(map188_EAG.xValue,map188_EAG.yValue,map188_EAG.counts,'CDataMapping','scaled');
colormap(flipud(gray));
axis([min(map188_EAG.xValue) max(map188_EAG.xValue) min(map188_EAG.yValue) max(map188_EAG.yValue)]);
axis image;

axis off;
title('188 As-grown');
hold on;
[m,n] = size(map188_AG.counts);
set(gcf,'PaperPositionMode','auto');
set(EAG188,'Position',[0 0 n*macroscale m*macroscale]);
box on;
% print('-dpng','-r0','188AsGrownElastic');

%% Try aligning the as-grown and gettered maps for 188 (STD)

%Plot 188 Gettered elastic
figure;
%Shift EGett2 x,y positions
map188_EGett2.xValue = map188_EGett2.xValue+8.5e-4;
map188_EGett2.yValue = map188_EGett2.yValue-1.55e-3;

%Shift all gettered positions to match as-grown positions
map188_EGett1.xValue = map188_EGett1.xValue-0.2067;
map188_EGett1.yValue = map188_EGett1.yValue-0.026;
map188_EGett2.xValue = map188_EGett2.xValue-0.2067;
map188_EGett2.yValue = map188_EGett2.yValue-0.026;

image(map188_EGett1.xValue,map188_EGett1.yValue,map188_EGett1.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis([min(map188_EGett1.xValue) max(map188_EGett1.xValue) min(map188_EGett1.yValue) max(map188_EGett1.yValue)]);
axis image;
axis off;
[m1,n1] = size(map188_EGett1.counts);
max_x1 = max(max(map188_EGett1.xValue)); 
min_x1 = min(min(map188_EGett1.xValue));
max_y1 = max(max(map188_EGett1.yValue));
min_y1 = min(min(map188_EGett1.yValue));
div_x1 = abs(max_x1-min_x1)/n1; 
div_y1 = abs(max_y1-min_y1)/m1;
set(gcf,'PaperPositionMode','auto');
box on; 
hold on; 

image(map188_EGett2.xValue,map188_EGett2.yValue,map188_EGett2.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis([min(map188_EGett2.xValue) max(map188_EGett2.xValue) min(map188_EGett2.yValue) max(map188_EGett2.yValue)]);
axis image;
% caxis([0.0538 max([max(max(map188_EGett1.counts)),max(max(map188_EGett2.counts))])]);
caxis([min([min(min(map188_EGett1.counts)),min(min(map188_EGett2.counts))]) max([max(max(map188_EGett1.counts)),max(max(map188_EGett2.counts))])]);
axis off;
% title('188 Gettered');
box on; 


[m2,n2] = size(map188_EGett2.counts);
max_x2 = max(max(map188_EGett2.xValue)); 
min_x2 = min(min(map188_EGett2.xValue));
max_y2 = max(max(map188_EGett2.yValue));
min_y2 = min(min(map188_EGett2.yValue));
div_x2 = abs(max_x2-min_x2)/n2; 
div_y2 = abs(max_y2-min_y2)/m2;
%true x value is the size of 188 Gett 2
n = n2; 
%true y value is min of 188 Gett 2 to max of 188 Gett 1
m = m2+(abs(min_y1-min_y2)/div_y1);
set(gcf,'PaperPositionMode','auto');
set(hFig,'Position',[0 0 n*macroscale m*macroscale]);

%188 As-grown elastic
% map188_EAG.xValue=imrotate(map188_EAG.xValue,25);
% map188_EAG.yValue=imrotate(map188_EAG.yValue,25);
% map188_EAG.counts=imrotate(map188_EAG.counts,25);
asgrown=image(map188_EAG.xValue,map188_EAG.yValue,map188_EAG.counts,'CDataMapping','scaled');
colormap(flipud(gray));
axis([min(map188_EAG.xValue) max(map188_EAG.xValue) min(map188_EAG.yValue) max(map188_EAG.yValue)]);
axis image;
%set(asgrown,'AlphaData',0.7)
axis off;
% % title('188 As-grown');
% hold on;
% [m,n] = size(map188_AG.counts);
% set(gcf,'PaperPositionMode','auto');
% set(hFig,'Position',[0 0 n*macroscale m*macroscale]);
% box on;

%Pick out the relevant x,y data for this scan
index4 = find(data4(:,1)==6);
x41 = data4(index4,2);
y41 = data4(index4,3);
index4 = find(data4(:,1)==7);
x42 = data4(index4,2);
y42 = data4(index4,3);

%Shift Gett2 x,y positions
map188_Gett2.xValue = map188_Gett2.xValue+8.5e-4;
map188_Gett2.yValue = map188_Gett2.yValue-1.55e-3;
map188_Gett1.xValue = map188_Gett1.xValue-0.2067;
map188_Gett1.yValue = map188_Gett1.yValue-0.026;
map188_Gett2.xValue = map188_Gett2.xValue-0.2067;
map188_Gett2.yValue = map188_Gett2.yValue-0.026;

x42 = data4(index4,2)+8.5e-4;
y42 = data4(index4,3)-1.55e-3;

x42 = x42-0.2067;
y42 = y42-0.026;
x41 = x41-0.2067;
y41 = y41-0.026;

%sigma 4
hFig=figure;
image(map188_Gett1.xValue,map188_Gett1.yValue,map188_Gett1.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis([min(map188_Gett1.xValue) max(map188_Gett1.xValue) min(map188_Gett1.yValue) max(map188_Gett1.yValue)]);
axis image;
axis off;
[m1,n1] = size(map188_Gett1.counts);
max_x1 = max(max(map188_Gett1.xValue)); 
min_x1 = min(min(map188_Gett1.xValue));
max_y1 = max(max(map188_Gett1.yValue));
min_y1 = min(min(map188_Gett1.yValue));
div_x1 = abs(max_x1-min_x1)/n1; 
div_y1 = abs(max_y1-min_y1)/m1;
set(gcf,'PaperPositionMode','auto');
box on; 
hold on; 
image(map188_Gett2.xValue,map188_Gett2.yValue,map188_Gett2.counts,'CDataMapping','scaled');
hold on;
colormap(flipud(gray));
% cbar = colorbar_log([10^(-12e-2) 10^(-8e-3)]);
axis([min(map188_Gett2.xValue) max(map188_Gett2.xValue) min(map188_Gett2.yValue) max(map188_Gett2.yValue)]);
axis image;
caxis([0 max([max(max(map188_Gett1.counts)),max(max(map188_Gett2.counts))])]);
disp('188 Gettered limits...'); 
[0 max([max(max(map188_Gett1.counts)),max(max(map188_Gett2.counts))])]

axis off;
[m2,n2] = size(map188_Gett2.counts);
max_x2 = max(max(map188_Gett2.xValue)); 
min_x2 = min(min(map188_Gett2.xValue));
max_y2 = max(max(map188_Gett2.yValue));
min_y2 = min(min(map188_Gett2.yValue));
div_x2 = abs(max_x2-min_x2)/n2; 
div_y2 = abs(max_y2-min_y2)/m2;
%true x value is the size of 188 Gett 2
n = n2; 
%true y value is min of 188 Gett 2 to max of 188 Gett 1
m = m2+(abs(min_y1-min_y2)/div_y1);
set(gcf,'PaperPositionMode','auto');
set(hFig,'Position',[0 0 n*macroscale m*macroscale]);
box on; 

%Gettered 2 first because it's on top 
%Pick out each particle automatically and draw a circle around it
for i = 1:length(x42)
    x_now = (x42(i)-radius):(radius/1000):(x42(i)+radius);
    
    %Calculate respective y-values
    y_now = sqrt((radius^2)-((x_now-x42(i)).^2))+y42(i); 
    y_now_opp = -sqrt((radius^2)-((x_now-x42(i)).^2))+y42(i);
    
    hold all; 
    plot(x_now,y_now,'r','LineWidth',linewidth); %Blue for extended
    hold all;
    plot(x_now,y_now_opp,'r','LineWidth',linewidth);
end

%Gettered 1 now because it's on bottom - y position matters
for i = 1:length(x41)
    if y41(i)<=min_y2
        x_now = (x41(i)-radius):(radius/1000):(x41(i)+radius);

        %Calculate respective y-values
        y_now = sqrt((radius^2)-((x_now-x41(i)).^2))+y41(i); 
        y_now_opp = -sqrt((radius^2)-((x_now-x41(i)).^2))+y41(i);

        hold all; 
        plot(x_now,y_now,'r','LineWidth',linewidth); %Blue for extended
        hold all;
        plot(x_now,y_now_opp,'r','LineWidth',linewidth);
    end
end


%Pick out the relevant x,y data for this scan
index4 = find(data4(:,1)==2);
x4 = data4(index4,4);
y4 = data4(index4,5);

%4 standard deviations
asgrown=image(map188_AG.xValue,map188_AG.yValue,map188_AG.counts,'CDataMapping','scaled');
colormap(flipud(gray));
% cbar = colorbar_log([10^(-7e-2) 10^(-5e-3)]);
axis([min(map188_AG.xValue) max(map188_AG.xValue) min(map188_AG.yValue) max(map188_AG.yValue)]);
axis image;
caxis([min(min(map188_AG.counts)) max(max(map188_AG.counts))]);
disp('188 AG limits...'); 
[min(min(map188_AG.counts)) max(max(map188_AG.counts))]

%Pick out each particle automatically and draw a circle around it
for i = 1:length(x4)
    x_now = (x4(i)-radius):(radius/1000):(x4(i)+radius);
    
    %Calculate respective y-values
    y_now = sqrt((radius^2)-((x_now-x4(i)).^2))+y4(i); 
    y_now_opp = -sqrt((radius^2)-((x_now-x4(i)).^2))+y4(i);
    
    hold all; 
    plot(x_now,y_now,'b--','LineWidth',linewidth); %Blue for extended
    hold all;
    plot(x_now,y_now_opp,'b--','LineWidth',linewidth);
end

axis off;
set(asgrown,'AlphaData',0.7)

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


