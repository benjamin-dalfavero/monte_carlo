function exact(fname)
% compute view factor by superposition

% read data from file
param = readtable(fname);
Dy = param.Dy;
Dz = param.Dz;
x = param.x;
y = param.y;
z = param.z;
N = param.N;
% solve case-by case
if (z < 0) && (Dz <= abs(z))
    F = 0;
elseif (z < 0) && (z 
end

function F = vfac(Dz, Dy, Dz)
% calculate view factor for area at corner
if (Dz == 0) || (Dy == 0) || (Dz == 0)
    F = 0;
else
    A = Dz / Dy;
    C = Dx / Dy;
    Y = sqrt(A^2 + C^2);
    F = (atan(1/C) - (C/Y)*atan(1/Y)) / (2 * pi);
end
end

function F = straddle(w1, w2, h1, h2, Dz)
% view factor when A2 straddles z axis
F = vfac(w1, h1+h2, Dz) + vfac(w2, h1+h2, Dz) ...
    - vfac(w1, h1, Dz) - vfac(w2, h1, dz);
end

function diagn(w1, w2, h1, h2, Dz)
% view factor when A2 is offset diagonally from dA1
F = vfac(w1+w2, h1+h2, Dz) - vfac(w1+w2, h1, Dz) ...
    - vfac(w1, h1+h2, Dz) + vfac(w1, h1, Dz);
end