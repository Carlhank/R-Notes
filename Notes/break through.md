## 進階語法概述

### 前言

使用qplot雖然可以幫助我們快速繪製出需要的圖形；但為了使圖形更符合我們的需求，我們必須深入學習ggplot2套件中的相關語法，並了解圖層內容與各圖形組件。

#### ☞例：耗油量數據集(數據來源：[EPA燃油經濟網站](http://fueleconomy.gov))

```r```
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

`````
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
`````

重要變量描述：

● manufacturer：製造商

● model       ：車子型號

● displ       ：引擎排氣量(升)         

● year        ：汽車出廠年度

● cyl         ：汽缸數目               

● cty         ：城市道路耗油量

● hwy         ：高速公路耗油量         

● class       ：類別


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

