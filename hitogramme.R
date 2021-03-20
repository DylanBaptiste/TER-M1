# histogrammes

library(plotly)
library(dplyr)
options(scipen=100)

col.names <- c('alg', 'eps', 'seuil', 'eps1', 'nu', 'tho', 'noir', '8', '9', '10', 'nb', paste0("c", seq_len(13)))

#Rs <- c(6, 7)		
ids <- 1:25
Type = c('B0U')

res <- rep(0, (15*15*15)-1)
data1 <- as.data.frame(NULL)

R <- 6
type="B0U"
for(id in ids){
	nb <- read.table(paste0('res/',R,'R/',type,'',R,'R_', id, '.pgm.txt'), col.names=col.names, header = TRUE, sep = "\t", fill = TRUE)[,c('nb')]
	nb[nb != R] <- 0
	nb[nb == R] <- 1
	res <- res + nb
}


res <- res/length(ids)

xyz <- read.table(paste0('res/',R,'R/B0U',R,'R_', 1, '.pgm.txt'), col.names=col.names, header = TRUE, sep = "\t", fill = TRUE)[,c('eps1','nu', 'tho')]
data1 <- cbind(xyz, res)
data1sup1 <- as.data.frame(data1[data1$res > 0/length(ids),])
data1sup1 <- as.data.frame(data1[data1$res > 1/length(ids),])
# data1sup1 <- data1

plot_ly(data1, x=~eps1, y=~nu, z=~tho, color=~res, colors=colorRamp(c("orange", "red")))
plot_ly(data1[data1$res >= 1/length(ids),    ], x=~eps1, y=~nu, z=~tho, text=~res, color=~res, colors=colorRamp(c("orange", "red")))
plot_ly(data1[data1$res >= 2/length(ids),    ], x=~eps1, y=~nu, z=~tho, text=~res, color=~res, colors=colorRamp(c("orange", "red")))


plot_ly(data1sup1, x=~eps1, y=~nu, color=~res, colors=colorRamp(c("orange", "red")), text=~res, marker=list(size=~res*scalec+minsize), alpha=1, alpha_stroke=1)


scalec <- 50
minsize <- 0
plot_ly(data1sup1, x=~eps1, y=~nu,  z=~res, color=~res, colors=colorRamp(c("orange", "red")), text=~res, marker=list(size=~res*scalec+minsize), alpha=1, alpha_stroke=1)
plot_ly(data1sup1, x=~eps1, y=~nu, color=~res, colors=colorRamp(c("orange", "red")), text=~res, marker=list(size=~res*scalec+minsize), alpha=1, alpha_stroke=1)

plot_ly(data1sup1, x=~eps1, y=~nu) %>% add_trace( type='histogram2d', contours = list( showlabels = T, labelfont = list(family = 'Raleway', color = 'white')))
plot_ly(data1sup1, x=~eps1, y=~nu) %>% add_trace( type='histogram2dcontour', contours = list( showlabels = T, labelfont = list(family = 'Raleway', color = 'white')))

plot_ly(data1sup1, x=~eps1, y=~nu) %>%
	#add_trace(type='scatter', color=~res, colors=colorRamp(c("yellow", "red")), text=~res, marker=list(size=~res*scalec+minsize)) %>%
	add_trace(type='histogram2dcontour', contours = list( showlabels = T, labelfont = list(family = 'Raleway', color = 'white')))
	# add_trace(type='histogram2d') 

twoDHisto <- function(x, y, z, xname='x', yname='y'){
	return(subplot(
		plot_ly(x=x, color=I("black"), type='histogram', text=z, textposition = 'auto'), 
		plotly_empty(), 
		plot_ly(x=x, y=y, z=z, type='histogram2dcontour', zauto=F, zmax=100, zmin=0, showscale = F, nbinsx=7, nbinsy=7, ncontours=15) %>% layout(xaxis = list(title = 'x'), yaxis = list(title = yname)),
		plot_ly(y=y, color=I("black"), type='histogram', text=z, textposition = 'auto'),
		shareX = T, shareY = T,
		nrows = 2, heights = c(0.2, 0.8), widths = c(0.8, 0.2)
	) %>% layout(showlegend = F, bargap=0.1))
}

subplot(
	twoDHisto(data1sup1$eps1, data1sup1$nu, data1sup1$res, 'eps1', 'nu'),
	twoDHisto(data1sup1$eps1, data1sup1$tho, data1sup1$res, 'eps1', 'tho'),
	twoDHisto(data1sup1$tho,  data1sup1$nu, data1sup1$res,'tho', 'nu'),
	nrows = 2
)

# ======== moyenne de l'espace ======= #
ids <- 1:25
Type = c('B0U')
res <- rep(0, (15*15*15)-1)
data1 <- as.data.frame(NULL)
R <- 8
type="B0U"
for(id in ids){
	res <- res + read.table(paste0('res/',R,'R/',type,'',R,'R_', id, '.pgm.txt'), col.names=col.names, header = TRUE, sep = "\t", fill = TRUE)[,c('nb')]
}
moyenne <- res/length(ids) - R
xyz <- read.table(paste0('res/',R,'R/B0U',R,'R_', 1, '.pgm.txt'), col.names=col.names, header = TRUE, sep = "\t", fill = TRUE)[,c('eps1','nu', 'tho')]
datam <- cbind(xyz, moyenne)
plot_ly(datam, x=~eps1, y=~nu,  z=~tho, color=~moyenne, text=~moyenne, frame=~round(moyenne))
plot_ly(datam, x=~eps1, y=~nu,  z=~tho, color=~moyenne, text=~moyenne)
# === === === === === #

R <- 5
col.names <- c('alg', 'eps', 'seuil', 'eps1', 'nu', 'tho', 'noir', '8', '9', '10', 'nb', paste0("c", seq_len(13)))
xyz <- read.table(paste0('res/',R,'R/B0U',R,'R_', 1, '.pgm.txt'), col.names=col.names, header = TRUE, sep = "\t", fill = TRUE)[,c('eps1','nu', 'tho')]
ids <- 1:25
Type = c('B0U')
res <- rep(0, (15*15*15)-1)
tmp <- rep(0, (15*15*15)-1)
moyenne <- rep(0, (15*15*15)-1)
data1 <- as.data.frame(NULL)
Rs <- c(5,6,7,8)
type <- "B0U"
data <- setNames(data.frame(matrix(ncol = 3, nrow = (15*15*15)-1)), c('mean', 'meanC', 'sdC'))
data <- cbind(data, xyz)
tmpframe <- setNames(data.frame(matrix(ncol = 1, nrow = (15*15*15)-1)), '1')
allimages <- list()
for(R in Rs){
	res <- rep(0, (15*15*15)-1)
	for(id in ids){
		res <- res + read.table(paste0('res/', R, 'R/', type, '', R, 'R_', id, '.pgm.txt'), col.names=col.names, header = TRUE, sep = "\t", fill = TRUE)[,c('nb')]
		tmpframe[,paste(id)] <- read.table(paste0('res/', R, 'R/', type, '', R, 'R_', id, '.pgm.txt'), col.names=col.names, header = TRUE, sep = "\t", fill = TRUE)[,c('nb')]
	}
	#data[,paste0(R)] <- (res/length(ids) - R) #ancienne methode
	allimages[[paste0(R)]] <- tmpframe
	#data[,paste0('sd', R)] <- sd(res)
	
}

computePercent <- function(n){
	ret <- c()
	for(i in 1:((15*15*15)-1) ){
		ret <- append(ret, unname(table(unlist(allimages[[paste0(n)]][i,]))[paste0(n)]/length(ids)))
	}
	ret[is.na(ret)] <- 0
	return(ret)
}
for(R in Rs){
	data[,paste0('sd', R)]   <- apply(allimages[[paste0(R)]], 1, sd)
	data[,paste0('mean', R)] <- apply(allimages[[paste0(R)]], 1, mean)
	data[,paste0('meanC', R)] <- (apply(allimages[[paste0(R)]], 1, mean) - R)
	
	data[,paste0('percent', R)] <- computePercent(R)
}

data['sdC'] <- apply(data[,paste0('meanC', Rs)], 1, sd) # ecart type des moyenne centré de chaque regions
data['sdmean'] <- apply(data[,paste0('sd', Rs)], 1, mean) # la moyenne des ecarts types de chaque point dans chaque regions
data['sdsd'] <- apply(data[,paste0('sd', Rs)], 1, sd) # l'ecart type de l'ecart type de chaque point dans chaque regions

data['meanC'] <- apply(data[, paste0('meanC', Rs)], 1, mean)
data['mean'] <- apply(data[, paste0('mean', Rs)], 1, mean)

plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~meanC, text=~meanC, frame=~round(meanC)) %>% layout(title = capture.output(cat("Moyenne sur les régions", Rs)))
plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~meanC, text=~meanC) %>% layout(title = capture.output(cat("Moyenne sur les régions", Rs)))

plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~sdC, text=~sdC, frame=~round(sdC, 1)) %>% layout(title = "Écart type des moyenne centré en chaque point")
plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~sdC, text=~sdC) %>% layout(title = "Écart type en chaque point")


plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~sdC, text=~paste('sdC:',round(sdC, 4), 'meanC:',round(meanC, 4)), frame=~round(meanC)) %>% layout(title = capture.output(cat("Moyenne des régions", Rs, "avec l'écart type")))


plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~sd5, text=~paste('sd5:',round(sd5, 4), 'meanC5:',round(meanC5, 4)), frame=~round(meanC5)) %>% layout(title = capture.output(cat("Moyenne centré de la région", 5, "avec l'écart type")))
plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~sd5, text=~paste('sd5:',round(sd5, 4), 'meanC5:',round(meanC5, 4))) %>% layout(title = capture.output(cat("Moyenne centré de la région", 5, "avec l'écart type")))

c(max(data$percent8), max(data$percent7), max(data$percent6), max(data$percent5))
# pour expliquer les sd de 5 sur les meanC ~= 0
# rownames(data[round(data$meanC5) == 0,])
# allimages[['5']][rownames(data[round(data$meanC5) == 0,]),]

plot_ly(data, x=~eps1, y=~nu,  z=~tho, color=~percent5, text=~paste('%:', percent5,'sd5:',round(sd5, 4), 'meanC5:',round(meanC5, 4)), frame=~round(meanC5)) %>% layout(title = capture.output(cat("Moyenne centré de la région", 5, "avec l'écart type")))
plot_ly(data[data$percent5 > 0,], x=~eps1, y=~nu,  z=~tho, color=~percent5, text=~paste('%:', percent5,'sd5:',round(sd5, 4), 'meanC5:',round(meanC5, 4))) %>% layout(title = capture.output(cat("Points donnant au moins 1 bonne reponses sur les images à 5 régions")))
plot_ly(data[data$percent5 > 0,], x=~eps1, y=~nu,  z=~tho, color=~sd5, text=~paste('%:', percent5,'sd5:',round(sd5, 4), 'meanC5:',round(meanC5, 4))) %>% layout(title = capture.output(cat("Points donnant au moins 1 bonne reponses sur les images à 5 régions")))

plot_ly(data[data$percent6 > 0,], x=~eps1, y=~nu,  z=~tho, color=~percent6, text=~paste('%:', percent6,'sd6:',round(sd6, 4), 'meanC6:',round(meanC6, 4))) %>% layout(title = capture.output(cat("Points donnant au moins 1 bonne reponses sur les images à 6 régions")))

plot_ly(data[data$percent7 > 0,], x=~eps1, y=~nu,  z=~tho, color=~percent7, text=~paste('%:', percent7,'sd7:',round(sd7, 4), 'meanC8:',round(meanC7, 4))) %>% layout(title = capture.output(cat("Points donnant au moins 1 bonne reponses sur les images à 7 régions")))

plot_ly(data[data$percent8 > 0,], x=~eps1, y=~nu,  z=~tho, color=~percent8, text=~paste('%:', percent8,'sd8:',round(sd8, 4), 'meanC8:',round(meanC8, 4))) %>% layout(title = capture.output(cat("Points donnant au moins 1 bonne reponses sur les images à 8 régions")))

# (apply(allimages[['5']], 1, mean) - 5) # autre moyen d'avoir le moyenne centré par régions


# ======== =================== ======= #

# ======== ??? ======= #
d = data.frame(expand.grid(x = unique(xyz$eps1), y = unique(xyz$tho), z = 0, w = c(1:10)))
d$z <- d$x**d$w / d$y
plot_ly(x=d$x, y=d$y, z=d$z, frame=d$w)
plot_ly(x=d$x, y=d$y, z=d$z, type='histogram2dcontour')

d = data.frame(expand.grid(x = unique(xyz$eps1), y = unique(xyz$nu), z =unique(xyz$tho)))
plot_ly(d, x=~x, y=~y,  z=~z, color=~( (y / z) / x**x ), text=~( (z ** 2 * (x ** 2 / (y - z)**x) * 10) ) )

plot_ly(d, x=~x, y=~y,  z=~z, color=~( (x*100) * y / z ), frame=~z)
# ======== ??? ======= #

plot_ly(as.data.frame(data1sup1), x=~nu, y=~tho, z=~res, color=~res, colors=colorRamp(c("orange", "red")), text=~res, marker=list(size=~res*scalec+minsize), alpha=1, alpha_stroke=1)
plot_ly(as.data.frame(data1sup1), x=~nu, y=~tho, color=~res, colors=colorRamp(c("orange", "red")), text=~res, marker=list(size=~res*scalec+minsize), alpha=1, alpha_stroke=1)

plot_ly(as.data.frame(data1sup1), x=~eps1, y=~tho, z=~res, color=~res, colors=colorRamp(c("orange", "red")), text=~res, marker=list(size=~res*scalec+minsize), alpha=1, alpha_stroke=1)
plot_ly(as.data.frame(data1sup1), x=~eps1, y=~tho, color=~res, colors=colorRamp(c("orange", "red")), text=~res, marker=list(size=~res*scalec+minsize), alpha=1, alpha_stroke=1)

plot_ly(as.data.frame(data1sup1), x=~eps1, y=~tho) %>%
	add_trace(type='histogram2dcontour', contours = list( showlabels = T, labelfont = list(family = 'Raleway', color = 'white'))) %>%
	add_trace(type='scatter', color=~res, colors=colorRamp(c("yellow", "red")), text=~res, marker=list(size=~res*scalec+minsize))
	
# add_trace(type='histogram2d') 

computeHisto <- function(v, r){
	d <- data.frame(apply(table(v, r), 1, sum))
	d <- tibble::rownames_to_column(d, "x")
	colnames(d) <- c('x', 'y')
	return(d)
}
nbpoints <- 15*15
eps1 <- computeHisto(data1sup1$eps1, data1sup1$res)
nu   <- computeHisto(data1sup1$nu,   data1sup1$res)
tho  <- computeHisto(data1sup1$tho,  data1sup1$res)
plot_ly(alpha = 0.6, x=1:15) %>%
	add_bars(data=eps1, y=~y, name="eps1", text=~x, textposition = 'auto') %>%
	add_bars(data=nu,   y=~y, name="nu",   text=~x, textposition = 'auto') %>%
	add_bars(data=tho,  y=~y, name="tho",  text=~x, textposition = 'auto') %>%
	layout(bargap=0.1, xaxis = list(title = "", showticklabels = FALSE), yaxis = list(title = "fréquence de bons resultats"))

plot_ly(alpha = 0.6, x=1:15) %>%
	add_bars(data=eps1, y=~y/nbpoints, name="eps1", text=~x, textposition = 'auto') %>%
	add_bars(data=nu,   y=~y/nbpoints, name="nu",   text=~x, textposition = 'auto') %>%
	add_bars(data=tho,  y=~y/nbpoints, name="tho",  text=~x, textposition = 'auto') %>%
	layout(bargap=0.1, xaxis = list(title = "Valeurs", showticklabels = FALSE), yaxis = list(title = "fréquence de bons resultats"))

plot_ly(computeHisto(data1sup1$eps1, data1sup1$res), x=~factor(sort(unique(data1sup1$eps1))), y=~y, type="bar") %>% layout(xaxis = list(categoryorder = "array", categoryarray = data1sup1$eps1))
plot_ly(computeHisto(data1sup1$nu,   data1sup1$res), x=~factor(sort(unique(data1sup1$nu))),   y=~y, type="bar") %>% layout(xaxis = list(categoryorder = "array", categoryarray = data1sup1$nu))
plot_ly(computeHisto(data1sup1$tho,  data1sup1$res), x=~factor(sort(unique(data1sup1$tho))),  y=~y, type="bar")

histoshifted <- datam[round(datam$shifted) == 0,]
plot_ly(computeHisto(histoshifted$eps1, histoshifted$shifted), x=~factor(sort(unique(histoshifted$eps1))), y=~y, type="bar") %>% layout(xaxis = list(categoryorder = "array", categoryarray = histoshifted$eps1))

plot_ly(x=~factor(sort(unique(xyz$eps1))), y=~table(histoshifted$eps1), type='bar') %>% layout(xaxis = list(categoryorder = "array", categoryarray = xyz$eps1))
plot_ly(x=~factor(sort(unique(histoshifted$eps1))), y=~table(histoshifted$eps1)/sum(table(histoshifted$eps1)), type='bar') %>% layout(xaxis = list(categoryorder = "array", categoryarray = xyz$eps1))






