function case2(fname)
% compute numerical view factor for second case

% read parameters from file
param = readtable(fname);
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
z = param.z;
N = param.N;
% accumulators
F = zeros(1, N);
ncount = 0; % bundles that have hit
% sample for each bundle
for i = 1:N
    % get angles from random nubmers
    R_theta = rand();
    R_phi = rand();
    theta = asin(sqrt(R_theta));
    phi = 2 * pi * R_phi;
    % get y and z componenets of displacement vector
    y2 = x * tan(phi);
    z2 = x * cot(theta) * sec(phi);
    % determine if collisison happens
    % nb bundle must land above z = 0 b/c of physical constrainsts
    if (y2 >= y) && (y2 <= y + Dy) && (z2 >= 0) && (z2 >= z) && (z2 <= z + Dz)
        ncount = ncount + 1;
    end
    % store current view factor
    F(i) = ncount / i;
end
% write to table
headings = {'n', 'F'};
res = [(1:N); F]';
results = array2table(res, 'VariableNames', headings);
fname_out = strrep(fname, '.csv', '_out.csv');
fname_out = strrep(fname_out, 'param', 'results');
writetable(results, fname_out);
end