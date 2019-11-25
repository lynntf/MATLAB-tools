function x = downSample2(x,n)
% Function downSample2 takes a 2D array x and averages four neighbors into a single entry.
if ~exist('n','var') % parameter n specifies the number of times to down-sample
    n = 1;
end
for ii = 1:n
    x = (x(1:2:size(x,1),1:2:size(x,2)) + x(1:2:size(x,1),2:2:size(x,2)) + ...
        x(2:2:size(x,1),1:2:size(x,2)) + x(2:2:size(x,1),2:2:size(x,2)))/4;
end
end
