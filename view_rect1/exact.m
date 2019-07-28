function exact(fname)
% exact.m - use superposition and exact expression to calculate the view
% factor for given configuration

% read file to get parameters
param = readtable(fname);
Dx = param.Dx;
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
N = param.N;
% determine if A2 crosses the x or y axis
yt = (x == 0) || ((x < 0) && (Dx >= abs(x)));
xt = (y == 0) || ((y < 0) && (Dy >= abs(y)));
% solve for view factor, using xt and yt to determine case
if xt && yt % A2 over dA1
    F = over(abs(x), Dx - abs(x), abs(y), Dy - abs(y), Dz);
elseif not(xt) && not(yt) % A2 in middle of octant
    if (x > 0) && (y > 0) 
        F = diagn(x, Dx, y, Dy, Dz);
    elseif (x < 0) && (y > 0)
        F = diagn(y, Dy, abs(x) - Dx, Dx, Dz);
    elseif (x < 0) && (y < 0)
        F = diagn(abs(x) - Dx, Dx, abs(y) - Dy, Dy, Dz);
    else
        F = diagn(abs(y) - Dy, Dy, x, Dx, Dz);
    end
else % A2 straddles axis
    if (x < 0) && (y > 0)
        F = straddle(y, Dy, abs(x), Dx-abs(x), Dz);
    elseif (x > 0) && (y > 0)
        F = straddle(x, Dx, abs(y), Dy-abs(y), Dz);
    elseif (x < 0) && (y < 0)
        F = straddle(abs(y)-Dy, Dy, abs(x), Dx-abs(x), Dz);
    else
        F = straddle(x, Dx, Dy-abs(y), abs(y), Dz);
    end
end
% write result to file
fname_out = strrep(fname, '.csv', '_exact.csv');
fname_out = strrep(fname_out, 'tests', 'exact');
fid = fopen(fname_out, 'w');
fprintf(fid, '%0.5f\n', F);
fclose(fid);
end

function F = vfac(Dx, Dy, Dz)
% calculate view factor for simple configuration
if (Dx == 0) || (Dy == 0)
    F = 0;
else
    A = Dx / Dz;
    B = Dy / Dz;
    A_rad = sqrt(1 + A^2);
    B_rad = sqrt(1 + B^2);
    F = (A / A_rad * atan(B / A_rad) + B / B_rad * atan(A / B_rad)) / (2 * pi);
end
end

function F = over(w1, w2, h1, h2, Dz)
% computer view factor for A2 over dA1
F = vfac(w1, h1, Dz) + vfac(w2, h1, Dz) + vfac(w1, h2, Dz) + vfac(w2, h2, Dz);
end

function F = diagn(w1, w2, h1, h2, Dz)
% view factor for A2 diagonally offset from dA1
F = vfac(w1+w2, h1+h2, Dz) - vfac(w1+w2, h1, Dz) ...
    - vfac(w1, h1+h2, Dz) + vfac(w1, h1, Dz);
end

function F = straddle(w1, w2, h1, h2, Dz)
% view factor when the area straddles an axis
F = vfac(w1+w2, h1, Dz) + vfac(w1+w2, h2, Dz) ...
    - vfac(w1, h1, Dz) - vfac(w1, h2, Dz);
end