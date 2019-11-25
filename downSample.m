function x = downSample(x,n)
if ~exist('n','var')
    n = 1;
end
for ii = 1:n
    x = (x(1:2:size(x,1),1:2:size(x,2)) + x(1:2:size(x,1),2:2:size(x,2)) + ...
        x(2:2:size(x,1),1:2:size(x,2)) + x(2:2:size(x,1),2:2:size(x,2)))/4;
end
end