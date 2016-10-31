## loading required libraries
library(GEOmetadb); library(GEOquery)

## GEOmetadb query
if(!file.exists('~/GEOmetadb.sqlite')) getSQLiteFile() # downlaod GEOmetadb 
con <- dbConnect(SQLite(),'~/GEOmetadb.sqlite') # connect to GEOmetadb
query_terms = c("'%RKIP%'", "'%raf%kinase%inhibitor%'") # query search terms for RKIP
for(i in query_terms){
  GEO_query[i] <- dbGetQuery(con,paste("select gse,title,gse from gse where",
                                    "title like", i,sep=" ")) # search GEO data for the terms
  }

## downloading GEO data
GSE_files = sapply(unlist(GEO_query), getGEO) # download GEO data using accession numbers

dbDisconnect(con) # disconnet GEOmetabd
rm(con, GEO_query, i, query_terms) # clean up global environment

## quality control and exploration
## filtering by missing information
## Visualizing genes of interest
## gene set enrichment
