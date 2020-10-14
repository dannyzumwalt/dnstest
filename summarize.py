#!/usr/bin/env python

""" summarize.py: Summarize resulting log file from a dns test cycle. """

__author__	= "Danny Zumwalt"

import numpy as np
import pandas as pd
import matplotlib as plt
from sys import argv

infile=sys.argv[1]

rs = pd.read_csv(infile, delimiter = ',', names = 
            ['queryTime', 'server'])

rs.groupby(['server']).mean()
rs.groupby(['server']).std()
rs.groupby(['server']).min()
rs.groupby(['server']).max()

boxplot = rs.boxplot(by='server',fontsize=16,figsize=(20,10),showmeans=True,showfliers=False)


