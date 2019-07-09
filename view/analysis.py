#!/usr/bin/env python

# analyze and plot data from monte carlo view factor calculation

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sys

# fetch data from file
df = pd.read_csv('output.csv')
ix = df["bundles"]
F = df["F"]
perr = df["error"]

# plot data
# plot of converging view factor
plt.subplot(2, 1, 1)
plt.plot(ix, F, color='blue')
plt.xlabel('Bundles')
plt.ylabel(r"$F_{12}$")
plt.title('Convergence of view factor simulation')
# plot of percent error
plt.subplot(2, 1, 2)
plt.plot(ix, perr, color='green')
plt.xlabel('Bundles')
plt.ylabel('Percent error')

# save figure
plt.savefig('plot.jpg')