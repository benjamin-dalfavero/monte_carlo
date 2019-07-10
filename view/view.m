% view.m - use Monte Carlo method to calulate view factor for a disk
% simulate a grey, diffuse area A1 radaiating onto a circular area
% of radius R. 

%% parameters and constants
% user-defined parameters
N = input('number of bundles: ');
s = input('distance A1 to A2: ');
R = input('radius of disk: ');

%% exact result for error calculation
D = 2*R;
F_ex = D^2 / (D^2 + 4*s^2);

%% calculate exchange factor
% iterative calculation
% sample theta
R_theta = rand(1, N);
theta = asin(sqrt(R_theta));
% get xi from theta
xi = s * tan(theta);
% cumulative total of bundles landing inside disk
inside = xi <= R;
bundles = cumsum(inside);
% view factor
n = 1:N;
F = bundles ./ N;
% get error
perr = abs(F - F_ex) / F_ex;

%% write to output file
headings = {'bundles', 'F', 'error'};
res = [n; F; perr]';
results = array2table(res, 'VariableNames', headings);
fname = ['r', num2str(R), 's' num2str(s), '.csv'];
writetable(results, fname)