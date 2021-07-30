import matplotlib.pyplot as plt
import numpy as np
import math
#from matplotlib.ticker import (MultipleLocator, AutoMinorLocator)
import matplotlib.ticker as mticker
# 100 linearly spaced numbers
y = np.linspace(0,70000,35000)

def scale(i):
    return 5 + math.ceil((53883.16 *  i) / 15000000) + math.ceil((46111.8 *  i) / 15000000) + math.ceil((974415.68 *  i) / 15000000) + math.ceil((339778.6*  i) / 15000000) + math.ceil((55818.88*  i) / 15000000)

# the function, which is y = x^2 here
data = []
y_val = []
for i in y:
    x = scale(i)
    data.append((x, i))

exp_30 = (scale(30),30)
exp_180 = (scale(180),180)
print(exp_30)
print(exp_180)

data_in_array = np.array(data)
transposed = data_in_array.T
x, y = transposed
print(data_in_array)

"""
# setting the axes at the centre
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
ax.spines['left'].set_position('center')
ax.spines['bottom'].set_position('zero')
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
ax.xaxis.set_ticks_position('bottom')
ax.yaxis.set_ticks_position('left')
"""
# plot the function
fig, ax = plt.subplots()
ax.scatter(x,y, label="n     voters - tornado vote")

ax.scatter(exp_30[0], exp_30[1], label="30   voters - local experiments")
ax.scatter(exp_180[0], exp_180[1], label="180 voters - local experiments", color="r")
ax.scatter(12, 30, label="30   voters - rinkeby experiments ", color="g")

plt.yscale('log')
plt.xscale('log')
plt.xlabel("Blocks (15 seconds blocktime)")
plt.xticks([11, 25, 100, 1000, 5760])
plt.yticks([30, 180, 1000, 10000, 50000])
plt.ylabel("Number of Voters")
plt.legend(loc='upper left')
#ax.xaxis.set_minor_formatter(mticker.ScalarFormatter())
#ax.xaxis.set_minor_locator(MultipleLocator(1000))
ax.xaxis.set_major_formatter(mticker.ScalarFormatter())
ax.xaxis.get_major_formatter().set_scientific(False)
ax.xaxis.get_major_formatter().set_useOffset(False)
ax.yaxis.set_major_formatter(mticker.ScalarFormatter())
ax.yaxis.get_major_formatter().set_scientific(False)
ax.yaxis.get_major_formatter().set_useOffset(False)
plt.savefig("../../../../Grahics/tornado-vote-scale.pdf", format="pdf", bbox_inches="tight")
plt.show()
