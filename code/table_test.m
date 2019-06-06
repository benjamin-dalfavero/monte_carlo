x = [1, 2, 3, 4, 5];
y = [-20, -10, 0, 10, 20];

yq = 5;
xq = tablefind(x, y, yq)
fval = interp1(x, y, xq)
