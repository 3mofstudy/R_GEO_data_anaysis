#1.安裝GEOquery
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("GEOquery")
BiocManager::install("affy")
BiocManager::install(c("CLL"))
#2 .啟動GEOquery
library("GEOquery")
browseVignettes("GEOquery") #查看GEOquery說明文件


#3. 設定工作路徑
 setwd("D:/R/Documents/Rtest")
 getwd()
 tmp <- getGEOSuppFiles("GSE24673",baseDir = getwd())
 
 if (is.null(tmp)){
   warning("沒有檔案可以下載")
 }
 
#4.解壓縮
 untar("GSE24673/GSE24673_RAW.tar",exdir = "data")#第1次解縮
 cels <- list.files("data/", pattern = ".gz")# 選取data資料夾下的檔案路徑
 sapply(paste("data",cels, sep = "/"),gunzip)#第2次解縮

#5.RMA標準化
 library(affy)
 library(CLL)
 data<- ReadAffy(celfile.path ="~/R/test/data/")
 eset<- rma(data)
 write.exprs(eset,file="data.txt")
