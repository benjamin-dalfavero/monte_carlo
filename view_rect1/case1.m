function case1(fname)
% case1.m - compute view factor for parallel areas.
% fname - file to be read
%% pull parameters from file
param = readtable(fname);
Dx = param.Dx;
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
N = param.N;
%% sample bundles one at a time
% preallocate accumulator
F = zeros(1, N);
ncount = 0; % number of bundles that have landed
% test bundles, store results
for i = 1:N
    % sample random numbers to get angles
    R_th = rand();
    R_phi = rand();
    theta = asin(sqrt(R_th));
    phi = 2 * pi * R_phi;
    % get final position
    x2 = Dz * tan(theta) * cos(phi);
    y2 = Dz * tan(theta) * sin(phi);
    % update count if lands within A2
    if (x2 >= x) && (x2 <= x + Dx) && (y2 >= y) && (y2 <= y + Dy)
        ncount = ncount + 1;
    end
    % store exchange factor in array
    F(i) = ncount / i;
end
%% write results to file
n = 1:N;
res = [n; F]';
headings = {'n', 'F'};
results = array2table(res, 'VariableNames', headings);
fname2 = strrep(fname, '.csv', '_out.csv');
fname2 = strrep(fname2, 'tests', 'results');
writetable(results, fname2)
end