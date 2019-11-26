function [cum_h,t_h] = cumHistogram(in,t)
% Function to get cumulative histogram of some input
% If t is just an integer, will use that many equally spaced points to measure
% otherwise, the sample points can be specified with the input (non-linear 
% sampling is possible).
if length(t) > 1
    cum_h = zeros(length(t), 1);
    t_h = t(:);
else
    cum_h = zeros(t + 1, 1);
    t_h = linspace(min(in(:)), max(in(:)), t + 1)';
end

for ii = 1:length(t_h)
    cum_h(ii) = nnz(in <= t_h(ii));
end
cum_h = cum_h/max(cum_h(:));
