function n = bin_num(x, edges)
% n = bin_num(x, edges)
% find the sort x into the n-th bin of edges.
% returns NaN if x is out of bounds
if (x > max(edges)) || (x < min(edges)) % out of bounds
    n = NaN;
    return;
elseif x == min(edges) % start of first bin
    n = 1;
    return;
elseif x == max(edges) % end of last bin
    n = length(edges) - 1;
else % middle of bin
    for i = 1:length(edges) - 1
        if (x >= edges(i)) && (x <= edges(i+1))
            n = i;
            return;
        end
    end
end
end