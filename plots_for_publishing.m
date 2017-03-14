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

%Make plots for publication. 
macroscale = 10; %display pixels/data pixel, for sizing picture to screen
nSigma = 4;
cutOff = 99;
cutoff_flag = 0;
cutoff_min = 88;
cutoff_max = 95;

%Threshold noise limit values
data = xlsread('C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\UCF_MDLs.xlsx','MDLs');
threshold_Ca_lowt = data(2,2); 
threshold_Cr_lowt = data(3,2);
threshold_Cu_lowt = data(4,2); 
threshold_Fe_lowt = data(5,2); 
threshold_Ni_lowt = data(6,2); 
threshold_Ti_lowt = data(7,2); 
threshold_Ca_dw = data(2,5); 
threshold_Cr_dw = data(3,5);
threshold_Cu_dw = data(4,5); 
threshold_Fe_dw = data(5,5); 
threshold_Ni_dw = data(6,5); 
threshold_Ti_dw = data(7,5);
threshold_Al_dw = data(1,5); 
threshold_Zn_dw = data(8,5); 
threshold_Pb_dw = data(10,5); 
threshold_Sn_dw = data(11,5);


%UCF low tau
lowt_elastic = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Si_2idd_0157.h5.txt';
lowt_Ca = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ca_2idd_0157.h5.txt';
lowt_Ti = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ti_2idd_0157.h5.txt';
lowt_Fe = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Fe_2idd_0157.h5.txt';
lowt_Ni = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ni_2idd_0157.h5.txt';
lowt_Cu = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Cu_2idd_0157.h5.txt';
lowt_Cr = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Cr_2idd_0157.h5.txt';

%UCF diamond wire
dw_elastic = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Si_2idd_0185.h5.txt';
dw_Ca = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ca_2idd_0185.h5.txt';
dw_Ti = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ti_2idd_0185.h5.txt';
dw_Fe = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Fe_2idd_0185.h5.txt';
dw_Ni = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Ni_2idd_0185.h5.txt';
dw_Cu = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Cu_2idd_0185.h5.txt';
dw_Cr = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Cr_2idd_0185.h5.txt';
dw_Al = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Al_2idd_0185.h5.txt';
dw_Zn = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Zn_2idd_0185.h5.txt';
dw_Pb = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Pb_L_2idd_0185.h5.txt';
dw_Sn = 'C:\Users\Mallory Jensen\Documents\Synchrotron\UCF\Quantified\output\ASCII_Sn_L_2idd_0185.h5.txt';

%% After we run the above section, then we get all of the data we specified

%Get all the maps for UCF low tau
[maplowt_elastic] = processAsciiFile(lowt_elastic,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Ca] = processAsciiFile(lowt_Ca,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Ti] = processAsciiFile(lowt_Ti,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Fe] = processAsciiFile(lowt_Fe,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Ni] = processAsciiFile(lowt_Ni,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Cu] = processAsciiFile(lowt_Cu,cutoff_flag,cutoff_min,cutoff_max);
[maplowt_Cr] = processAsciiFile(lowt_Cr,cutoff_flag,cutoff_min,cutoff_max);

%Get all the maps for UCF diamond wire
[mapdw_elastic] = processAsciiFile(dw_elastic,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Ca] = processAsciiFile(dw_Ca,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Ti] = processAsciiFile(dw_Ti,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Fe] = processAsciiFile(dw_Fe,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Ni] = processAsciiFile(dw_Ni,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Cu] = processAsciiFile(dw_Cu,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Cr] = processAsciiFile(dw_Cr,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Al] = processAsciiFile(dw_Al,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Zn] = processAsciiFile(dw_Zn,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Pb] = processAsciiFile(dw_Pb,cutoff_flag,cutoff_min,cutoff_max);
[mapdw_Sn] = processAsciiFile(dw_Sn,cutoff_flag,cutoff_min,cutoff_max);

%% UCF low tau

%Elastic first
hFig=figure;
image(maplowt_elastic.xValue,maplowt_elastic.yValue,maplowt_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([110 155]);
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
caxis([min(min(logged)) max(max(logged))]);
% caxis([3 10]);%ng
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
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 9]);%ng
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
caxis([min(min(logged)) max(max(logged))]);
% caxis([0 9]); %ng
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
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 5]); %ng
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
caxis([min(min(logged)) max(max(logged))]);
% caxis([0 6]);%ng
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
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

% threshold_Fe = data_Cu(index_Cu,8); %Choose the noise limit
% Make the new thresholded imagea
lowt_Ca_thresh = imbinarize(maplowt_Ca.counts,threshold_Ca_lowt); 
Ca_thresh = figure; 
image(maplowt_Ca.xValue,maplowt_Ca.yValue,lowt_Ca_thresh,'CDataMapping','scaled');
axis image;
lowt_Fe_thresh = imbinarize(maplowt_Fe.counts,threshold_Fe_lowt); 
Fe_thresh = figure; 
image(maplowt_Fe.xValue,maplowt_Fe.yValue,lowt_Fe_thresh,'CDataMapping','scaled');
axis image; 
lowt_Ti_thresh = imbinarize(maplowt_Ti.counts,threshold_Ti_lowt); 
Ti_thresh = figure; 
image(maplowt_Ti.xValue,maplowt_Ti.yValue,lowt_Ti_thresh,'CDataMapping','scaled');
axis image;
lowt_Ni_thresh = imbinarize(maplowt_Ni.counts,threshold_Ni_lowt); 
Ni_thresh = figure; 
image(maplowt_Ni.xValue,maplowt_Ni.yValue,lowt_Ni_thresh,'CDataMapping','scaled');
axis image;
lowt_Cu_thresh = imbinarize(maplowt_Cu.counts,threshold_Cu_lowt); 
Cu_thresh = figure; 
image(maplowt_Cu.xValue,maplowt_Cu.yValue,lowt_Cu_thresh,'CDataMapping','scaled');
axis image;
lowt_Cr_thresh = imbinarize(maplowt_Cr.counts,threshold_Cr_lowt); 
Cr_thresh = figure; 
image(maplowt_Cr.xValue,maplowt_Cr.yValue,lowt_Cr_thresh,'CDataMapping','scaled');
axis image;

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

set(Ca_thresh,'PaperPositionMode','auto');
print(Ca_thresh,'-dpng','-r0','UCF_lowt_Ca_thresh'); 
savefig(Ca_thresh,'UCF_lowt_Ca_thresh.fig');
set(Fe_thresh,'PaperPositionMode','auto');
print(Fe_thresh,'-dpng','-r0','UCF_lowt_Fe_thresh'); 
savefig(Fe_thresh,'UCF_lowt_Fe_thresh.fig');
set(Ti_thresh,'PaperPositionMode','auto');
print(Ti_thresh,'-dpng','-r0','UCF_lowt_Ti_thresh'); 
savefig(Ti_thresh,'UCF_lowt_Ti_thresh.fig');
set(Ni_thresh,'PaperPositionMode','auto');
print(Ni_thresh,'-dpng','-r0','UCF_lowt_Ni_thresh'); 
savefig(Ni_thresh,'UCF_lowt_Ni_thresh.fig');
set(Cu_thresh,'PaperPositionMode','auto');
print(Cu_thresh,'-dpng','-r0','UCF_lowt_Cu_thresh'); 
savefig(Cu_thresh,'UCF_lowt_Cu_thresh.fig');
set(Cr_thresh,'PaperPositionMode','auto');
print(Cr_thresh,'-dpng','-r0','UCF_lowt_Cr_thresh'); 
savefig(Cr_thresh,'UCF_lowt_Cr_thresh.fig');
%% UCF diamond wire

%Elastic first
hFig=figure;
image(mapdw_elastic.xValue,mapdw_elastic.yValue,mapdw_elastic.counts,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
% caxis([110 155]);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(hFig,'PaperPositionMode','auto');
axis off;
print('-dpng','-r0','UCF_dw_elastic');
savefig(hFig,'UCF_dw_elastic.fig');

%Ca first
logged = log(mapdw_Ca.counts.*1e3);
% logged = mapdw_Ca.counts;
Ca=figure;
image(mapdw_Ca.xValue,mapdw_Ca.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([3 10]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off; 
colorbar; 

%Ti first
logged = log(mapdw_Ti.counts.*1e3);
% logged = mapdw_Ti.counts;
Ti=figure;
image(mapdw_Ti.xValue,mapdw_Ti.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 9]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Fe first
logged = log(mapdw_Fe.counts.*1e3);
% logged = mapdw_Fe.counts;
Fe=figure;
image(mapdw_Fe.xValue,mapdw_Fe.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([0 9]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Ni first
logged = log(mapdw_Ni.counts.*1e3);
% logged = mapdw_Ni.counts;
Ni=figure;
image(mapdw_Ni.xValue,mapdw_Ni.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 5]); %ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Cu first
logged = log(mapdw_Cu.counts.*1e3);
% logged = mapdw_Cu.counts;
Cu=figure;
image(mapdw_Cu.xValue,mapdw_Cu.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([0 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Cr
logged = log(mapdw_Cr.counts.*1e3);
% logged = mapdw_Cr.counts;
Cr=figure;
image(mapdw_Cr.xValue,mapdw_Cr.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Al
logged = log(mapdw_Al.counts.*1e3);
% logged = mapdw_Al.counts;
Al=figure;
image(mapdw_Al.xValue,mapdw_Al.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Zn
logged = log(mapdw_Zn.counts.*1e3);
% logged = mapdw_Zn.counts;
Zn=figure;
image(mapdw_Zn.xValue,mapdw_Zn.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

%Pb
logged = log(mapdw_Pb.counts.*1e3);
% logged = mapdw_Pb.counts;
Pb=figure;
image(mapdw_Pb.xValue,mapdw_Pb.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar;

%Sn
logged = log(mapdw_Sn.counts.*1e3);
% logged = mapdw_Sn.counts;
Sn=figure;
image(mapdw_Sn.xValue,mapdw_Sn.yValue,logged,'CDataMapping','scaled');
% colormap(flipud(gray));
colormap(parula);
axis image; 
caxis([min(min(logged)) max(max(logged))]);
% caxis([1 6]);%ng
set(gca, 'XTick', []);
set(gca, 'YTick', []);
axis off;
colorbar; 

% Make the new thresholded imagea
dw_Ca_thresh = imbinarize(mapdw_Ca.counts,threshold_Ca_dw); 
Ca_thresh = figure; 
image(mapdw_Ca.xValue,mapdw_Ca.yValue,dw_Ca_thresh,'CDataMapping','scaled');
axis image;
dw_Fe_thresh = imbinarize(mapdw_Fe.counts,threshold_Fe_dw); 
Fe_thresh = figure; 
image(mapdw_Fe.xValue,mapdw_Fe.yValue,dw_Fe_thresh,'CDataMapping','scaled');
axis image; 
dw_Ti_thresh = imbinarize(mapdw_Ti.counts,threshold_Ti_dw); 
Ti_thresh = figure; 
image(mapdw_Ti.xValue,mapdw_Ti.yValue,dw_Ti_thresh,'CDataMapping','scaled');
axis image;
dw_Ni_thresh = imbinarize(mapdw_Ni.counts,threshold_Ni_dw); 
Ni_thresh = figure; 
image(mapdw_Ni.xValue,mapdw_Ni.yValue,dw_Ni_thresh,'CDataMapping','scaled');
axis image;
dw_Cu_thresh = imbinarize(mapdw_Cu.counts,threshold_Cu_dw); 
Cu_thresh = figure; 
image(mapdw_Cu.xValue,mapdw_Cu.yValue,dw_Cu_thresh,'CDataMapping','scaled');
axis image;
dw_Cr_thresh = imbinarize(mapdw_Cr.counts,threshold_Cr_dw); 
Cr_thresh = figure; 
image(mapdw_Cr.xValue,mapdw_Cr.yValue,dw_Cr_thresh,'CDataMapping','scaled');
axis image;
dw_Al_thresh = imbinarize(mapdw_Al.counts,threshold_Al_dw); 
Al_thresh = figure; 
image(mapdw_Al.xValue,mapdw_Al.yValue,dw_Al_thresh,'CDataMapping','scaled');
axis image;
dw_Zn_thresh = imbinarize(mapdw_Zn.counts,threshold_Zn_dw); 
Zn_thresh = figure; 
image(mapdw_Zn.xValue,mapdw_Zn.yValue,dw_Zn_thresh,'CDataMapping','scaled');
axis image;
dw_Pb_thresh = imbinarize(mapdw_Pb.counts,threshold_Pb_dw); 
Pb_thresh = figure; 
image(mapdw_Pb.xValue,mapdw_Pb.yValue,dw_Pb_thresh,'CDataMapping','scaled');
axis image;
dw_Sn_thresh = imbinarize(mapdw_Sn.counts,threshold_Sn_dw); 
Sn_thresh = figure; 
image(mapdw_Sn.xValue,mapdw_Sn.yValue,dw_Sn_thresh,'CDataMapping','scaled');
axis image;

set(Ca,'PaperPositionMode','auto');
print(Ca,'-dpng','-r0','UCF_dw_Ca');
savefig(Ca,'UCF_dw_Ca.fig');
set(Fe,'PaperPositionMode','auto');
print(Fe,'-dpng','-r0','UCF_dw_Fe');
savefig(Fe,'UCF_dw_Fe.fig');
set(Ti,'PaperPositionMode','auto');
print(Ti,'-dpng','-r0','UCF_dw_Ti');
savefig(Ti,'UCF_dw_Ti.fig');
set(Ni,'PaperPositionMode','auto');
print(Ni,'-dpng','-r0','UCF_dw_Ni');
savefig(Ni,'UCF_dw_Ni.fig');
set(Cu,'PaperPositionMode','auto');
print(Cu,'-dpng','-r0','UCF_dw_Cu');
savefig(Cu,'UCF_dw_Cu.fig');
set(Cr,'PaperPositionMode','auto');
print(Cr,'-dpng','-r0','UCF_dw_Cr');
savefig(Cr,'UCF_dw_Cr.fig');
set(Al,'PaperPositionMode','auto');
print(Al,'-dpng','-r0','UCF_dw_Al');
savefig(Al,'UCF_dw_Al.fig');
set(Zn,'PaperPositionMode','auto');
print(Zn,'-dpng','-r0','UCF_dw_Zn');
savefig(Zn,'UCF_dw_Zn.fig');
set(Pb,'PaperPositionMode','auto');
print(Pb,'-dpng','-r0','UCF_dw_Pb');
savefig(Pb,'UCF_dw_Pb.fig');
set(Sn,'PaperPositionMode','auto');
print(Sn,'-dpng','-r0','UCF_dw_Sn');
savefig(Sn,'UCF_dw_Sn.fig');

set(Ca_thresh,'PaperPositionMode','auto');
print(Ca_thresh,'-dpng','-r0','UCF_dw_Ca_thresh'); 
savefig(Ca_thresh,'UCF_dw_Ca_thresh.fig');
set(Fe_thresh,'PaperPositionMode','auto');
print(Fe_thresh,'-dpng','-r0','UCF_dw_Fe_thresh'); 
savefig(Fe_thresh,'UCF_dw_Fe_thresh.fig');
set(Ti_thresh,'PaperPositionMode','auto');
print(Ti_thresh,'-dpng','-r0','UCF_dw_Ti_thresh'); 
savefig(Ti_thresh,'UCF_dw_Ti_thresh.fig');
set(Ni_thresh,'PaperPositionMode','auto');
print(Ni_thresh,'-dpng','-r0','UCF_dw_Ni_thresh'); 
savefig(Ni_thresh,'UCF_dw_Ni_thresh.fig');
set(Cu_thresh,'PaperPositionMode','auto');
print(Cu_thresh,'-dpng','-r0','UCF_dw_Cu_thresh'); 
savefig(Cu_thresh,'UCF_dw_Cu_thresh.fig');
set(Cr_thresh,'PaperPositionMode','auto');
print(Cr_thresh,'-dpng','-r0','UCF_dw_Cr_thresh'); 
savefig(Cr_thresh,'UCF_dw_Cr_thresh.fig');
set(Al_thresh,'PaperPositionMode','auto');
print(Al_thresh,'-dpng','-r0','UCF_dw_Al_thresh'); 
savefig(Al_thresh,'UCF_dw_Al_thresh.fig');
set(Zn_thresh,'PaperPositionMode','auto');
print(Zn_thresh,'-dpng','-r0','UCF_dw_Zn_thresh'); 
savefig(Zn_thresh,'UCF_dw_Zn_thresh.fig');
set(Pb_thresh,'PaperPositionMode','auto');
print(Pb_thresh,'-dpng','-r0','UCF_dw_Pb_thresh'); 
savefig(Pb_thresh,'UCF_dw_Pb_thresh.fig');
set(Sn_thresh,'PaperPositionMode','auto');
print(Sn_thresh,'-dpng','-r0','UCF_dw_Sn_thresh'); 
savefig(Sn_thresh,'UCF_dw_Sn_thresh.fig');