# Preprocessing of data

puts('# of columns in dataset: ', ncol(samsungData))
print('Classes: ')
print(unique(samsungData$activity)
class_proportions <- with(samsungData,
                    sapply(unique(activity), 
                    function(x) sum(x == activity) / length(activity))
                    )
print("Class proportions (full dataset)")
print(class_proportions)

puts("# Missing activity values: ", sum(is.na(samsungData$activity)))

# Subset train data
train_data <- subset(samsungData, subject %in% c(1,3,5,6))
puts('# instances in train set: ', nrow(train_data))
train_class_proportions <- with(train_data,
                            sapply(unique(activity),
                            function(x) sum(x==activity) / length(activity))
                            )
print("Class proportions (training set)")
print(train_class_proportions)

# Subset test data
test_data <- subset(samsungData, subject %in% c(27,28,29,30))
puts('# instances in test set: ', nrow(test_data))
test_class_proportions <- with(test_data,
                            sapply(unique(activity),
                            function(x) sum(x==activity) / length(activity))
                            )
print("Class proportions (test set)")
print(test_class_proportions)