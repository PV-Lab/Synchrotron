function [map] = fitBackground(map, nSigma, cutOff)
%[map] = fitBackground(map, nSigma, cutOff) requires an input map from 2IDD and
%a sigma for determining the noise limit of the map.  In addition a cutoff
%value is required for determing at what percentile the data should be
%cutoff for determining the truncated gaussian distribution of noise

%for details on truncated normal distribution fitting, see
% http://en.wikipedia.org/wiki/Truncated_normal_distribution

%for details on left truncated normal in matlab, see
%http://mathforum.org/kb/thread.jspa?forumID=80&threadID=1179922&messageID=3857449

global pon

    cts = map.cts;  %a 1D vector of XRF counts from all the pixels of the map for creating a histogram 
    
    xTrunc = 0;     %left side truncation limit;
    % xTrunc = min(cts);  %Could make this the left side truncation limit if the distribution is shifted very far from zero 


%fit a normal distribution to determine background noise cutoff
    
    %get rid of huge outliers for fitting purposes. Let the minimum be the
    %zeroth percentile, and the maximum be the 100th percentile. Cut off
    %anything between 99 and 100 to obtain a good fit that we can use for
    %identifying precipitates later.
    cts = cts(cts<prctile(cts,cutOff));
    
      
    %anonymous pdf 
    % AEM pdf means probability density function
    % AEM cdf means cumulative density function
    pdf_truncnorm = @(x, mu, sigma) normpdf(x,mu,sigma)./(1-normcdf(xTrunc,mu,sigma)); %will create left truncated normal distribution 
    start = [mean(cts) std(cts)];  %guess of background noise (mean, sd);
   
    %Perform a normal fit to our data - obtain the best estimates for mean
    %and standard deviation given the starting values. Constrain this fit
    %so that mean and standard deviation are never negative. 
    [paramEsts,paramCIs] = mle(cts, 'pdf',pdf_truncnorm, 'start',start,'lower',[0 0]); %maximum likelihood estimate for normal distribution parameters, with lower bounds for mean and sd @ 0 , 'lowerbound',[0 0]

    %add mle of distribution data to map structure
    map.noiseMean = paramEsts(1); %the mean of our data
    map.noiseSd   = paramEsts(2); %the standard deviation of our data
    map.noiseCI   = paramCIs; %confidence intervals around the fitted estimates

    %define noiseLimit (in counts) of the map according to the number of sigma input
    map.noiseLimit = nSigma*map.noiseSd+map.noiseMean; 

    %create probability density function with domain set by histogram
    %binning for chi2 test later
    noise = map.cts;
    noise = noise(noise<map.noiseLimit+map.noiseSd); %add a sd in so you can see how much data is cut

    %binning
    % AEM iqr is interquartile range
    binSize = 2*iqr(noise)/length(noise)^(1/3);  %Freedman-Diaconis
%     bins    = (max(noise)-min(noise))/binSize;
%         
%     lowerBound = map.noiseMean - 4*map.noiseSd;
%     if lowerBound < 0, lowerBound = 0; end;  %just in case lowerBound tries to be less than 0
%     upperBound = map.noiseMean + 4*map.noiseSd;

%     map.noiseDomain = lowerBound:upperBound;

    %Fit the normal distribution to the data with the cutoff, then show
    %what that extra standard deviation had in it to make sure we aren't
    %missing anything
    map.noiseDomain = min(noise):binSize:max(noise);
    map.noisePdf    = pdf('normal', map.noiseDomain, map.noiseMean, map.noiseSd);
    
    %normalize pdf for whatever reason matlab doesn't
    map.noisePdf    = map.noisePdf./sum(map.noisePdf);
    map.fitCutoff   = cutOff;
    map.fitnSigma   = nSigma;
    
    [map.obsFreq, map.obsCtrs] = hist(noise, map.noiseDomain);
       
    % AEM plot the histogram of the noise
    hist(noise, map.noiseDomain); xlabel 'noise'; ylabel 'noiseDomain'; 
    if pon == 1
        pause % AEM PLOT
    end
    map.expectedFreq = map.noisePdf*length(noise);

    % AEM Chi-square goodness of fit
    [h, p, st] = chi2gof(map.noiseDomain, 'ctrs', map.obsCtrs, 'frequency', map.obsFreq, 'expected', map.expectedFreq);

    map.chi2test.h = h;
    map.chi2test.p = p;
    map.chi2test.stats = st;
        
    
%Calculate chi square 
    
% ------------  Background removal

    %Map.counts is a matrix related to the pixel values and locations. This
    %comes directly from processAsciiFile.m.
    %If the pixel value is less than the noise limit, set it to zero.
    %Otherwise do nothing.
    map.countsNoBkgd = map.counts-map.noiseLimit;
    % AEM - this isn't used:  [m, n] = size(map.countsNoBkgd);

    map.countsNoBkgd(map.countsNoBkgd<0)=0; % AEM the pixel is noise if it's less than 0. 
    map.countsNoBkgd(map.countsNoBkgd>0)= map.counts(map.countsNoBkgd>0); %puts back in the initial values;
%     for j=1:m
%         for i = 1:n
% 
%             if map.countsNoBkgd(j,i) < 0
%                 map.countsNoBkgd(j,i)=0;
%             else
%                 map.countsNoBkgd(j,i) = map.counts(j,i); %puts back in the initial values
%             end
%         end
%     end

    
% ------------- Background removal and mean subtraction

    %If the pixel value is less than the noise limit, set it to zero.
    %Otherwise subtract the noise value from the measurement.
    map.countsBkgdSubtracted = map.countsNoBkgd-map.noiseMean;

    map.countsBkgdSubtracted(map.countsBkgdSubtracted<0) = 0;
%     for j=1:m
%         for i = 1:n
% 
%             if map.countsBkgdSubtracted(j,i) < 0
%                 map.countsBkgdSubtracted(j,i)=0;
%             end
%            
%             
%         end
%     end

% ------------- Background nSigma subtraction

    %If the pixel value is less than the noise limit, set it to zero.
    %Otherwise subtract the noise value from the measurement.
    map.countsBkgdSigmaSubtracted = map.countsNoBkgd-map.noiseLimit;
    
     map.countsBkgdSigmaSubtracted(map.countsBkgdSigmaSubtracted<0) = 0;

%     for j=1:m
%         for i = 1:n
% 
%             if map.countsBkgdSigmaSubtracted(j,i) < 0
%                 map.countsBkgdSigmaSubtracted(j,i)=0;
%             end
%            
%             
%         end
%     end

