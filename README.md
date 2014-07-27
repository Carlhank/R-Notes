##數據可視化套件 — ggplot2
###➢ 前言
###➢ 圖形語法概述
統計圖形：
![wilkinson](https://raw.githubusercontent.com/Carlhank/R-Notes/master/ggplot_figure/Wilkinson_grammar.png)
<div align = 'center'>Wilkinson(2005) 語法概念</div>

註：
  * 幾何對象(geometric object, 縮寫為geom)，包含：point, line, bar…
  * 圖形屬性(aesthetic attributes, 縮寫為aes)，包含：color, shape, size…

###➢ 圖形部件概述：
   * 映射(mapping)：將數據對應至相關圖形屬性。
   * 幾何對象(geom)：圖形元素，包含：point, line, bar…。
   * 圖形屬性(aes)：包含：colour, shape, size…
   * 統計變換(stat)：對數據進行彙整，如：分組計數、線性模型等。
   * 尺度(scale)：將數據取值映射至圖形空間，如：利用不同的顏色代表不同的數據值。
                  (常利用繪製座標軸的方式使讀者能讀取原始的數據值)
   * 座標系(coord)：描述圖形如何映射於平面上(同時描繪出座標及網格)。
   * 分面(facet)：將數據分割為多個子集，並將這些子集繪於同一張圖上

  ※註：ggplot2 只能繪製出**_靜態圖形_**

###➢ 安裝與載入ggplot2套件
```r
install.packages("ggplot2")
library(ggplot2)
```

###➢ qplot 快速繪圖
#### 簡介
qplot：為quick plot的縮寫，目的為讓使用者快速的繪製出複雜的圖形，qplot的使用方式類似於R中的基本繪圖函數plot，我們可以利用```?qplot```查詢相關參數的描述。

#### ☞例：鑽石數據集繪圖
在ggplot2中提供了一個diamonds的數據集，我們將利用這個數據集提供一個qplot的繪圖範例。


##### diamonds 資料集檢視

```r
head(diamonds)    ## default n = 6
```

| carat|       cut|color |clarity | depth| table| price|    x|    y|    z|
|-----:|:---------|:-----|:-------|-----:|-----:|-----:|----:|----:|----:|
|  0.23|Ideal     |E     |SI2     |  61.5|    55|   326| 3.95| 3.98| 2.43|
|  0.21|Premium   |E     |SI1     |  59.8|    61|   326| 3.89| 3.84| 2.31|
|  0.23|Good      |E     |VS1     |  56.9|    65|   327| 4.05| 4.07| 2.31|
|  0.29|Premium   |I     |VS2     |  62.4|    58|   334| 4.20| 4.23| 2.63|
|  0.31|Good      |J     |SI2     |  63.3|    58|   335| 4.34| 4.35| 2.75|
|  0.24|Very Good |J     |VVS2    |  62.8|    57|   336| 3.94| 3.96| 2.48|

##### 變數意義：

**鑽石質量4C**

1. carat	克拉重量
2.	cut	切工
3.	color	色澤
4.	clarity	淨度

**五個物理指標**
  
![diamonds property](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/diamonds_meaning.png)

```r
str(diamonds)			## 檢視變數資料型態
```

```
'data.frame':	53940 obs. of  10 variables:
 $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
 $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
 $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
 $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
 $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
 $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
 $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```


現在我們利用抽樣的方式選取100筆來自這個資料集的樣本，稱為dsmall：
```r
set.seed(1414)      ##設置亂數點，使這組樣本具有再生性
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
```
|原始列| carat|       cut|color |clarity | depth| table| price|    x|    y|    z|
|:-----|-----:|:---------|:-----|:-------|-----:|-----:|-----:|----:|----:|----:|
|12221 |  1.00|Premium   |F     |SI1     |  60.3|  58.0|  5197| 6.43| 6.47| 3.89|
|18720 |  0.30|Very Good |G     |VS1     |  60.3|  57.0|   620| 4.33| 4.35| 2.62|
|25096 |  1.72|Fair      |F     |SI1     |  64.8|  58.0| 13622| 7.50| 7.46| 4.85|
|9067  |  1.02|Good      |H     |SI2     |  60.3|  63.0|  4517| 6.45| 6.49| 3.90|
|47744 |  0.59|Ideal     |G     |SI1     |  61.3|  56.0|  1891| 5.41| 5.43| 3.32|
|14262 |  1.24|Premium   |E     |SI1     |  58.5|  60.0|  5775| 7.08| 7.01| 4.11|

##### qplot基本用法

  carat 與price的散布圖

```r
  p1 <- qplot(carat, price, data = dsmall, main = "figure-1")
  ## 可直接對變數做運算，請看figure-2與figure-3
  p2 <- qplot(carat, log(price), data = dsmall, main = "figure-2")
  p3 <- qplot(carat, x * y * z, data = dsmall, main = "figure-3")
  ## 註：一頁多圖在此使用gridExtra套件中的grid.arrange函數
```

![qplot 1-3](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%201-3.png)

+ 資料按照圖形屬性分類

```r
  p4 <- qplot(carat, price, data = dsmall, main = "figure-4", colour = color)
  p5 <- qplot(carat, price, data = dsmall, main = "figure-5", shape = cut)
```

![qplot 4-5](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%204-5.png)

上圖4：資料將color變量映射到點(point)的顏色(colour)

上圖5：資料將cut變量映射到點(point)的形狀(shape)

<br></br>
  ◎ I()屬性：手動設定圖形屬性

```r
   p6 <- qplot(carat, price, data = dsmall, main = "figure-6", colour = I("red"))
   p7 <- qplot(carat, price, data = dsmall, main = "figure-7", shape = I("α"))
   p8 <- qplot(carat, price, data = dsmall, main = "figure-8", alpha = I(1/5))
   p9 <- qplot(carat, price, data = dsmall, main = "figure-9", alpha = I(1/10))
```

![qplot 6-9](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%206-9.png)

上圖6, 7：分別設定圖形的顏色為紅色，以及圖形的形狀為α

上圖8, 9：設定圖形的透明度(alpha值介於0～1)

<br></br>

##### 幾何對象(geom)

   直至目前為止我們所繪製的圖形其幾何對象都是point，但在統計圖形上經常用到的還有line, smooth line, boxplot,…等，故在此會介紹幾種在ggplot2中的幾何對象。

- geom = "point"		##預設的幾何對象，用於繪製散布圖
- geom = "smooth"	##繪製一條平滑曲線，包含配適線與標準誤
- geom = "boxplot"	##繪製箱型圖
- geom = "histogram", geom = "density"	## Continuous data
- geom = "bar"					## Discrete data
- geom = "line", geom = "path"

<br></br>
☞ **Examples：**

**1).** geom = c("point", "smooth")		##配適曲線，灰色部份為標準誤

```r
p10 <- qplot(carat, price, data = dsmall, geom = c("point", "smooth"), main = "figure-10")
p11 <- qplot(carat, price, data = diamonds, geom = c("point", "smooth"), main = "figure-11")
```

![qplot 10-11](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%2010-11.png)

a).灰色部份為標準誤的範圍，若不想繪製標準誤，可添加se = FALSE這個參數設定。

b).figure-10默認採用的配適方法為method = "loess"

c).figure-11配適過程中因為資料點大於1,000，故不適宜採用method = "loess"支配適方法，
   因此qplot會默認使用method = "gam", formula: y ~ s(x, bs = "cs")進行配適。
             
d).一些配適方法：

   配適直線
    
    ■	method = "lm"		
    
    ■ method = "rlm"			##與lm類似；但對NA值不敏感
    
   配適多項式
    
    ■ method = "lm", formula: y ~ poly(x, k)
    
    ■ method = "lm", formula: y ~ ns(x, k)		##須library(splines)


    曲線配適平滑程度參數調用(span = …)
```r
p12 <- qplot(carat, price, data = dsmall, geom = c("point", "smooth"), main = "figure-12", span = 0.2)
p13 <- qplot(carat, price, data = dsmall, geom = c("point", "smooth"), main = "figure-13", span = 1)
```

![qplot 12-13](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%2012-13.png)

**2).** geom = boxplot與geom = jitter(擾動點圖)
    在data frame中可能包含類別型變量與連續型變量，我們想知道連續型變量如何隨著類別型變量變化而變化，因此可藉由boxplot或jitter達到這個目的。
```r
p14 <- qplot(color, price/carat, data = diamonds, geom = "jitter", main = "figure-14")
p15 <- qplot(color, price/carat, data = diamonds, geom = "boxplot", main = "figure-15")
```

![qplot 14-15](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%2014-15.png)

**3).**	geom = "histogram", geom = "density"
```r
p16 <- qplot(color, price/carat, data = diamonds, geom = "jitter", main = "figure-16")
p17 <- qplot(color, price/carat, data = diamonds, geom = "boxplot", main = "figure-17")
```

![qplot 16-17](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%2016-17.png)

+ binwidth(組距參數)與adjust(平滑程度參數)

    binwidth值大時能表現出數據總體特徵，值小時能表現出較多數據細節；而密度曲線圖在adjust調用上十分的重要(adjust愈大，曲線愈平滑)。

```r
p18 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 1, main = "figure-18\n(binwidth = 1)")
p19 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.1, main = "figure-19\n(binwidth = 0.1)")
p20 <- qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.01, main = "figure-20\n(binwidth = 0.01)")
```

![qplot 18-20](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%2018-20.png)

```r
p21 <- qplot(carat, data = diamonds, geom = "density", adjust = 0.1, main = "figure-21\n(adjust = 0.1)")
p22 <- qplot(carat, data = diamonds, geom = "density", adjust = 0.5, main = "figure-22\n(adjust = 0.5)")
p23 <- qplot(carat, data = diamonds, geom = "density", adjust = 1, main = "figure-23\n(adjust = 1)")
```

![qplot 21-23](https://github.com/Carlhank/R-Notes/blob/master/ggplot_figure/qplot%2021-23.png)
