% view.m - use Monte Carlo method to calulate view factor for a disk
% simulate a grey, diffuse area A1 radaiating onto a circular area
% of radius R. 

%% parameters and constants
% user-defined parameters
N = input('number of bundles: ');
s = input('distance A1 to A2: ');
R = input('radius of disk: ');

%% Sample distribution and convert to polar coordinates at A2
% random variables to sample
R_theta = rand(1, N);
R_phi = rand(1, N);
% get coordinates on A1
theta = asin(sqrt(R_theta));
phi = 2 * pi * R_phi;
% convert to radius from center of A2
xi = s * tan(theta);

%% get exchange factor
% count how many bundles fall within the given radius
N2 = length(find(xi <= R));
F = N2 / N;

%% compare with exact exchange factor
% see ch 4, slide 38 for derivation
D = 2*R;
F_exact = D^2 / (D^2 + 4*s^2);
% find percent error
perr = abs(F - F_exact) / F * 100;

%% ouptut final answer
fprintf('Numerical view factor: %0.5f\n', F);
fprintf('Exact view factor: %0.5f\n', F_exact)
fprintf('Percent error: %f%%\n', perr)