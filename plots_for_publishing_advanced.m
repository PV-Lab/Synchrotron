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
%Where are the particle summaries located
filename_summary = 'C:\Users\Mallory Jensen\Documents\Synchrotron\NTNU'; 
filename_summary = [filename_summary '\20171103_scan_summary.xlsx'];
% %Get the grain boundary length
% [num,txt] = xlsread(filename_summary,'scan summary'); 
% GB_length = [num(2:end,3) num(2:end,22)]; 

%Do you want to circle the particles?
circle_parts = 'N'; 
radius = 0.00075; 
linewidth = 4; 

%Do you want to calculate line density of particles?
density_calc = 'N'; 

%Where are the directories we want to look
dir_2016c3 = 'C:\Users\Mallory Jensen\Documents\Synchrotron\NTNU\2016c3\output'; 
dir_2017c1 = 'C:\Users\Mallory Jensen\Documents\Synchrotron\NTNU\2016c3\output'; 

all_dir = {dir_2016c3,dir_2017c1}; 

%What are the samples within those directories
samp_2016c3 = {{'0148'},{'0149'},{'0152'}};
name_2016c3 = {'138 ROI 2','138 ROI 1 - 1','138 ROI 1 - 2'}; 
cax_2016c3 = {{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]}};
samp_2017c1 = {{'0032'},{'0038'},{'0039'}};
name_2017c1 = {'137 ROI 1','137 ROI 2 - 1','137 ROI 2 - 2'};
cax_2017c1 = {{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]},{[],[],[],[],[]}};

%Threshold?
threshold = 'Y'; 
thresholds_2016c3 = {{[],[],[7.553132849],[3.259183339],[4.280697346]},...
    {[],[],[7.553132849],[3.259183339],[4.280697346]},...
    {[],[],[9.250660719],[3.99166808],[5.242762121]}};
thresholds_2017c1 = {{[],[],[8.587926147],[4.348457702],[5.359043335]},...
    {[],[],[23.51900436],[11.90874187],[14.67634461]},...
    {[],[],[33.26089495],[16.84150426],[20.75548559]}};



%How many metals do we have
% metals = {'s_e','Si','Fe','Cu','Ni','Co','Ca'}; 
metals = {'s_e','Si','Fe','Cu','Ni'}; 
%Let's read the particle data'
% for i = 1:length(metals)
%     if strcmp(metals{i},'s_e')==0 && strcmp(metals{i},'Si')==0
%         [num,txt] = xlsread(filename_summary,metals{i}); 
%         %pick out the relevant data
%         scans = num(:,1); 
%         x = num(:,9); 
%         y = num(:,10); 
%         atoms = num(:,9); 
%         particles.(metals{i})=struct('scans',scans,'x',x,'y',y,'Natoms',atoms); 
%     end
% end

cutOff = 99;
cutoff_flag = 0;
cutoff_min = 88;
cutoff_max = 95;

all_samp = {samp_2016c3,samp_2017c1}; 
all_names = {name_2016c3,name_2017c1}; 
all_cax = {cax_2016c3,cax_2017c1};
all_thresholds = {thresholds_2016c3,thresholds_2017c1}; 

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
    thresholds_now = all_thresholds{i}; 
    no_samp = length(samples_thisrun); 
    density_store_run = cell(no_samp,1); 
    cax_thisrun = all_cax{i}; 
    for j = 1:no_samp
       scans_thisrun = samples_thisrun{j}; 
       no_scans = length(scans_thisrun); 
       cax_thissample = cax_thisrun{j}; 
       thresholds_thissample = thresholds_now{j}; 
       if strcmp(density_calc,'Y')==1
           %We want to look at the line density
           density = zeros(length(size_bins)-1,length(metals)-2); 
       end
       for k = 1:length(metals)
           %We'll make one figure together for these scans
           pubmap = figure; 
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
               %Make the threshold images
               if strcmp(threshold,'Y')==1 && strcmp(metals{k},'s_e')==0 &&...
                       strcmp(metals{k},'Si')==0
                    threshold_now = thresholds_thissample{k}; 
                    %Make the new thresholded image
                    thresh_map = imbinarize((easy_maps.counts).*1e-6.*1e9,threshold_now); 
                    thresh_fig = figure; 
                    image(easy_maps.xValue,easy_maps.yValue,thresh_map,'CDataMapping','scaled');
               end
           end
           figure(pubmap)
           %Now we're done plotting all of the scans
           colormap(parula); 
           axis image; 
           set(gca, 'XTick', []);
           set(gca, 'YTick', []);
           axis off;
           colorbar; 
%            if isempty(cax_thissample{k})==0
%                caxis(log(cax_thissample{k})); 
%            end
           %save the figure
           fig = gcf; 
           set(fig,'PaperPositionMode','auto');
           print(fig,'-dpng','-r0',[dir_thisrun '\' names_thisrun{j} '_' metals{k} '.png']); 
           savefig(fig,[dir_thisrun '\' names_thisrun{j} '_' metals{k} '.fig']);
           if strcmp(threshold,'Y')==1 && strcmp(metals{k},'s_e')==0 &&...
                       strcmp(metals{k},'Si')==0
               %Same for threshold
               figure(thresh_fig); 
               colormap(parula); 
               axis image; 
               set(gca, 'XTick', []);
               set(gca, 'YTick', []);
               axis off;
               set(thresh_fig,'PaperPositionMode','auto');
               print(thresh_fig,'-dpng','-r0',[dir_thisrun '\' names_thisrun{j} '_' metals{k} '_threshold.png']); 
               savefig(thresh_fig,[dir_thisrun '\' names_thisrun{j} '_' metals{k} '_threshold.fig']);
           end
       end
       if strcmp(density_calc,'Y')==1
           density_storerun{j} = density; 
       end
    end
    if strcmp(density_calc,'Y')==1
       density_store{i} = density_storerun; 
    end
end
           