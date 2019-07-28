function view(fname)
% view factor for finite areas, perpendicular case

% read data from file
param = readtable(fname);
Dxn = param.Dxn;
Dyn = param.Dyn;
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
z = param.z;
N = param.N;
% emit and check bundles
% accumulators
ncount = 0; % no of bundles that have landed
F = zeros(1, N);
% loop through bundles
for i = 1:N
    % random variables
    R_theta = rand();
    R_phi = rand();
    Rx = rand();
    Ry = rand();
    % get angles and initial position on A1
    theta = sqrt(asin(R_theta));
    phi = R_phi * 2 * pi;
    x1 = Dxn * Rx;
    y1 = Dyn * Ry;
    % final position
    y2 = y1 + (x-x1) * tan(phi);
    z2 = (x-x1) * cot(theta) * sec(phi);
    % increment count if bundle hits A2
    if (y2 >= y) && (y2 <= y+Dy) && (z2 >= z) && (z2 <= z+Dz) && (z >= 0)
        ncount = ncount + 1;
    end
    % store current F12 to accumulator
    F(i) = ncount / i;
end
% write results to file
n = 1:N; % indices for number of bundles
res = [n; F]';
headings = {'n', 'F'};
results = array2table(res, 'VariableNames', headings);
fname_out = strrep(fname, '.csv', '_out.csv');
fname_out = strrep(fname_out, 'param', 'results');
writetable(results, fname_out)
end