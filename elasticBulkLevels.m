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
    