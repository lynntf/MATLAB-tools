function [cum_h,t_h] = cumHistogram(in,t)
% Function to get cumulative histogram of some input
% If t is just an integer, will use that many equally spaced points to measure
% otherwise, the sample points can be specified with the input (non-linear 
% sampling is possible).
if length(t) > 1
    N = length(t);
    cum_h = zeros(length(N),1);
    t_h = t(:);
else
    N = t+1;
    cum_h = zeros(N,1);
    t_h = linspace(min(in(:)),max(in(:)),N)';
end

for ii = 1:N
    cum_h(ii) = nnz(in <= t_h(ii));
end
cum_h = cum_h/max(cum_h(:));
