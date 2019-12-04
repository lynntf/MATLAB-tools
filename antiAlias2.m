function x = downSample2(x,N)
% Function downSample2 takes a 2D array x and averages four neighbors into 
% a single entry.
if ~exist('N','var') % parameter N specifies the number of times to down-sample
    N = 1;
end
for ii = 1:N
    [m,n] = size(x);
    if mod(m, 2)
        x = [x;x(end,:)];
        fprintf('Warning: first dimension not even\n');
    end
    if mod(n, 2)
        x = [x,x(:,end)];
        fprintf('Warning: second dimension not even\n');
    end
    x = (x(1:2:size(x,1),1:2:size(x,2)) + x(1:2:size(x,1),2:2:size(x,2)) + ...
        x(2:2:size(x,1),1:2:size(x,2)) + x(2:2:size(x,1),2:2:size(x,2)))/4;
end
end
