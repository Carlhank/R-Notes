## 建立圖形對象與圖層

首先我們先探討一下qplot在使用上的限制：

1. 只能使用一個數據集
2. 只能使用一組圖形屬性映射

How to solve?? → **_使用圖層_**

Review 圖層包含內容：
+ 數據：必須是**資料框架(data frame)**
+ 圖形屬性映射：設定數據集如何映射至該圖層的圖形屬性
+ 幾何對象：指定圖層中使用哪些幾何對象來繪圖
+ 統計變換：對數據進行所需之統計變換，統計變換後傳回一個包含新變量的資料框架
+ 位置調整：調整元素位置以避免圖形重疊

### 建立繪圖對象
使用qplot時，這個函數會依照以下順序繪圖：建立圖形對象 → 添加圖層 → 展示結果，這當中有需多默認的值qplot會幫我們建立，如果想手動建立圖層，需使用``````ggplot``````這個函數。

ggplot的主要元素：
+ 數據(data = ...)
+ 圖形屬性映射(使用於aes參數項中)

基本用法：
```r
p <- ggplot(data = diamonds, aes(x = carat, y = price, colour = cut))
## 注意：在加入圖層前，運行p無法展示結果
```
### 添加圖層

**Method 1.**

繪圖對象+layer(geom, geom_params, stat, stat_params, data, mapping, position)

Ex1：
```r
p + layer(geom = "point")
```

Ex2：
```r
p <- ggplot(data = diamonds, aes(x = carat))
p + layer(
    geom = "bar",
    geom_params = list(fill = "steelblue"),
    stat = "bin",
    stat_params = list(binwidth = 2)
    )
```

**Method 2.(使用快捷函數)**

+ 繪圖對象+ geom_XXX(mapping, ..., data, stat, position)
+ 繪圖對象+ stat_XXX(mapping, ..., data, geom, position)

其中的XXX可以是：bar, histogram, point, line, path, ... 等

Ex：
```r
p <- ggplot(data = diamonds, aes(x = carat, y = price, colour = cut))
p + geom_point()
```
由上方的語法，我們會發現在建立圖形對象與建立圖層的語法上，data這個參數所在的位置不同

這是因為：圖形對象一般先設定數據集；圖層大多用於設定圖形屬性而非數據集。

### 數據
在ggplot2中對數據的要求是：**數據必須是個data frame**。

由於數據是十分重要的，所以ggplot2在處理數據時，並不對原始數據進行更動，而是生成一個新數據來進行轉換。

數據處理可使用：dplyr和reshape2這兩個packages。

改變數據集使用：``````%+%`````` 這個運算子，如下例：

```r
p <- ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) + geom_point()
mtcars <- transform(mtcars, mpg = mpg^2)
p + labs(title = "Original mpg data")
p %+% mtcars + labs(title = expression(paste("Transfer mpg data to ", mpg^2, sep = "")))
```
![Change data](https://github.com/Carlhank/ggplot2-note/blob/master/ggplot_figure/layer/change%20data.png)

### 圖形屬性映射

aes()函數：用於將數據變量映射至圖形中，使數據變為可以感知的圖形屬性，如：

```r
aes(weight, height, colour = sqrt(age))
```

```
    List of 3
    $ x     : symbol weight
    $ y     : symbol height
    $ colour: language sqrt(age)
```
在此我們指定x軸映射到weight變量, y軸映射到heigth變量, colour映射到sqrt(age)

※ 註：在指定變量時，最好指定位於相同數據集的變量。

如：``````aes(diamonds$carat, height, colour = sqrt(age))``````這樣的指定方式是不好的

**Topic 圖與圖層**

默認的圖形屬性：

1. 圖形初始化時設定
2. 使用``````+``````進行添加或修改

以下兩種方式可建立相同圖形：

```r
## method1.
p <- ggplot(mtcars, aes(x = mpg, y = wt))
p + geom_point()

## method2.
p <- ggplot(mtcars)
p <- p + aes(x = mpg, y = wt)
```
![add aes](https://github.com/Carlhank/ggplot2-note/blob/master/ggplot_figure/layer/layer-figure-1.png)

在新圖中進行添加或修改：

```r
p <- ggplot(mtcars, aes(x = mpg, y = wt))
p + geom_point(aes(colour = factor(cyl))) + labs(title = "add colour aes")      ## 添加colour屬性
p + geom_point(aes(y = disp)) + labs(title = "change y-axis corresponding data", y = "disp")        ## 修改數據(注意：在此更換y軸數據後y-label需重新修改，否則y-label仍會與原始圖形相同)
```
![add or modify](https://github.com/Carlhank/ggplot2-note/blob/master/ggplot_figure/layer/layer-figuer-2.png)

**Topic 設定與映射**

在圖層參數中，我們可以將圖形屬性設定為單一值(如：colour = "blue")，不過我們需要區別以下這兩種用法：

```r
g <- ggplot(mtcar, aes(mpg, wt))
g + geom_point(colour = "darkblue") + labs(title = 'colour = "darkblue"')
g + geom_point(aes(colour = "darkblue")) + labs(title = 'aes(colour = "darkblue")')
```
![setting and mapping](https://github.com/Carlhank/ggplot2-note/blob/master/ggplot_figure/layer/setting%20and%20mapping.png)

圖左：將顏色設定為單一的深藍色

圖右：建立一個"darkblue"的字符變量，再將colour映射到這個變量，但此變量為離散型，因此默認的顏色尺度會取用色輪上等間距之顏色

**Topic 分組**

**Topic 匹配圖形數性與圖形對象**

