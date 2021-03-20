import sklearn
import numpy as np
from sklearn.multioutput import MultiOutputRegressor
from sklearn.svm import LinearSVR
from numpy import genfromtxt, savetxt

e = lambda a, b, x : a*x + b

f = lambda a, b, c, x : a * x**2 + b * x + c

h = lambda a, b, c, d, x, y, z : a*x + b*y + c*z + d
#-4.49625583e+01, -3.58986453e-02, -9.93520745e-02, 7.87346531e+00

h = lambda a, b, c, d, aa, bb, cc, x, y, z : aa*x**2 + bb*y**2 + cc*z**2 + a*x + b*y + c*z + d

data = genfromtxt('./data.csv', delimiter=',')
xs       = np.unique(data[:,0])
ys       = np.unique(data[:,1])
zs       = np.unique(data[:,2])
values   = data[:,3]

# exemple pour la fonction affine
X = []
y = []
for a in range(5):
    for b in range(5):
            X.append([e(a, b, x) for x in range(5)])
            y.append([a, b])
            print(len(y), len(X))

X = []
y = []
for a in range(2):
    for b in range(2):
        for c in range(2):
            for d in range(2):
                for aa in range(3):
                    for bb in range(2):
                        for cc in range(3):
                            for d in range(2):
                                X.append([h(a, b, c, d, aa, bb, cc, x, y, z) for x in xs for y in ys for z in zs])
                                y.append([a, b, c, d, aa, bb, cc])
                                print(len(y), len(X))
 
                                
X = []
y = []
for a in range(5):
    for b in range(5):
        for c in range(5):
            for d in range(5):
                for d in range(5):
                    X.append([h(a, b, c, d, x, y, z) for x in xs for y in ys for z in zs])
                    y.append([a, b, c, d])
                    print(len(y), len(X))

predictor = MultiOutputRegressor(LinearSVR()).fit(X, y)
y[1]
# make a single prediction
a = 10.5
b = 0.01
c = 26
d = 12
# data = [h(a, b, c, d, x, y, z) for x in range(1, 10) for y in range(1, 10) for z in range(1, 10)]

d = [e(-5, 27, x) for x in range(5)]
prediction = predictor.predict([d])

prediction = predictor.predict([values])

[a, b, c, d] = prediction[0]

csv = []
for n in range(0,12000):
    [x, y, z, v] = data[n]
    csv.append([v, h(a,b,c,d , x, y, z)])
    #print("{:10.4f} {:10.4f}".format(v, h(a, b, c, d, aa, bb, cc, x, y, z)))


savetxt('save2.csv', csv, delimiter=',')


print(f""" Terrain: f({x}, {y}, {z}) = {v}\nApproximation: f({x}, {y}, {z}) = {h(a, b, c, d, aa, bb, cc, x, y, z)} """)


print(f"""INPUT: f(x) = ({b} / x) + ({a} / y) + ({c} / z) + {d}""")
print(f"""PREDI: f(x) = ({bb} / x) + ({aa} / y) + ({cc} / z) + {dd}""")


#print(f"""INPUT: f(x) = {a}x² + {b}x + {round(c)}""")
#print(f"""PREDI: f(x) = {aa}x² + {bb}x + {cc}""")
