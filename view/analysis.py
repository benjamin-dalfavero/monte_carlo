#!/usr/bin/env python

# analyze and plot data from monte carlo view factor calculation

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sys
import re

# get input filename from args
in_name = sys.argv[1]

# fetch data from file
df = pd.read_csv(in_name)
ix = df["bundles"]
F = df["F"]
perr = df["error"]

# plot data
# plot of converging view factor
plt.subplot(2, 1, 1)
plt.plot(ix, F, color='blue')
plt.xlabel('Bundles')
plt.ylabel(r"$F_{12}$")
# generate title for plot
nums = re.findall(r'\d+', in_name)
r = nums[0]
s = nums[1]
ttl = "S = " + s + " R = " + r
plt.title(ttl)
# plot of percent error
plt.subplot(2, 1, 2)
plt.plot(ix, perr, color='green')
plt.xlabel('Bundles')
plt.ylabel('Percent error')

# save figure
out_name = in_name.replace('.csv', '_plot.jpg')
plt.savefig(out_name)