### 建立繪圖對象
p <- ggplot(data = diamonds, aes(x = carat, y = price, colour = cut))

### 添加圖層

## Method 1.

#Ex1：
p + layer(geom = "point")

#Ex2：

p <- ggplot(data = diamonds, aes(x = carat))
p + layer(
    geom = "bar",
    geom_params = list(fill = "steelblue"),
    stat = "bin",
    stat_params = list(binwidth = 2)
    )

## Method 2.使用快捷函數
p <- ggplot(data = diamonds, aes(x = carat, y = price, colour = cut))
p + geom_point()

## 數據更換
p <- ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) + geom_point()
mtcars <- transform(mtcars, mpg = mpg^2)

png("change data.png", width = 640, height = 240)
grid.arrange(
        p + labs(title = "Original mpg data"),
        p %+% mtcars + labs(title = expression(paste("Transfer mpg data to ", mpg^2, sep = ""))),
        ncol = 2)
dev.off()

