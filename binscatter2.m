function [out,x_edges,y_edges,x_centers,y_centers] = binscatter2(x,y,weight,x_res,y_res,bounds)
% x_res = 100;
% y_res = x_res;
if isempty(weight)
    weight = ones(size(x));
end

if ~exist('bounds','var')
    x_max = max(x(:));
    y_max = max(y(:));
    x_min = min(x(:));
    y_min = min(y(:));
else
    x_min = bounds(1);
    x_max = bounds(2);
    y_min = bounds(3);
    y_max = bounds(4);
end

x = x(x >= x_min & x <= x_max);
y = y(y >= y_min & y <= y_max);


% dx = (x_max - x_min)/x_res;
% dy = (y_max - y_min)/y_res;

x_edges = linspace(x_min, x_max, x_res + 1);
x_centers = 0.5*x_edges(1:end-1) + 0.5*x_edges(2:end);
y_edges = linspace(y_min, y_max, y_res + 1);
y_centers = 0.5*y_edges(1:end-1) + 0.5*y_edges(2:end);


x_bin = floor((x(:) - x_min)/(x_max - x_min) * (x_res) ) + 1;
y_bin = floor((y(:) - y_min)/(y_max - y_min) * (y_res) ) + 1;

x_bin(x == x_max) = x_res;
y_bin(y == y_max) = y_res;

out = zeros([y_res,x_res]);

for i = 1:length(x(:))
%     if ~((x_bin(i) > x_res) | (x_bin(i) <= 0) | (y_bin(i) > y_res) | (y_bin(i) <=0))
        out(y_bin(i),x_bin(i)) = out(y_bin(i),x_bin(i)) + weight(i);
%     end
end
end
