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

## 圖與圖層
# 1. 圖形屬性於初始時設定
p <- ggplot(mtcars, aes(x = mpg, y = wt))
p + geom_point()

# 2. 使用'+'進行修改
p <- ggplot(mtcars)
p <- p + aes(x = mpg, y = wt)

png("layer-figure-1.png", width = 480, height = 240)
p + geom_point()
dev.off()

## 新圖中進行添加或修改
p <- ggplot(mtcars, aes(x = mpg, y = wt))

png("layer-figuer-2.png", width = 640, height = 240)
grid.arrange(
        p + geom_point(aes(colour = factor(cyl))) + labs(title = "add colour aes"),
        p + geom_point(aes(y = disp)) + labs(title = "change y-axis corresponding data", y = "disp"),
        ncol = 2
)
dev.off()

#設定與映射
g <- ggplot(mtcars, aes(mpg, wt))

png("setting and mapping.png", width = 640, height = 240)
grid.arrange(
    g + geom_point(colour = "darkblue") + labs(title = 'colour = "darkblue"'),
    g + geom_point(aes(colour = "darkblue")) + labs(title = 'aes(colour = "darkblue")'),
    ncol = 2
    )
dev.off()