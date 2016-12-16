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

%calculatePrecipitateSize


%choose the pixel of maximum counts within the "particle"
    
%%
% Nparticles = 1;
map.particleRadius = zeros(1,Nparticles);
N_Cr_atoms = zeros(1, Nparticles);

% disp(map)
Npcps = 0;

realCounts = scaledCounts;

% figure(scaledCr); hold on;

if strcmp(options.plots,'on')
    figure(rawMap);
    title(map.title);
end
for i=1:Nparticles
    
        
        partMaxCounts(i) = partMaxCounts(i)*1e-6*1e-4*1e-4; %g/um2

        
        
        N_Cr_atoms(i) = partMaxCounts(i)*N_A*spotArea/wtCr; %atoms in precipitate from max count pixel 
        
        
        
        if N_Cr_atoms(i) > detLimitAtoms
            
            Npcps = Npcps + 1;
            map.particleN_Cr_atoms(i) = N_Cr_atoms(i);
            
            map.particleN_Cr_atomsAdj(Npcps) = N_Cr_atoms(i);
            
            map.particleMaxX(i) = maxX(i);
            map.particleMaxY(i) = maxY(i);
%            
            if find(nBigPartsIdx == i)
                map.bigParticle(Npcps) = 1;
            else
                map.bigParticle(Npcps) = 0;
            end
            
            if strcmp(options.plots,'on')
                %disp(num2str(i))
                if find(nBigPartsIdx == i)
                    text(maxX(i)+2,maxY(i)+2,1e8,num2str(i),'BackgroundColor','w');
                else
                    text(maxX(i)+2,maxY(i)+2,1e8,num2str(i),'BackgroundColor','y');
                end
            end
            
%             if strcmp(options.plots,'on')
%     
%                 
%                 plot(maxX(i),maxY(i), 'go','MarkerSize',5);
%                 text(maxX(i),maxY(i),num2str(i),'BackgroundColor','w');
%     
%             end
           
        else
            map.particleN_Cr_atoms(i) = -N_Cr_atoms(i);
            
            %Remove the particle from the map of real coutns
            partPixelList = s(i).PixelList;
            [q r] = size(partPixelList);
            
            for k = 1:q
            
                realCounts(partPixelList(k,2), partPixelList(k,1)) = 0; %need to fliplr (X, Y) to get m x n coordinates
            end
        end
        
        radiusCm = ((3/4/pi)*abs(map.particleN_Cr_atoms(i))*V_CrSi2_unitcell)^(1/3); %cm
        
       
        map.particleRadius(i) = radiusCm/1e-7; %nm
        
        
    
end



if Nparticles == 0 || all(map.particleN_Cr_atoms<0) 
    map.particleN_Cr_atomsAdj = 1;
     map.particleN_Cr_atoms = 1;
end

%Calculate size of particle that would result from noise limit estimationI
if ~exist('map.noiseLimitAtoms', 'var')
    noiseLimitLoading = map.noiseLimit*1e-6*1e-4*1e-4;
    map.noiseLimitAtoms = noiseLimitLoading*N_A*spotArea/wtCr;
    map.noiseLimitR = (((3/4/pi)*abs(map.noiseLimitAtoms)*V_CrSi2_unitcell)^(1/3))/1e-7; %nm
    map.noiseMeanAtoms = map.noiseMean*1e-6*1e-4*1e-4*N_A*spotArea/wtCr;
end

map.realCounts = realCounts;

map.meanPartR = mean(map.particleRadius); %includes all particles above bckgnd

map.Nparticles = Npcps;

map.meanPartAtomsAdj= mean(map.particleN_Cr_atoms(map.particleN_Cr_atoms > detLimitAtoms));
% mean(map.particleN_Cr_atomsAdj)
map.meanPartRadj = mean(map.particleRadius(map.particleRadius>detLimitRadius));%To calculate for particles that have atoms more than detection limit

map.particleRadiusAdj = map.particleRadius(map.particleRadius>detLimitRadius);