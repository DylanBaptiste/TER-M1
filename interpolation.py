from scipy.interpolate import RegularGridInterpolator
from numpy import linspace, zeros, array
import numpy as np
import matplotlib.pyplot as plt

my_data = np.genfromtxt('data.csv', delimiter=',')


def f(x, y, z):
	return my_data[(my_data[:,0] == x) & (my_data[:,1] == y) & (my_data[:,2] == z), 3][0]

#LENGHT = 20

Es = np.unique(my_data[:,0])
Ns = np.unique(my_data[:,1])
Ts = np.unique(my_data[:,2])

data = zeros((len(Es),len(Ns),len(Ts)))


r1 = range(len(Es))
r2 = range(len(Ns))
r3 = range(len(Ts))

for i in r1:
	for j in r2:
		for k in r3:
			data[i, j, k] = f(Es[i], Ns[j], Ts[k])


"""
r1 = range(len(Es))
r2 = range(len(Ns))
r3 = range(len(Ts))
for a in r1:
	for b in r2:
		for c in r3:
			data[a, b, c] = my_data[a+b+c][3]
"""

fn = RegularGridInterpolator((Es, Ns, Ts), data)
fn([0.001,-10,-4])

# draw 3D scatter graph
fig = plt.figure()
ax = fig.gca(projection='3d')
only6 = my_data[(my_data[:,3] == 6)]
ax.scatter(only6[:,0], only6[:,1], only6[:,2])


E_NB_VAL = 50
N_NB_VAL = 50
T_NB_VAL = 50

E_MIN = 0.001		# ]0 /!\
N_MIN = 0
T_MIN = 0

E_MAX = 0.1		# 0.1] /!\
N_MAX = 10
T_MAX = 25


Es = np.round(np.linspace(E_MIN, E_MAX, E_NB_VAL), 4)
Ns = np.round(np.linspace(N_MIN, N_MAX, N_NB_VAL), 4)
Ts = np.round(np.linspace(T_MIN, T_MAX, T_NB_VAL), 4)

generateData = []
generateDataR = []

for i in Es:
	for j in Ns:
		for k in Ts:
			v = fn([i, j, k])[0]
			generateData.append([i, j, k, v])
			generateDataR.append([i, j, k, np.round(v)])


np.savetxt('generateData.csv', generateData, delimiter=',', fmt='%.4f')
np.savetxt('generateDataR.csv', generateDataR, delimiter=',', fmt='%.4f')

