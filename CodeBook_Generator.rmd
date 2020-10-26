---
title: "Codebook - Getting and Cleaning Data Project"
author: "DKlem"
date: "10/25/2020"
output:
  html_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(codebook)
```


```{r final.df}

tryCatch({
  source('run_analysis.R')
  new.codebook <- codebook(final.df)
  print('Successfully Created codebook')
  new.codebook
}, error = function(e){
  print(e)
})

```

