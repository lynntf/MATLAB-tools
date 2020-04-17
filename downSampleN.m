function x_out = downSampleN(x,recur,N)
% Function downSampleN takes a 1D array x and averages every N entries. N
% can be a vector such that downsampling can happen at different scales in
% each dimension.
if ~exist('N','var') % parameter N specifies the dimensions of the reduction
    % N(n) specifies the reduction in dimension n
    N = 2*ones(size(size(x)));
end
if length(N) ~= length(size(x)) % If the reduction is jsut given as a single
    % scalar value
    if length(N) == 1
        N = N*ones(size(size(x)));
    else % or is given as a vector of incorrect size
        fprintf('Error: incorrect dimensions for reduction\n');
        return
    end
end
if sum(mod(N,1)) > 1E-10
    fprintf('Error: non-integer reduction values\n')
    return
end
if ~exist('recur','var') % parameter recur specifies the number of times to recur the downsample
    recur = 1;
end


% ind = findSkips([10,15],[3,2],0)
for jj = 1:recur
    s = size(x);
    if sum(mod(s./N,1)) > 1E-10
        fprintf('Warning: reduction dimensions are not properly divisible\n');
    end
    indicator = findSkips(s,N,0);
%     nnz(indicator)
    x_out = x(indicator);
    for ii = 1:(prod(N)-1)
        indicator = findSkips(s,N,ii);
        x_out(1:nnz(indicator)) = x_out(1:nnz(indicator)) + x(indicator);
    end
    x_out = x_out/prod(N);
%     ceil(s./N)
%     size(x_out)
    x_out = reshape(x_out,ceil(s./N));
    x = x_out;
end
end

function ind = findSkips(s,N,shift)

ind = false(s);
ind_s = size(ind);
ind = ind(:);
pos = zeros(size(s));
pos(1) = -1;
m = ceil(s./N); % max in each dimension
t = cumprod(s); % true size of each dimension;
t = [1,t(1:end-1)];

shift_pos = zeros(size(s));
for ii = 1:shift
    shift_pos(1) = shift_pos(1) + 1;
    for jj = 1:length(shift_pos)
        if shift_pos(jj) >= N(jj)
            shift_pos(jj) = 0;
            shift_pos(jj + 1) = shift_pos(jj + 1) + 1;
        end
    end
end

for ii = 1:prod(m)
    pos(1) = pos(1) + 1;
    for jj = 1:length(pos)
        if pos(jj) >= m(jj)
            pos(jj) = 0;
            pos(jj + 1) = pos(jj + 1) + 1;
        end
    end
    index = sum((t.*(pos.*N + shift_pos))) + 1;
    if index < length(ind)
        ind(index) = 1;
    end
end
ind = reshape(ind, ind_s);
end
