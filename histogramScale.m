function [out_h, out_rank, cum_h, t_h] = histogramScale(in,N)
%% Histogram Sacling Function
% Normalizes in so that out_h has a uniform distribution of data (sorted by
% the histogram). Histogram is generated using N bins. Specifying N is 
% preferred when the array is large or has a variety of different values.
% Expect poor performance when N is too large
% out_rank is sorted by rank
levels = unique(in(in>-inf & in<inf & ~isnan(in))); % Get the unique values in the array
if ~exist('N','var')
    N = length(levels);
end

cum_h = zeros(N+1,1);
%min_in = min(in(:));
t_h = linspace(0,max(in(:)),N+1);

% Compute the histogram
for ii = 1:N+1
    % cum_h(ii) = nnz(in(in>min_in) <= t_h(ii));
    cum_h(ii) = nnz(in(in>0) <= t_h(ii));
end
cum_h = cum_h/cum_h(end);

% If there is variation in the input, then rescale via a linear interporaltion of the
% hstogram produced
if length(levels) > 1
    out_h = interp1(t_h,cum_h,in);
    out_rank = interp1(levels,linspace(0,1,length(levels)),in);
else
    out_h = in;
    out_rank = in;
end
