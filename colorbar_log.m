function cbar = colorbar_log(my_clim)
%COLORBAR_LOG Apply log10 scaling to pseudocolor axis 
% and display colorbar COLORBAR_LOG(V), where V is the
% two element vector [cmin cmax], sets manual, logarithmic
% scaling of pseudocolor for the SURFACE and PATCH
% objects. cmin and cmax should be specified on a LINEAR
% scale, and are assigned to the first and last colors in
% the current colormap. A logarithmic scale is computed,
% then applied, and a colorbar is appended to the current
% axis.
%
% Written by Matthew Crema - 7/2007

% Trick MATLAB by first applying pseudocolor axis
% on a linear scale
caxis(my_clim)

my_clim = [my_clim(2) my_clim(1)];

% Create a colorbar with log scale
cbar = colorbar('Yscale', 'log');

% Now change the pseudocolor axis to a log scale.
% if my_clim(1)<1 || my_clim(2)<1
%     hold = my_clim;
%     my_clim(1) = hold(2);
%     my_clim(2) = hold(1);
% end
caxis(abs(log10(my_clim)));

% Do not issue the COLORBAR command again! If you want to
% change things, issue COLORBAR_LOG again.