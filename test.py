import sys
import numpy as np
import os
import math

DECIMALES = 4

# Variables fixées
eps 	= 0.01
seuil 	= 0.6

# Variables eps1, nu et tho

	## Nombre de valeurs dans l'interval
E_NB_VAL = 15
N_NB_VAL = 15
T_NB_VAL = 15

	## MIN et MAX
E_MIN = 0.0001		# ]0 /!\

N_MIN = 2.5
T_MIN = 3

E_MAX = 0.05			# 0.1] /!\
N_MAX = 8
T_MAX = 25


Es = np.round(np.linspace(E_MIN, E_MAX, E_NB_VAL), DECIMALES)
Ns = np.round(np.linspace(N_MIN, N_MAX, N_NB_VAL), DECIMALES)
Ts = np.round(np.linspace(T_MIN, T_MAX, T_NB_VAL), DECIMALES)

print(f"""
Es: {['{:7.4f}'.format(x) for x in Es ]}
Ns: {['{:7.4f}'.format(x) for x in Ns ]}
Ts: {['{:7.4f}'.format(x) for x in Ts ]}
""")

# Variables pour les images
""" # => TOUT
Rs = np.arange(2, 16)
ID_images = np.arange(1, 101)
Types = ['B0U', 'B25U', 'B50U', 'B75U', 'B100U', 'B125U']
"""

"""
# test avec 1 image
Rs = [6]			# régions
ID_images = [1]		# id des images
Types = ['B25U']		# types
"""


Rs = [6, 7]		
ID_images = np.arange(1, 26)
Types = ['B0U']		


images = []
for r in Rs:
	for t in Types:
		for id_image in ID_images:
			images.append(f"{r}R/{t}{r}R_{id_image}.pgm")

print(f"""
Region(s) testée(s) :          {Rs}
id image(s) :                  [{np.min(ID_images)}, ..., {np.max(ID_images)}]
Echantillons / image(s) :      {E_NB_VAL * N_NB_VAL * T_NB_VAL}
Nombre d'image(s) :            {len(images)}
Total d'appel de srim_def:     {E_NB_VAL * N_NB_VAL * T_NB_VAL * len(images)}
""")

try: input("Enter pour continuer...")
except: exit()

backslash = '\\'
for image in images:
	r = image.split('/')[0]
	print(image)
	for e in Es:
		for n in Ns:
			for t in Ts:
				#print(f"srim_def CA images/{image} {eps} {seuil} {e} {n} {t}")
				os.system(f"srim_def CA images/{image} {eps} {seuil} {e} {n} {t} > NUL")
	#print(f"clean.bat {image.split('/')[0]} {'images'+backslash+image.replace('/', backslash)} > NUL")
	os.system(f"clean.bat {'images' + backslash + r} {'images' + backslash + image.replace('/', backslash)} {r}> NUL")

