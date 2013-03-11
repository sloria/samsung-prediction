# Samsung activity data analysis

My data analysis of the [Samsung dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for the [Data Analysis](https://www.coursera.org/course/dataanalysis) course taught by Jeff Leek on Coursera.

Here I attempt to use combine SVD for dimensionality reduction and SVM for classification in order to predict a user's activity (e.g. standing, sitting, walking) based on smartphone accelerometer and gyroscope data.

View my report [here](https://dl.dropbox.com/u/1693233/samsung-prediction-report.pdf).

To reproduce the exact analyses presented in the report, run  `source('00-download.r')` to get the dataset then `source('main.r')` from the R command line.

## Required packages
- reshape
- ggplot2


## License

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.