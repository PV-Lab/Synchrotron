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

%Calculate precipitate density
    map.width = (max(map.xValue)-min(map.xValue))*1000;  %um
    map.height= (max(map.yValue)-min(map.yValue))*1000;  %um
    map.area  = map.width*map.height;                       %um2
    
    
    map.xStep = (max(map.xValue)-min(map.xValue))*1000/(n-1); %um
    map.yStep = (max(map.yValue)-min(map.yValue))*1000/(m-1); %um
    
    roughDensityPcpsUm = Npcps/map.width/map.height/infoD; %N particles > detection limit / um3
    
    map.lineDensityPcpsRough = Npcps/map.width; % um^-1
    map.densityPcps = roughDensityPcpsUm*1e12; %cm-3d
    
%     if I2Esample == 'y'
        %calculate GB area
%         GBarea = 0;
% 
%         for i = linesToFit
% 
%             GBarea = GBarea + length(GBdomain{i})*map.yStep*map.xStep; %um2
% 
%         end
% 
%         map.GBarea = GBarea;
% %     else
% %         GBarea = 597; %size of the smaller 312, 313 maps, equivalent to the GB area of the larger maps
% %     end
% 
%     map.densityPcpsAdj = Npcps/GBarea/infoD*1e12; %/um3 to /cm3

s = 0;
dx = 1; %pixel
for i = 1:length(map.GBline)-1
    
    dy = map.GBline(i+1)-map.GBline(i); %pixels
    ds = sqrt(1+(dy/dx)^2)*dx;
    s  = s + ds;
end
    
map.GBlengthPixels = s;
if abs(map.xStep - map.yStep) < 1e-3 %make sure they have same step size
    map.GBlengthUm = map.GBlengthPixels*map.xStep;
    map.lineDensityPcpsInvUm = Npcps/map.GBlengthUm; 
else
    disp('Need to check in on the map step sizes for computing GB line length');
end


