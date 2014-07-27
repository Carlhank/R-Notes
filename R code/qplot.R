## install and library ggplot2
install.packages("ggplot2")
library(ggplot2)

## View the diamonds data
head(diamonds)    ## default n = 6
str(diamonds)           ## 檢視變數資料型態

## sample from diamonds data, called dsmall.
set.seed(1414)      ##設置亂數點，使這組樣本具有再生性
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

## qplot
p1 <- qplot(carat, price, data = dsmall, main = "figure-1")
## 可直接對變數做運算，請看figure-2與figure-3
p2 <- qplot(carat, log(price), data = dsmall, main = "figure-2")
p3 <- qplot(carat, x * y * z, data = dsmall, main = "figure-3")
## 註：一頁多圖在此使用gridExtra套件中的grid.arrange函數
grid.arrange(p1, p2, p3, ncol = 3)

p4 <- qplot(carat, price, data = dsmall, main = "figure-4", colour = color)
p5 <- qplot(carat, price, data = dsmall, main = "figure-5", shape = cut)
grid.arrange(p4, p5, ncol = 2)

## I() attribute
p6 <- qplot(carat, price, data = dsmall, main = "figure-6", colour = I("red"))
p7 <- qplot(carat, price, data = dsmall, main = "figure-7", shape = I("α"))
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

##geom = boxplot與geom = jitter(擾動點圖)
p14 <- qplot(color, price/carat, data = diamonds, geom = "jitter", main = "figure-14")
p15 <- qplot(color, price/carat, data = diamonds, geom = "boxplot", main = "figure-15")

png("qplot 14-15.png", width = 480, height = 240)
grid.arrange(p14, p15, ncol = 2)
dev.off()

    ## binwidth
    p16 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 1, main = "figure-18\n(binwidth = 1)")
    p17 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.1, main = "figure-19\n(binwidth = 0.1)")
    p18 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.01, main = "figure-20\n(binwidth = 0.01)")

    png("qplot 16-18.png", width = 480, height = 240)
    grid.arrange(p16, p17, p18, ncol = 3)
    dev.off()

    ## adjust
    p19 <- qplot(carat, data = diamonds, geom = "density", adjust = 0.5, main = "figure-22\n(adjust = 0.5)")
    p20 <- qplot(carat, data = diamonds, geom = "density", adjust = 0.1, main = "figure-21\n(adjust = 0.1)")
    p21 <- qplot(carat, data = diamonds, geom = "density", adjust = 1, main = "figure-23\n(adjust = 1)")

    png("qplot 19-21.png", width = 480, height = 240)
    grid.arrange(p19, p20, p21, ncol = 3)
    dev.off()