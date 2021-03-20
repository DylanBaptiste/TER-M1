library(plotly)

data = read.csv('C:/Cours/test/data.csv')
head(data)
xs       = sort(unique(data[,1]))
ys       = sort(unique(data[,2]))
zs       = sort(unique(data[,3]))
values   = data[,4]


abcd <- expand.grid(1:5,1:5,1:5,1:5)
xyz <- expand.grid(xs, ys, zs)
colnames(abcd) <- c('a', 'b', 'c', 'd')
colnames(xyz) <-c('x', 'y', 'z')
h <- function(row){
	a <- row[1]
	b <- row[2]
	c <- row[3]
	d <- row[4]
	z <- row[5]
	y <- row[6]
	x <- row[7]
	return(a*x + b*y + c*z + d)
	#return(paste(a,b,c,d,x,y,z,a*x + b*y + c*z + d))
}

f <- function(row){
	d <- row[1]
	c <- row[2]
	b <- row[3]
	a <- row[4]
	return(apply(expand.grid(a,b,c,d, zs, ys, xs), 1, h))
}

X <- c()
X <- apply(abcd, 1, f)
X <- t(X)

save()
tail(X)
length(X2)
X[,c(1:4)]


write.csv(abcd, "C:\\Cours\\test\\y.csv", row.names = FALSE)
write.csv(X, "C:\\Cours\\test\\X.csv", row.names = FALSE)

csv1 <- read.csv("C:\\Cours\\test\\save.csv")
csv2 <- read.csv("C:\\Cours\\test\\save2.csv")

p <- function(i, j){
	x <- i:j
	terrain <- csv1[x,1]
	approximation1 <- csv1[x,2]
	approximation2 <- csv2[x,2]
	data <- data.frame(x, terrain, approximation1, approximation2)
	
	fig <- plot_ly(data, x=~x)
	fig <- fig %>% add_trace(y=~terrain,        name ='terrain',        mode = 'lines+markers')
	fig <- fig %>% add_trace(y=~approximation1, name ='x²', mode = 'lines+markers')
	fig <- fig %>% add_trace(y=~approximation2, name ='x', mode = 'lines+markers')
	fig
}


p(1, 12000)
