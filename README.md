# TER-M1

## strim_def:
- Utilisation:
	
```console
> stri_mdef CA nom_image eps seuil eps1 nu0 tho
```
Format image reconnus IMA (proprietaire) PGM RAW (si Raw indiquez les tailles entete, en x, en y, et en z apres les parametres des algos)

- **NOIR** à 1 permet de prendre le noir ou pas dans le choix des classes
- **STPA** à 1 garde l'image avant la defuzzyfication
- **CONT** à 1 permet de faire une détection de contour

Description des parametres :
- **eps** : paramètre d'arret de l'algorithme, fixé pour ce projet à 0.01
- **seuil** : Controle la "defuzzification" de l'image, fixé pour ce projet à 0.06 
- Les parametres étudié :
	- **eps1**: seuil qui permet de regrouper des classes quand elles sont trop petites
	- **nu0**: voir equation 11 du pdf RCA
	- **tho**: voir equation 11 du pdf RCA

## Images:
Source des images : http://pages.upf.pf/Sebastien.Chabrier/download/ImSynth.zip
Les images ont été converties de .bmp à .pgm avec l'outil XnConvert : https://www.https://www.xnview.com/fr/xnconvert/.com/fr/xnconvert/
 