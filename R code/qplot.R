## install and library ggplot2
install.packages("ggplot2")
library(ggplot2)

## View the diamonds data
head(diamonds)    ## default n = 6
str(diamonds)           ## ?˵??ܼƸ??ƫ??A

## sample from diamonds data, called dsmall.
set.seed(1414)      ##?]?m?ü??I?A?ϳo?ռ˥??㦳?A?ͩ?
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

## qplot
p1 <- qplot(carat, price, data = dsmall, main = "figure-1")
## ?i???????ܼư??B???A?Ь?figure-2?Pfigure-3
p2 <- qplot(carat, log(price), data = dsmall, main = "figure-2")
p3 <- qplot(carat, x * y * z, data = dsmall, main = "figure-3")
## ???G?@???h?Ϧb???ϥ?gridExtra?M?󤤪?grid.arrange????
grid.arrange(p1, p2, p3, ncol = 3)

p4 <- qplot(carat, price, data = dsmall, main = "figure-4", colour = color)
p5 <- qplot(carat, price, data = dsmall, main = "figure-5", shape = cut)
grid.arrange(p4, p5, ncol = 2)

## I() attribute
p6 <- qplot(carat, price, data = dsmall, main = "figure-6", colour = I("red"))
p7 <- qplot(carat, price, data = dsmall, main = "figure-7", shape = I("?\"))
p8 <- qplot(carat, price, data = dsmall, main = "figure-8", alpha = I(1/5))
p9 <- qplot(carat, price, data = dsmall, main = "figure-9", alpha = I(1/10))

## save
png("qplot 6-9.png", width = 640, height = 480)
grid.arrange(p6, p7, p8, p9, ncol = 2)
dev.off()

## geom = c("point", "smooth")
p10 <- qplot(carat, price, data = dsmall, geom = c("point", "smooth"), main = "figure-10")
p11 <- qplot(carat, price, data = diamonds, geom = c("point", "smooth"), main = "figure-11")

png("qplot 10-11.png", width = 480, height = 240)
grid.arrange(p10, p11, ncol = 2)
dev.off()

    ## smoothiing degree, span = 
    p12 <- qplot(carat, price, data = dsmall, geom = c("point", "smooth"), main = "figure-12", span = 0.2)
    p13 <- qplot(carat, price, data = dsmall, geom = c("point", "smooth"), main = "figure-13", span = 1)
    
    png("qplot 12-13.png", width = 480, height = 240)
    grid.arrange(p12, p13, ncol = 2)
    dev.off()

##geom = boxplot?Pgeom = jitter(?Z???I??)
p14 <- qplot(color, price/carat, data = diamonds, geom = "jitter", main = "figure-14")
p15 <- qplot(color, price/carat, data = diamonds, geom = "boxplot", main = "figure-15")

png("qplot 14-15.png", width = 480, height = 240)
grid.arrange(p14, p15, ncol = 2)
dev.off()

##geom = "histogram", geom = "density"
p16 <- qplot(carat, data = diamonds, geom = "histogram", main = "figure-16")
p17 <- qplot(color, data = diamonds, geom = "density", main = "figure-17")

png("qplot 16-17.png", width = 480, height = 240)
grid.arrange(p16, p17, ncol = 2)
dev.off()

    ## binwidth
    p18 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 1, main = "figure-18\n(binwidth = 1)")
    p19 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.1, main = "figure-19\n(binwidth = 0.1)")
    p20 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.01, main = "figure-20\n(binwidth = 0.01)")

    png("qplot 18-20.png", width = 480, height = 240)
    grid.arrange(p18, p19, p20, ncol = 3)
    dev.off()

    ## adjust
    p21 <- qplot(carat, data = diamonds, geom = "density", adjust = 0.1, main = "figure-21\n(adjust = 0.1)")
    p22 <- qplot(carat, data = diamonds, geom = "density", adjust = 0.5, main = "figure-22\n(adjust = 0.5)")
    p23 <- qplot(carat, data = diamonds, geom = "density", adjust = 1, main = "figure-23\n(adjust = 1)")

    png("qplot 21-23.png", width = 480, height = 240)
    grid.arrange(p21, p22, p23, ncol = 3)
    dev.off()

p24 <- qplot(carat, data = diamonds, geom = "density", colour = color)
p25 <- qplot(carat, data = diamonds, geom = "histogram", fill = color) 
## fill 代表繪製實心的bar
png("qplot 24-25.png", width = 480, height = 240)
grid.arrange(p24, p25, ncol = 2)
dev.off()

p26 <- qplot(carat, data = diamonds, geom = "histogram", facets = color ~ ., binwidth = 0.1, xlim = c(0, 3)) 
png("qplot 26.png", width = 480, height = 640)
p26
dev.off()