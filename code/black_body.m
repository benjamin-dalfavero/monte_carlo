%% black body radiation

%% get data from table
N = 100; % number of points in interpolation table
nbundles = 500; % number of bundles
dat = readmatrix('../data/black_body.csv');
lt = dat(:, 1); % lambda * T
IsT = dat(:, 3); % I / sigma T^5
I_norm = dat(:, 4); % normalized intensity
F = dat(:, 2); % associated CDF value

%% numerically invert cdf
% generate y_n points
nN = linspace(0, N, N+1) ./ N; % values to find inverses of
yint = arrayfun(@(n) tablefind(lt, F, n), nN);
% solve for random points
xi = rand(1, nbundles);
n = floor(xi.*N);
u = N*xi - n;
y = yint(n+1) + (yint(n+2) - yint(n+1)) .* u;
xi = sort(xi);
y = sort(y);

%% plot exact vs numerial cdf
figure(1)
hold on
plot(lt, F, '-')
plot(y, xi, 'o')
hold off
title('Exact and numerical CDF values')

%% get intensity vs temperature
% constants
T = input('Temperature in K: ')
sigma = 5.670E-8; % W m^-2 K^-4
% exact result from table
I = IsT * sigma * T^5;
lambda = lt / T; % um
% convert numerical results
lambda_num = y / T;
IsT_num = interp1(lt, IsT, y);
I_num = IsT_num * sigma * T^5;

%% plot final result
figure(2)
hold on
plot(lambda, I, '-')
plot(lambda_num, I_num, 'o-')
hold off
title('Intensity vs wavelength')
legend('exact', 'numerical')
xlabel('\lambda (\mu m)')
ylabel('I')
