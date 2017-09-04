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

%constants

    pixelSize = 0.22; %um
    
    %Fe edge attenuation lengths
    %l_6404 = 36.526; %um
    %l_7150 = 50.238; %um
    
    %Cr edge attenuation lengths
    l_10000= 133.707; %um
%     l_5414 = 22.59; %um
    %Wafer thickness
    t = 170; %um
    
    %Cu edge attenuation lengths
    l_9000 = 98.1814; %um
    l_8048 = 70.8421; %Cu
    l_7478 = 57.2171; %Ni
    l_4510 = 13.4670; %Ti
    
    theta0 = 5*pi/12; %Guess 75 degrees for GB angle

    %Detector Geometry
    alphaAngle  = 12*pi/180;   %incident angle (15 degrees)
    betaAngle   = 78*pi/180; %exiting angle  (75 degress)
    
    %Calculate information depth
%     infoD = 1/(1/(cos(alphaAngle)*l_9000)+1/(cos(betaAngle)*l_5414));

    %This is for Cu at 10 keV
%     infoD = 1/(1/(cos(alphaAngle)*l_10000)+1/(cos(betaAngle)*l_8048));

    %This is for Ni at 10 keV
    infoD = 1/(1/(cos(alphaAngle)*l_10000)+1/(cos(betaAngle)*l_7478));

    %This is for Cu at 9 keV
%     infoD = 1/(1/(cos(alphaAngle)*l_9000)+1/(cos(betaAngle)*l_8048));

    %This is for Ni at 9 keV
%     infoD = 1/(1/(cos(alphaAngle)*l_9000)+1/(cos(betaAngle)*l_7478));

    %Fe at 9 keV
%     infoD = 1/(1/(cos(alphaAngle)*l_9000)+1/(cos(betaAngle)*l_6404));
    
    %Ti at 9 keV
%     infoD = 1/(1/(cos(alphaAngle)*l_9000)+1/(cos(betaAngle)*l_4510));
    
        
%     %beta-FeSi2 lattice parameters from Dusausoy et al.
% 
%     a = 9.863e-8; %cm
%     b = 7.791e-8;  
%     c = 7.833e-8;
%     Z = 16;
% 
%     V_FeSi2_unitcell = a*b*c/Z; %cm3, volume of one primitive cell of beta-FeSi2
% 
%     wtFe     = 55.845; %g/mol
%     wtFeSi2  = 112.016; %g/mol
     N_A      = 6.022e23; %atoms/mol
%     
%     convertArealToVolConc = 1e-6*N_A/wtFe/infoD*1e4;
    
    %CrSi2 lattice parameters
    
%     Cr_a = 4.43e-8; %cm
%     Cr_c = 6.37e-8; %cm
%     Cr_Z = 3; %Cr atoms in unit cell
%     
%     V_CrSi2_unitcell = (Cr_a^2)*Cr_c*sin(60*2*pi/360)/Cr_Z; %cm^3, hexagonal
%     
%     wtCr = 51.9961; %g/mol
%     wtSi = 28.0855; %g/mol
%     wtCrSi2 = wtCr+(2*wtSi); %g/mol
%     
%     covertArealToVolConc_Cr = (1e-6)*N_A/wtCr/infoD*1e4; 
    
    %CuSi? lattice parameters
    %Note - these are not correct as of 1/6/17!
    Cu_a = 4.43e-8; %cm
    Cu_c = 6.37e-8; %cm
    Cu_Z = 3; %Cr atoms in unit cell
    
    V_CuSi2_unitcell = (Cu_a^2)*Cu_c*sin(60*2*pi/360)/Cu_Z; %cm^3, hexagonal
    
    wtCu = 63.546; %g/mol
%     wtCu = 58.6934; %g/mol, this is actually Ni
    wtSi = 28.0855; %g/mol
    wtCuSi2 = wtCu+(2*wtSi); %g/mol
    
    covertArealToVolConc_Cu = (1e-6)*N_A/wtCu/infoD*1e4; 
    
    
    %sensitivity limit
    spotSize = 0.21; %um diameter
    spotArea = pi/4*spotSize^2;
    
    detLimit     = 1e14; %atoms/cm2/sec
    
    detLimitUm   = 1e14*1e-4*1e-4; %atoms/um2;
    detLimitAtoms_generic = spotArea*detLimitUm;
    detLimitAtoms = detLimitAtoms_generic;
    
    
    
%     %mdl_7150
%     mdl_7150_attogram = 5; %these are for 2010c1
%     mdl_7150_atoms = mdl_7150_attogram*1e-18/wtFe*N_A;
%     mdl_10000_attogram = 15.6; %these are for 2010c1  %18.3 for 2010c3, 6.6 for 2011c1...the difference being...?
%     mdl_10000_atoms = mdl_10000_attogram*1e-18/wtFe*N_A;
%     if exist('map','var')
%         if ~isempty(strfind(map.title,'Fe53bPDG')) || ~isempty(strfind(map.title,'Fe200bPDG'))
%             detLimitAtoms = mdl_10000_atoms;
%             fprintf('Using MDL at 10 keV: %d \n',detLimitAtoms);
%         elseif ~isempty(strfind(map.title,'Fe53')) || ~isempty(strfind(map.title,'Fe200'))
%             detLimitAtoms = mdl_7150_atoms;
%             fprintf('Using MDL at Fe edge: %d, \n',detLimitAtoms);
%            
%         else
%              detLimitAtoms = detLimitAtoms_generic;
%             fprintf('Assuming MDL generic 1e14 atoms/cm^2:%d \n', detLimitAtoms);
%         end
%     else
%         detLimitAtoms = detLimitAtoms_generic;
%         fprintf('Assuming generic MDL 1e14 atoms/cm^2:%d \n', detLimitAtoms);
%     end
   
    
    detLimitRadius= ((3/4/pi)*detLimitAtoms*V_CuSi2_unitcell)^(1/3)/1e-7; %cm
      
      