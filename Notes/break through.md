## 進階語法概述

### 前言

使用qplot雖然可以幫助我們快速繪製出需要的圖形；但為了使圖形更符合我們的需求，我們必須深入學習ggplot2套件中的相關語法，並了解圖層內容與各圖形組件。

#### ☞例：耗油量數據集(數據來源：[EPA燃油經濟網站](http://fueleconomy.gov))

``````r
head(mpg)
``````

|manufacturer |model | displ| year| cyl|trans      |drv | cty| hwy|fl |class   |
|:------------|:-----|-----:|----:|---:|:----------|:---|---:|---:|:--|:-------|
|audi         |a4    |   1.8| 1999|   4|auto(l5)   |f   |  18|  29|p  |compact |
|audi         |a4    |   1.8| 1999|   4|manual(m5) |f   |  21|  29|p  |compact |
|audi         |a4    |   2.0| 2008|   4|manual(m6) |f   |  20|  31|p  |compact |
|audi         |a4    |   2.0| 2008|   4|auto(av)   |f   |  21|  30|p  |compact |
|audi         |a4    |   2.8| 1999|   6|auto(l5)   |f   |  16|  26|p  |compact |
|audi         |a4    |   2.8| 1999|   6|manual(m5) |f   |  18|  26|p  |compact |

```r```
str(mpg)
``````

``````
'data.frame':234 obs. of  11 variables:
 $ manufacturer: Factor w/ 15 levels "audi","chevrolet",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ model       : Factor w/ 38 levels "4runner 4wd",..: 2 2 2 2 2 2 2 3 3 3 ...
 $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
 $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
 $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
 $ trans       : Factor w/ 10 levels "auto(av)","auto(l3)",..: 4 9 10 1 4 9 1 9 4 10 ...
 $ drv         : Factor w/ 3 levels "4","f","r": 2 2 2 2 2 2 2 1 1 1 ...
 $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
 $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
 $ fl          : Factor w/ 5 levels "c","d","e","p",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ class       : Factor w/ 7 levels "2seater","compact",..: 2 2 2 2 2 2 2 2 2 2 ...
``````

重要變量描述：

● manufacturer：製造商

● model       ：車子型號

● displ       ：引擎排氣量(升)

● year        ：汽車出廠年度

● cyl         ：汽缸數目

● cty         ：城市道路耗油量

● hwy         ：高速公路耗油量

● class       ：類別

<br></br>
#####Question：引擎大小與油耗量的關係?

#####Scatter plot

透過繪製散布圖的方式，可以粗略的得到這個問題的答案，以下我們來看看該如何繪製這張散布圖：

```r```
qplot(displ, hwy, data = mpg, colour = factor(cyl))
``````

![mpg-scatter](https://github.com/Carlhank/ggplot2-note/blob/master/ggplot_figure/mpg-scatter.png)

這張圖繪製displ與hwy之散布圖，並將cyl當作類別型變量用以區隔散布圖中汽車的汽缸數。

此圖展示了汽缸數較多的車輛：

1. 排氣量大多較汽缸數少的車輛來的多。
2. 高速公路的耗油量較汽缸數少的車輛來的低。

接著我們將探討這張圖形的構成
<br></br>
#####圖形屬性與數據映射：

+ 圖形屬性(aesthetics)：本張散布圖中的每個點都有其對應的座標、形狀、大小與顏色，這些屬性我們稱為**圖形屬性**。

  每個圖形屬性都可以映射為一個變量，如上圖中：

  1. 水平位置 → displ
  2. 重直位置 → hwy
  3. 點的顏色 → cyl

+ **尺度變換(scaling)**：mpg中(displ, hwy, cyl)的原始數據，對於電腦而言是不具任何意義的，因此需透過尺度變換讓電腦可以辨認這些數據。

  座標轉換：(水平位置, 垂直位置) = (displ, hwy) 分別映射至 [0, 1] 區間上，再透過座標系統(coord)決定位置。

Ex：

|     x|     y|     cyl| 大小| 形狀|
|-----:|-----:|:-------|--:|--:|
| 0.037| 0.531|#0000FF |  1| 19|
| 0.037| 0.531|#0000FF |  1| 19|
| 0.074| 0.594|#0000FF |  1| 19|
| 0.074| 0.562|#0000FF |  1| 19|
| 0.222| 0.438|#FF00FF |  1| 19|
| 0.222| 0.438|#FF00FF |  1| 19|
| 0.278| 0.469|#FF00FF |  1| 19|
| 0.037| 0.438|#0000FF |  1| 19|
| 0.037| 0.406|#0000FF |  1| 19|
| 0.074| 0.500|#0000FF |  1| 19|

將displ與hwy進行作標轉換成x, y，cyl轉換成電腦可辨識的16進位的RGB色彩符。

##### 完整圖形要素：
+ data(數據)
+ scaling(尺度) and coord(座標系統)
+ 圖形注釋(legend)

### 圖層語法組件
**1).** 圖層

圖層包含：數據、圖形屬性映射、幾何形狀、統計變換、位置調整。

**2).** 尺度

控制數據至圖形屬性的映射，圖形上每一個圖形屬性都對應一個尺度，一個尺度就是含有一組參數的函數，如：顏色梯度、線條粗細、點的形狀...等。

**3).** 座標系

可將對象映射到圖形平面上(常用座標系:笛卡爾座標系)

座標系可影響所有位置變量，也可改變幾何對象外觀(如:讓條型圖看起來像扇形)

**順序：尺度轉換 → 統計變換 → 座標轉換**

**4).** 分面

分面為條件繪圖(condition plots)與網格繪圖(trellised plots)的一般形式，以方便的展示及比對子集數據。

### 數據內容處理
當我們獲得一張圖形時，可透過下方函數對數據進行處理：
+ print()  ：印出圖形(常用於迴圈內)
+ ggsave() ：保存圖片
+ summary()：查詢圖形結構
+ save()   ：保存圖形對象
+ load()   ：載入圖形對象

☞ Example：
```r```
p <- qplot(displ, hwy, data = mpg, colour = factor(cyl))  ## 建立圖形
print(p)                                                  ## 印出圖形
ggsave("plot.png", width = 480, height =240)              ## 保存圖形
summary(p)                                                ## 展示圖形內容
    ``````
    data: manufacturer, model, displ, year, cyl, trans, drv, cty, hwy, fl, class [234x11]
    mapping:  colour = factor(cyl), x = displ, y = hwy
    faceting: facet_null()
    -----------------------------------
    geom_point:
    stat_identity:
    position_identity: (width = NULL, height = NULL)

    ``````
save(p, file = "qplot.rdata")                              ## 保存圖形對象
load("qplot.rdata")                                        ## 載入圖形對象
``````
