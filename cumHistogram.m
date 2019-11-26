function [cum_h,t_h] = cum_histogram(in,t)

if length(t) > 1
    N = length(t);
    cum_h = zeros(length(N),1);
    t_h = t(:);
else
    N = t+1;
    cum_h = zeros(N,1);
    t_h = linspace(0,max(in(:)),N)';
end

for ii = 1:N
    cum_h(ii) = nnz(in <= t_h(ii));
end
cum_h = cum_h/max(cum_h(:));