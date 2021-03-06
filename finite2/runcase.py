#!/usr/bin/env python3

# runcase.py - run program for second arrangement and plot results to file

import pandas as pd 
import matplotlib.pyplot as plt 
import sys
import os

# run matlab program and fetch results
fname = sys.argv[1]
quoted_fname = "\\\"" + fname + "\\\""
cmd = "matrun view %s" % quoted_fname
os.system(cmd)
fname_out = fname.replace('.csv', '_out.csv').replace('param', 'results')
results = pd.read_csv(fname_out)
n = results.n
F = results.F

# generate title for plot
prm = pd.read_csv(fname)
ttl = r"$A_1$ %0.1f $\times$ %0.1f, $A_2$ %0.1f $\times$ %0.1f at (%0.1f, %0.1f, %0.1f)" \
      % (prm.Dxn, prm.Dyn, prm.Dy, prm.Dz, prm.x, prm.y, prm.z)

# plot data and save to file
plt.plot(n, F)
plt.xlabel('bundles')
plt.ylabel(r"$F_{12}$")
plt.title(ttl)
F_f = F.iat[-1]
plt.legend(["F = %0.5f" % F_f])
# save to file
fname_plot = fname.replace('.csv', '.png').replace('param', 'plots')
plt.savefig(fname_plot)