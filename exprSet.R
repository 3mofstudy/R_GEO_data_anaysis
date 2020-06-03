library(data.table)
GPL1352_anno <- data.table::fread("GPL570.annot")

iddata <- as.data.frame(GPL1352_anno)[,c('ID','Gene symbol')]

colnames(iddata)[2] <- 'symbol'#移除有空格的列名(列名有空格不好處理)

iddata <- iddata[-grep(pattern='///', iddata[,'symbol']), ]#去除一個探針對應多個基因的行

exprSet <-data.table::fread("GSE43837_series_matrix.txt",skip ="ID")

library(dplyr)

exprSet.final <- exprSet %>%
  
  inner_join(iddata,by="ID") %>% ##合併探針訊息
  
  select(-ID) %>% ##去掉多餘信息
  
  select(symbol, everything()) %>% #重新排列
  
  mutate(rowMean =rowMeans(.[grep("GSM", names(.))])) %>% #求出平均数
  
  arrange(desc(rowMean)) %>% #把表達量的平均值按從大到小排序
  
  distinct(symbol,.keep_all = T) %>% # 留下第一個symbol
  
  select(-rowMean) %>% #反向選擇去除rowMean這一列
  
  tibble::column_to_rownames(colnames(.)[1]) # 把第一列變成成行名並删除

###保存數據

save(exprSet.final,file="exprsetFinal.Rda" )
