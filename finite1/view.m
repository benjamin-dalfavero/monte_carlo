function view(fname)
% calculate view factors for finite areas with parameters stored in
% csv table in file fname

% read data from file
dat = readtable(fname);
Dx0 = dat.Dxn;
Dy0 = dat.Dyn;
Dx = dat.Dx;
Dy = dat.Dy;
x = dat.x;
y = dat.y;
z = dat.z;
N = dat.N;
% calculate view factor
ncount = 0; % number of bundles that have hit
F = zeros(1, N); % accumulator for converging view factor
for i = 1:N
    % random variable
    Rx = rand();
    Ry = rand();
    R_phi = rand();
    R_theta = rand();
    % get coordinates from random variables
    % point from which bundle is emitted
    x1 = Dx0 * Rx;
    y1 = Dy0 * Ry;
    phi = 2 * pi * R_phi;
    theta = asin(sqrt(R_theta));
    % convert to point bundle reaches at z2 = z
    x2 = x1 + z * tan(theta) * cos(phi);
    y2 = y1 + z * tan(theta) * sin(phi);
    % determine if bundle hits
    if (x2 >= x) && (x2 <= x + Dx) && (y2 >= y) && (y2 <= y + Dy)
        ncount = ncount + 1;
    end
    % add current view factor to accumulator
    F(i) = ncount / i;
end
% write results to file
n = 1:N; % indices for table
res = [n; F]';
headings = {'n', 'F'};
results = array2table(res, 'VariableNames', headings);
fname_out = strrep(fname, '.csv', '_out.csv');
fname_out = strrep(fname_out, 'param', 'results');
writetable(results, fname_out)
end