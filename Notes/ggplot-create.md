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
<br></br>
由上方的語法，我們會發現在建立圖形對象與建立圖層的語法上，data這個參數所在的位置不同，
這是因為：圖形對象一般現設定數據集；圖層大多用於設定圖形屬性而非數據集。

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

