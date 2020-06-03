# Installation  安裝並加載所需R包。
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
 
BiocManager::install("affy")
BiocManager::install(c("CLL"))
BiocManager::install("pd.hg.u133.plus.2")

data(pmSequence)


#黃博commands

library(affy)
data<- ReadAffy("D:/Documents/R_work_space/GEO40367/data/GSM992272.cel")
eset<- rma(data)
write.exprs(eset,file="data.txt")

#網路commands

#CLL包會自動調用affy包，affy包含有後面需要的rma()函數。
library (CLL)

#讀入數據(CLL包中附帶的示例數據集)
data(CLLbatch)

#調用RMA算法來對數據預處理
CLLrma <- rma(CLLbatch)

#讀取預處理後所有樣品的基因(實際上是探針組)表達值
e <- exprs(CLLrma)

#查看部分數據。
e[1:5, 1:5]

write.table(data1, 
            file = "D:/ddd.txt", 
            append = FALSE, 
            quote = TRUE, 
            sep = "|",
            eol = "\n", 
            na = "NA", 
            dec = ".", 
            row.names = TRUE,
            col.names = TRUE, 
            qmethod = c("escape", "double"),
            fileEncoding = "")
