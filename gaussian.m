%% numerical sampling of gaussian distribution

%% generate a set of values for y
% we want a set of values {y0 ... yN} s.t.
% erf(yn) = n/N. Use a root finding algo.
N = 100;
y = zeros(1, N); % accumulator
g = 0.1; % initial guess of root finder
F = @(x, n) erf(x) - n/N; % function to be solve
for n = 0:N
	y(n+1) = fsolve(@(x) F(x, n), 0.5);
	g = y(n+1); % reset guess
end

%% sample points randomly
xi = rand(1, 1000);
n = floor(N * xi);
u = N*xi - n;
n = n + 1; % translate indices to index y
yi = y(n) + (y(n+1) - y(n)).*u;

%% find and plot error
% given erf(y) = xi
err = abs(erf(yi) - xi);
semilogy(xi, err, 'o')
