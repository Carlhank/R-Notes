##數據可視化套件 — ggplot2
###➢ 前言
###➢ 圖形語法概述
統計圖形：
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

   ※註：ggplot2 只能繪製出__靜態圖形__

###➢ 安裝ggplot2套件
```r
install.packages("ggplot2")
```

###➢ qplot 快速繪圖
#### 簡介
qplot：為quick plot的縮寫，目的為讓使用者快速的繪製出複雜的圖形，qplot的使用方式類似於R中的基本繪圖函數plot，
       我們可以利用?qplot查詢相關參數的描述。

#### 例：鑽石數據集繪圖
在ggplot2中提供了一個diamonds的數據集，我們將利用這個數據集提供一個qplot的繪圖範例。
* diamonds 資料集檢視

```r
qplot(carat, price, data = diamonds)
```

|	|carat	|cut		|color	|clarity	|depth	|table	|price	|x	|y	|z   |
|-------|-------|---------------|-------|---------------|-------|-------|-------|-------|-------|----|
|1	|0.23	|Ideal		|E	|SI2		|61.5	|55	|326	|3.95	|3.98	|2.43|
|2	|0.21	|Premium	|E	|SI1		|59.8	|61	|326	|3.89	|3.84	|2.31|
|3	|0.23	|Good		|E	|VS1		|56.9	|65	|327	|4.05	|4.07	|2.31|
|4	|0.29	|Premium	|I	|VS2		|62.4	|58	|334	|4.20	|4.23	|2.63|
|5	|0.31	|Good		|J	|SI2		|63.3	|58	|335	|4.34	|4.35	|2.75|
|6	|0.24	|Very Good	|J	|VVS2		|62.8	|57	|336	|3.94	|3.96	|2.48|


