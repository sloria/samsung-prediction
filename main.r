# Runs the entire project
rm(list=ls()) # Clear workspace
source('00-functions.r')
source('01-load.r')
source('02-split_data.r')
source('03-knn.r')
source('04-svm.r')
source('05-dim_reduction.r')
source('06-results.r')
source('07-figure.r')