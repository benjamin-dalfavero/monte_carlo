%% numerical sampling of gaussian distribution

%% sample distribution
ny = 100; % number of points used for interpolation
nxi = 300; % number of points to sample
[y, xi] = sample(@(x) erf(x), ny, nxi);

%% plot exact solution vs numerical solution
hold on
	plot(sort(y), sort(xi))
hold off

