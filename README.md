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

※註：ggplot2 只能繪製出<span class = "color:red">__靜態圖形__</span>

```r
qplot(carat, price, data = diamonds)
```
