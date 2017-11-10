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
set(0,'DefaultAxesFontSize',20) 

%Where are the particle summaries located
filename_summary = 'C:\Users\Mallory Jensen\Documents\Synchrotron\HPMC vs. mc-Si\Synchrotron data'; 
filename_summary = [filename_summary '\20171011_scan_particle_summary.xlsx'];
%Get the grain boundary length
[num,txt] = xlsread(filename_summary,'scan summary'); 
GB_length = [num(2:end,3) num(2:end,22)]; 

%Do you want to circle the particles?
circle_parts = 'N'; 
radius = 0.00075; 
linewidth = 4; 

%Do you want to calculate line density of particles?
density_calc = 'N'; 

%Where are the directories we want to look
dir_2017c1 = 'C:\Users\Mallory Jensen\Documents\Synchrotron\HPMC vs. mc-Si\Synchrotron data\2017c1 Barry quantified\output'; 
dir_2017c2 = 'C:\Users\Mallory Jensen\Documents\Synchrotron\HPMC vs. mc-Si\Synchrotron data\2017c2 Barry quantified\output'; 
dir_2017c3 = 'C:\Users\Mallory Jensen\Documents\Synchrotron\HPMC vs. mc-Si\Synchrotron data\2017c3 MIT quantified\output';

all_dir = {dir_2017c1,dir_2017c2,dir_2017c3}; 
% all_dir = {dir_2017c3}; 

%What are the samples within those directories
% samp_2017c1 = {{'0089' '0091'},{'0109' '0115'},{'0127'}};%stitched
% name_2017c1 = {'HPMC RA 18.3','conv RA 18.6','HPMC sigma9 37.9'};%stitched 
% samp_2017c2 = {{'0124'},{'0129','0130','0131'},{'0138'},{'0146','0149','0156'},...
%     {'0160','0161'},{'0170','0171'},{'0181'},{'0189'},{'0194'}};%stitched
% name_2017c2 = {'HPMC RA 50','HPMC sigma9 39.5','HPMC RA 16.8','HPMC sigma3 59.7',...
%     'conv sigma27','conv RA 50','conv sigma9 39.1','conv sigma 3','conv RA 23.2'}; %stitched
samp_2017c1 = {{'0089'},{'0091'},{'0109'},{'0115'},{'0127'}};
name_2017c1 = {'HPMC RA 18.3-1','HPMC RA 18.3-2',...
    'conv RA 18.6-1','conv RA 18.6-2','HPMC sigma9 37.9'}; 
cax_2017c1 = {{[],[],[0.0042 0.0248],[0.002 0.153],[0.001 0.377]},...
    {[],[],[0.0068 0.0246],[0.0021 0.0688],[0.002 0.156]},...
    {[],[],[0.0053 0.0255],[0.0001 5.38],[0.0001 0.553]},...
    {[],[],[0.0062 0.0230],[0.0001 1.44],[0.0001 0.170]},...
    {[],[],[],[],[]}};
samp_2017c2 = {{'0124'},{'0129'},{'0130'},{'0131'},{'0138'},{'0146'},{'0149'},{'0156'},...
    {'0160'},{'0161'},{'0170'},{'0171'},{'0181'},{'0189'},{'0194'}};
name_2017c2 = {'HPMC RA 50','HPMC sigma9 39.5-1','HPMC sigma9 39.5-2',...
    'HPMC sigma9 39.5-3','HPMC RA 16.8','HPMC sigma3 59.7-1',...
    'HPMC sigma3 59.7-2','HPMC sigma3 59.7-3','conv sigma27-1',...
    'conv sigma27-2','conv RA 50-1','conv RA 50-2','conv sigma9 39.1',...
    'conv sigma 3','conv RA 23.2'};
cax_2017c2 = {{[],[],[0.0041 0.0292],[0.027 0.380],[0.0001 0.367]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},...
    {[],[],[0.0041 0.0235],[0.017 0.146],[0.001 0.153]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},...
    {[],[],[],[],[]},{[],[],[0.0035 0.365],[0.0138 0.0338],[0.0016 0.0142]},{[],[],[0.0155 0.0363],[0.0138 0.0558],[0.0026 0.0124]},...
    {[],[],[],[],[]},{[],[],[],[],[]},{[],[],[0.0029 0.0199],[0.0026 0.0144],[0.0014 0.0106]}};
% samp_2017c2 = {{'0124'},{'0129'},{'0130'},{'0131'},{'0138'},{'0146'},{'0149'},{'0156'},...
%     {'0160'},{'0161'},{'0170','0171'},{'0181'},{'0189'},{'0194'}};
% name_2017c2 = {'HPMC RA 50','HPMC sigma9 39.5-1','HPMC sigma9 39.5-2',...
%     'HPMC sigma9 39.5-3','HPMC RA 16.8','HPMC sigma3 59.7-1',...
%     'HPMC sigma3 59.7-2','HPMC sigma3 59.7-3','conv sigma27-1',...
%     'conv sigma27-2','conv RA 50','conv sigma9 39.1',...
%     'conv sigma 3','conv RA 23.2'};
% cax_2017c2 = {{[],[],[0.0041 0.0292],[0.027 0.380],[0.0001 0.367]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},...
%     {[],[],[0.0041 0.0235],[0.017 0.146],[0.001 0.153]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},...
%     {[],[],[],[],[]},{[],[],[0.0035 0.365],[0.0138 0.0558],[0.0016 0.0142]},...
%     {[],[],[],[],[]},{[],[],[],[],[]},{[],[],[0.0029 0.0199],[0.0026 0.0144],[0.0014 0.0106]}};
samp_2017c3 = {{'0034'},{'0039'},{'0051'},{'0025'},{'0047'},{'0043'}};
name_2017c3 = {'HPMC RA 37-1','HPMC RA 37-2','conv RA 37-1',...
    'conv RA 37-2','conv sigma9 40-1','conv sigma9 40-2'}; 
cax_2017c3 = {{[],[],[0.0056 0.0618],[0.0001 1.58],[0.0001 1.42]},{[],[],[0.0062 0.0480],[0.0001 0.677],[0.0001 1.11]},{[],[],[0.003 0.154],[0.0023 0.0284],[0.0022 0.0198]},...
    {[],[],[0.0058 0.0640],[0.0181 0.0604],[0.0016 0.0165]},{[],[],[],[],[]},{[],[],[],[],[]}};
% samp_2017c3 = {{'0034','0039'},{'0051'},{'0025'},{'0047'},{'0043'}};
% name_2017c3 = {'HPMC RA 37','conv RA 37-1',...
%     'conv RA 37-2','conv sigma9 40-1','conv sigma9 40-2'}; 
% cax_2017c3 = {{[],[],[0.0056 0.0618],[0.0001 1.58],[0.0001 1.42]},{[],[],[0.003 0.154],[0.0023 0.0284],[0.0022 0.0198]},...
%     {[],[],[0.0058 0.0640],[0.0181 0.0604],[0.0016 0.0165]},{[],[],[],[],[]},{[],[],[],[],[]}};

%How many metals do we have
metals = {'s_e','Si','Fe','Cu','Ni'}; 
%Let's read the particle data'
for i = 1:length(metals)
    if strcmp(metals{i},'s_e')==0 && strcmp(metals{i},'Si')==0
        [num,txt] = xlsread(filename_summary,metals{i}); 
        %pick out the relevant data
        scans = num(:,1); 
        x = num(:,7); 
        y = num(:,8); 
        atoms = num(:,9); 
        particles.(metals{i})=struct('scans',scans,'x',x,'y',y,'Natoms',atoms); 
    end
end

cutOff = 99;
cutoff_flag = 0;
cutoff_min = 88;
cutoff_max = 95;

all_samp = {samp_2017c1,samp_2017c2,samp_2017c3}; 
all_names = {name_2017c1,name_2017c2,name_2017c3}; 
all_cax = {cax_2017c1,cax_2017c2,cax_2017c3};
% all_samp = {samp_2017c3}; 
% all_names = {name_2017c3}; 

if strcmp(density_calc,'Y')==1
    %Prep for gathering the line density information
    size_bins = logspace(0,8,20); 
    size_bins_plot = zeros(1,length(size_bins)-1);
    for i = 1:length(size_bins_plot)
        sbin = logspace(log10(size_bins(i)),log10(size_bins(i+1)),3); 
        size_bins_plot(i) = sbin(2);
    end
end

no_runs = length(all_dir); 
density_store = cell(no_runs,1); 
for i = 1:no_runs
    dir_thisrun = all_dir{i}; 
    samples_thisrun = all_samp{i}; 
    names_thisrun = all_names{i}; 
    no_samp = length(samples_thisrun); 
    density_store_run = cell(no_samp,1); 
    cax_thisrun = all_cax{i}; 
    for j = 1:no_samp
       scans_thisrun = samples_thisrun{j}; 
       no_scans = length(scans_thisrun); 
       cax_thissample = cax_thisrun{j}; 
       if strcmp(density_calc,'Y')==1
           %We want to look at the line density
           density = zeros(length(size_bins)-1,length(metals)-2); 
       end
       for k = 1:length(metals)
           %We'll make one figure together for these scans
           figure; 
           for m = 1:no_scans
               %make the filename
               filename = [dir_thisrun '\ASCII_' metals{k} '_2idd_' ...
                   scans_thisrun{m} '.h5.txt'];
               %read the data
               maps.(genvarname([metals{k} '_' scans_thisrun{m}])) = ...
                   processAsciiFile(filename,cutoff_flag,cutoff_min,cutoff_max); 
               %let's take the log of these counts
               easy_maps = maps.(genvarname([metals{k} '_' scans_thisrun{m}])); 
               logged = log10(easy_maps.counts.*1e3); 
               image(easy_maps.xValue,easy_maps.yValue,logged,'CDataMapping','scaled'); 
               hold all; 
               if strcmp(circle_parts,'Y')==1 && strcmp(metals{k},'s_e')==0 &&...
                       strcmp(metals{k},'Si')==0
                   %Let's also get the particle information
                   particles_now = particles.(metals{k}); 
                   index_parts = find(particles_now.scans==str2num(scans_thisrun{m})); 
                   xparts = particles_now.x(index_parts); 
                   yparts = particles_now.y(index_parts); 
                   for n = 1:length(xparts)
                       x_now = (xparts(n)-radius):(radius/1000):(xparts(n)+radius);
                       %Calculate respective y-values
                       y_now = sqrt((radius^2)-((x_now-xparts(n)).^2))+yparts(n); 
                       y_now_opp = -sqrt((radius^2)-((x_now-xparts(n)).^2))+yparts(n);
                       plot(x_now,y_now,'r','LineWidth',linewidth); 
                       hold all;
                       plot(x_now,y_now_opp,'r','LineWidth',linewidth);
                       hold all; 
                   end
               end
               %Calculate the line density of particles
               if strcmp(density_calc,'Y')==1 && strcmp(metals{k},'s_e')==0 &&...
                       strcmp(metals{k},'Si')==0
                   particles_now = particles.(metals{k}); 
                   index_parts = find(particles_now.scans==str2num(scans_thisrun{m}));
                   xparts = particles_now.x(index_parts); 
                   yparts = particles_now.y(index_parts);
                   partsize = particles_now.Natoms(index_parts); 
                   %Now we need to loop over the size bins
                    for sz = 1:(length(size_bins)-1)
                        index_bin = find(partsize>=size_bins(sz)); 
                        parts_bin = partsize(index_bin); 
                        index = find(parts_bin<size_bins(sz+1)); 
                        parts_bin = parts_bin(index); 
                        %now for this size bin we just count the number and divide by the
                        %GB length
                        %Get the GB length
                        index_length = find(GB_length(:,1)==str2num(scans_thisrun{m})); 
                        density(sz,k-2) = length(parts_bin)/GB_length(index_length,2); %ppt/micron
                    end
               end 
           end
           %Now we're done plotting all of the scans
           colormap(parula); 
           axis image; 
           set(gca, 'XTick', []);
           set(gca, 'YTick', []);
           axis off;
           colorbar; 
           if isempty(cax_thissample{k})==0
               caxis(log10(cax_thissample{k}.*1e3)); 
           end
           %save the figure
           fig = gcf; 
           set(fig,'PaperPositionMode','auto');
           print(fig,'-dpng','-r0',[dir_thisrun '\' names_thisrun{j} '_' metals{k} '.png']);    
       end
       if strcmp(density_calc,'Y')==1
           density_storerun{j} = density; 
       end
    end
    if strcmp(density_calc,'Y')==1
       density_store{i} = density_storerun; 
    end
end
           