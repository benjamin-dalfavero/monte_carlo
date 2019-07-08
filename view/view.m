% view.m - use Monte Carlo method to calulate view factor for a disk
% simulate a grey, diffuse area A1 radaiating onto a circular area
% of radius R. Output probability that bundle will land at the point
% (xi, alpha) on A2

%% parameters and constants
% user-defined parameters
N = input('number of bundles: '); % bundles used in distribution
T = input('emitter temperature in K: ');
N_xi = input('number of radial bins: ');
N_alpha = input('number of angular bins: ');
R = input('Radius of disk: ');
s = input('Distance from A1 to A2: ');
fname1 = input('filename for emitted bundles: ', 's');
fname2 = input('filename for probability density function: ', 's');
fname3 = input('filename for bin edges: ', 's');
% constants
sigma = 5.670400e-8; % W m^-2 K^-4
% table data
dat = csvread('../data/black_body.csv');
lT = dat(:, 1);
F = dat(:, 2);

%% Sample distribution and convert to polar coordinates at A2
% random variable to sample
R_lambda = rand(1, N);
R_theta = rand(1, N);
R_phi = rand(1, N);
% get coordinates on A1
lT_num = arrayfun(@(x) tablefind(lT, F, x), R_lambda);
lambda = lT_num / T;
theta = asin(sqrt(R_theta));
phi = 2 * pi * R_phi;
% convert to coordinates on A2
xi = s * tan(phi);
alpha = phi;

%% write emitted bundles to file
headings1 = {'lambda', 'theta', 'phi'};
res1 = [lambda; theta; phi]';
results1 = array2table(res1, 'VariableNames', headings1);
writetable(results1, fname1)

%% sort (xi, alpha) into bins
% set up edges for sorting
xi_edges = linspace(0, R, N_xi + 1);
alpha_edges = linspace(0, 2*pi, N_alpha + 1);
% matrix for storing results
F = zeros(N_xi, N_alpha);
% sort each element
for m = 1:N
    % find row of matrix if 0 < xi < R
    i = bin_num(xi(m), xi_edges);
    if not(isnan(i))
        % find column and add to count in matrix
        j = bin_num(alpha(m), alpha_edges);
        F(i, j) = F(i,j) + 1;
    end
end
% divide by total emitted bundles to get pdf
F = F ./ N;

%% write matrix to file with edges
csvwrite(fname2, F)
csvwrite(fname3, [xi_edges, alpha_edges]')