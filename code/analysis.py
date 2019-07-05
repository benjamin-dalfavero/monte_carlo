#!/usr/bin/python

# analyze results from blackbody simulation

import pandas as pd
import numpy as np 
import matplotlib.pyplot as plt 

# read csv files, store to an array
df1 = pd.read_csv('trial1.csv')
df2 = pd.read_csv('trial2.csv')
df3 = pd.read_csv('trial3.csv')
df4 = pd.read_csv('trial4.csv')
frames = [df1, df2, df3, df4]

# plot each trial
for i in range(0, 4)