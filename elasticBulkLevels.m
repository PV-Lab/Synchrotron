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

%Grab the levels at the boundaries
    stIdx = 1; 
    endIdx = 0;
    while true
        Sl = elasticCounts(stIdx,:);
        Sr = elasticCounts(end-endIdx,:);

        if any(Sl < .001*mean(mean(elasticCounts(:,:))))
            stIdx = stIdx + 1;
        elseif any(Sr < .001*mean(mean(elasticCounts(:,:))))
            endIdx = endIdx + 1;
        else
            break;
        end
    end
        

%     lrBounds = figure('Name','Distribution of the last pxls of line scans');
%     subplot(1,2,1)
%     hist(Sl); 
%     disp(size(Sl));
%     title('Bottom of Elastic Map');
%     subplot(1,2,2)
%     hist(Sr); title('Top of Elastic Map');

    %Assuming these distributions look relatively Gaussian
    Sl = mean(Sl);
    Sr = mean(Sr);
    
    elasticUpperLimit = 1.1*Sl;
    elasticLowerLimit = 0.9*Sr;
    
    if Sl < Sr
        
        elasticCounts = flipud(elasticCounts);
        counts = flipud(counts);
        Slnew = Sr;
        Sr = Sl;
        Sl = Slnew;
        elasticUpperLimit = 1.1*Sl;
        elasticLowerLimit = 0.9*Sr;
        
    end
    