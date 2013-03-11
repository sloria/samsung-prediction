# Print data characteristics and split data into train, validation, and test sets

puts('# of columns in dataset: ', ncol(samsungData))
print("Data types: ")
print(table(sapply(samsungData[,], class)))
# print("Missing values?")
# print(table(sapply(samsungData[,], is.na)))
#  FALSE 
# 4139176 
print("# subjects: ")
print(length(unique(samsungData$subject)))
# 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30
print('Activities: ')
print(unique(samsungData$activity))
# "standing" "sitting"  "laying"   "walk"     "walkdown" "walkup"  
class_proportions <- with(samsungData,
                    sapply(unique(activity), 
                    function(x) sum(x == activity) / length(activity))
                    )
print("Class proportions (full dataset)")
print(class_proportions)

# Subset train data
train_data <- subset(samsungData, subject %in% c(1,3,5,6), select= -subject)
puts('# instances in train set: ', nrow(train_data))
train_class_proportions <- with(train_data,
                            sapply(unique(activity),
                                    function(x) round(sum(x==activity) / length(activity), 2)
                                  )
                            )
print("Class proportions (training set)")
print(train_class_proportions)
print("")

validation_data <- subset(samsungData, subject %in% c(7,8,11,14), select= -subject)
puts('# instances in validation set: ', nrow(validation_data))
validation_class_proportions <- with(validation_data,
                            sapply(unique(activity),
                                    function(x) round(sum(x==activity) / length(activity), 2)
                                  )
                            )
print("Class proportions (validation set)")
print(validation_class_proportions)
print("")

# Subset test data
test_data <- subset(samsungData, subject %in% c(27,28,29,30), select= -subject)
puts('# instances in test set: ', nrow(test_data))
test_class_proportions <- with(test_data,
                            sapply(unique(activity),
                                    function(x) round(sum(x==activity) / length(activity), 2)
                                  )
                            )
print("Class proportions (test set)")
print(test_class_proportions)
print("")

# The target labels
train_labels <- train_data[, ncol(train_data)]
validation_labels <- validation_data[, ncol(validation_data)]
test_labels <- test_data[, ncol(train_data)]

rm(samsungData)