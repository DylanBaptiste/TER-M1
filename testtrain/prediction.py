import sklearn
import numpy as np
from sklearn.multioutput import MultiOutputRegressor
from sklearn.svm import LinearSVR
from numpy import genfromtxt, savetxt

X = genfromtxt('./X.csv', delimiter=',')
y = genfromtxt('./y.csv', delimiter=',')

data = genfromtxt('./data.csv', delimiter=',')
values   = data[:,3]


predictor = MultiOutputRegressor(LinearSVR()).fit(X, y)
prediction = predictor.predict([values])
[a, b, c, d] = prediction[0]

print(a, b, c, d)

#7.109649987989862 -0.09866311414913109 -0.03609820112699319 -30.07297773917814
