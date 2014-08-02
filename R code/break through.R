head(mpg)
str(mpg)
qplot(displ, hwy, data = mpg, colour = factor(cyl))

p <- qplot(displ, hwy, data = mpg, colour = factor(cyl))  ## 建立圖形
print(p)                                                  ## 印出圖形
ggsave("plot.png", width = 480, height =240)              ## 保存圖形
summary(p)                                                ## 展示圖形內容
save(p, file = "qplot.rdata")                              ## 保存圖形對象
load("qplot.rdata")                                        ## 載入圖形對象