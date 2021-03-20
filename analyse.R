library(plotly)
library(dplyr)
col.names <- c('alg', 'eps', 'seuil', 'eps1', 'nu', 'tho', 'noir', '8', '9', '10', 'nb', paste0("c", seq_len(13)))

# 3375 avec eps1 < 0.1
data <- read.table('res/6R/test1.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
# 3375 meme plot avec des bornes corrigées
# data <- read.table('res/6R/test2.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
# 3375 meme plot avec plus de donnée
data <- read.table('res/6R/test3.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)

#eps1 < 0
data <- read.table('res/6R/test4.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)

# quasi centre sur 0
#data <- read.table('res/6R/test5.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
data <- read.table('res/6R/test6.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)

# tho < 0
data <- read.table('res/6R/test7.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
#data <- read.table('res/6R/test8.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)

# nu > 10
#data <- read.table('res/6R/test9.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
#data <- read.table('res/6R/test10.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)

#tho > 25
data <- read.table('res/6R/test11.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
#data <- read.table('res/6R/test12.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
#data <- read.table('res/6R/test13.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)

#th < 0 nu < 5
#data <- read.table('res/6R/test14.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
#data <- read.table('res/6R/test15.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)


tail(data)
aspectratio <- lapply(list(x=length(unique(data[, 'eps1'])), y=length(unique(data[, 'nu'])), z=length(unique(data[, 'tho']))), '/', min(unlist(list(x=length(unique(data[, 'eps1'])), y=length(unique(data[, 'nu']))))))
# aspectratio <- lapply(c(x=min(data$'eps1'), y=min(data$'nu'), z=min(data$'tho')), '/', max(c(x=min(data$'eps1'), y=min(data$'nu'), z=min(data$'tho'))))
best <- data[data$'nb' == 6, c('eps1','nu', 'tho', 'nb')]
good <- data[(data$'nb' == 6 | data$'nb' == 5 | data$'nb' == 7), c('eps1','nu', 'tho', 'nb')]

plot_ly(as.data.frame(data), x=~eps1, y=~nu, z=~tho, color=~nb) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(as.data.frame(good[order(good$'nb'),]), x=~eps1, y=~nu, z=~tho, color=~nb, colors = c("#006600", "#008800", "#00BB00")) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(as.data.frame(best), x=~eps1, y=~nu, z=~tho, color=~nb, colors = c('#FF5555'), alpha = 0.9 ) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))

# merge des fichiers testés
files <- paste0('res/6R/', paste0('test', 1:15), '.txt')
data <- as.data.frame(NULL)
for(f in files){ data <- rbind(data, read.table(f, col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)) }

plot_ly(as.data.frame(data                                     ), x=~eps1, y=~nu, z=~tho, color=~nb) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(as.data.frame(data[(data$'nb' >= 1 & data$'nb' <= 9), ]), x=~eps1, y=~nu, z=~tho, color=~nb) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(as.data.frame(data[(data$'nb' >= 2 & data$'nb' <= 8), ]), x=~eps1, y=~nu, z=~tho, color=~nb) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
#plot_ly(as.data.frame(data[(data$'nb' >= 5 & data$'nb' <= 7), ]), x=~eps1, y=~nu, z=~tho, color=~nb) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(as.data.frame(data[(data$'nb' >= 5 & data$'nb' <= 7), ]), x=~eps1, y=~nu, z=~tho, color=~nb, marker=list(size = 3)) %>% layout(scene = list(aspectmode='manual', aspectratio = list(unlist(aspectratio)*2)))
plot_ly(as.data.frame(data[(data$'nb' == 6),                  ]), x=~eps1, y=~nu, z=~tho, color=~nb, colors=c('#FF5555'), alpha=0.9) %>% layout(title=paste(dim(data[(data$'nb' == 6),])[1], 'points'), scene = list(aspectmode='manual', aspectratio = aspectratio))

plot_ly(as.data.frame(data[( (data$'nb' == 10 | data$'nb' == 1) & data$'eps1' > 0 & data$'eps1' < 0.1), ]), x=~eps1, y=~nu, z=~tho, color=~nb, marker=list(size = 3)) %>% layout(scene = list(aspectmode='manual', aspectratio = list(unlist(aspectratio)*2)))

data2 <- data[(data$'eps1' >= 0 & data$'eps1' <= 0.02 & data$'nb' <= 10 & data$'nb' >= 1 & data$'tho' > 0 & data$'tho' <= 25), ]
data2 <- data[(data$'nu' >= 0.5 & data$'nu' < 10 & data$'eps1' <= 0.02 & data$'nb' <= 7 & data$'nb' >= 5 & data$'tho' > 0 & data$'tho' <= 25), ]
data2 <- data[(data$'th' < -1), ]

aspectratio2 <- lapply(list(x=length(unique(data[, 'eps1'])), y=length(unique(data[, 'nu'])), z=length(unique(data[, 'tho']))), '/', min(unlist(list(x=length(unique(data[, 'eps1'])), y=length(unique(data[, 'nu']))))))
plot_ly(as.data.frame(data2), x=~eps1, y=~nu, z=~tho, color=~nb, marker=list(size = 5)) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio2))

data2 <- data[(data$'eps1' >= 0 & data$'eps1' <= 0.04 & data$'th' <= 0), ]

data <- read.table('res/6R/test6.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
data <- data[, c('eps1', 'nu', 'tho', 'nb')]
stho <- rep(1:length(unique(data$tho)), length(unique(data$nu))*length(unique(data$eps1)))
data <- cbind(data, stho)
plot_ly(data, type = "isosurface", x=~eps1, y=~nu, z=~tho, value=~nb, frame=~eps1) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(data, type = "isosurface", x=~eps1, y=~nu, z=~tho, value=~nb, slices = list(z = list( show = TRUE, locations = c(5,15, 10,20) )), caps = list( x = list(show = FALSE), y = list(show = FALSE), z = list(show = FALSE) )) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))

data <- as.data.frame(read.table('./generateData.csv', col.names = c('eps1', 'nu', 'tho', 'nb'), header = FALSE, sep = ","))
data <- data[(data$'nb' >= 5 & data$'nb' <= 7), c('eps1','nu', 'tho', 'nb')]
plot_ly(data, x=~eps1, y=~nu, z=~tho, color=~nb, marker=list(size = 4))

#plot_ly(data, x=~eps1, y=~nu, z=~tho, color=~nb, type = 'mesh3d') # marche avec peu de valeurs car si trop de points dans l'espace -> surface non coherente


data <- read.table('res/6R/B25U6R_1.pgm.txt', col.names=col.names, header = FALSE, sep = "\t", fill = TRUE)
aspectratio <- lapply(list(x=length(unique(data[, 'eps1'])), y=length(unique(data[, 'nu'])), z=length(unique(data[, 'tho']))), '/', min(unlist(list(x=length(unique(data[, 'eps1'])), y=length(unique(data[, 'nu']))))))
best <- data[data$'nb' == 6, c('eps1','nu', 'tho', 'nb')]
good <- data[(data$'nb' == 6 | data$'nb' == 5 | data$'nb' == 7), c('eps1','nu', 'tho', 'nb')]

plot_ly(as.data.frame(data), x=~eps1, y=~nu, z=~tho, color=~nb) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(as.data.frame(good[order(good$'nb'),]), x=~eps1, y=~nu, z=~tho, color=~nb, colors = c("#006600", "#008800", "#00BB00")) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))
plot_ly(as.data.frame(best), x=~eps1, y=~nu, z=~tho, color=~nb, colors = c('#FF5555'), alpha = 0.9 ) %>% layout(scene = list(aspectmode='manual', aspectratio = aspectratio))




data <- data[, c('eps1','nu', 'tho', 'nb')]
?write.csv(data, "", row.names = FALSE, col.names = FALSE)
