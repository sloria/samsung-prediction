# Read data

# All of the columns of the data set (except the last two) represents 
# one measurement from the Samsung phone. The variable subject indicates 
# which subject was performing the tasks when the measurements were taken. 
# The variable activity tells what activity they were performing. 
load(file.path('data', 'samsung.rda'))

puts('# of columns in dataset: ', ncol(samsungData))

train_data <- subset(samsungData, subject %in% c(1,3,5,6))
puts('# instances in train data: ', nrow(train_data))

test_data <- subset(samsungData, subject %in% c(27,28,29,30))
puts('# instances in test data: ', nrow(test_data))