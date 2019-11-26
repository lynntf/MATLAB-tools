function [out,x_edges,y_edges,x_centers,y_centers] = binScatter2(x,y,weight,x_res,y_res,bounds)
% Function binscatter2 is an alternative to MATLAB functions binscatter (which creates
% an interactive figure) and histcounts2 (which, although it does offer specification
% of edges manually, is not easy to use for independent x and y scales).
% Additionally, a weighting of the data can be specified to accdommodate other scaling
% effects not accounted for by a rectangular grid.

if isempty(weight)
    weight = ones(size(x)); % In the absence of a weighting, specifiy no weighting
end

if ~exist('bounds','var') % If data bounds are not specified, get from data
    x_max = max(x(:));
    y_max = max(y(:));
    x_min = min(x(:));
    y_min = min(y(:));
else
    x_min = bounds(1);
    x_max = bounds(2);
    y_min = bounds(3);
    y_max = bounds(4);
    
    x = x(x >= x_min & x <= x_max); % Use specified bounds to remove excess data
    y = y(y >= y_min & y <= y_max);
end

% Compute edges and centers
x_edges = linspace(x_min, x_max, x_res + 1);
x_centers = 0.5*x_edges(1:end-1) + 0.5*x_edges(2:end);
y_edges = linspace(y_min, y_max, y_res + 1);
y_centers = 0.5*y_edges(1:end-1) + 0.5*y_edges(2:end);

% Get the bin indicies that data falls into
x_bin = floor((x(:) - x_min)/(x_max - x_min) * (x_res) ) + 1;
y_bin = floor((y(:) - y_min)/(y_max - y_min) * (y_res) ) + 1;

% If on the maximal edge, bring into the edge bin
x_bin(x == x_max) = x_res;
y_bin(y == y_max) = y_res;

out = zeros([y_res,x_res]); % Initialize output array

for i = 1:length(x(:))
%     if ~((x_bin(i) > x_res) | (x_bin(i) <= 0) | (y_bin(i) > y_res) | (y_bin(i) <=0))
        out(y_bin(i),x_bin(i)) = out(y_bin(i),x_bin(i)) + weight(i); % Add the weight of the data into
                                                                     % the specified bin
%     end
end
end
