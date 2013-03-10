set.seed(1)


# K nearest neighbors
#####################
require('class')
print('## KNN ##')
# training data without labels

print('Trying different values for k. . .')
# Try different values for k
knn_performance <- data.frame()
for (k in 5^(1:3)) {
  puts("Trying k = ", k)
  knn_predicted <- knn(train_data[, -ncol(train_data)],
                    test_data[, -ncol(test_data)], 
                    train_labels, k=k)
  accuracy <- mean(knn_predicted == test_labels)
  knn_performance <- rbind(knn_performance, data.frame(K=k, Accuracy=accuracy))
  puts('Accuracy: ', accuracy)
}

best_k <- with(knn_performance, min(K[which(Accuracy == max(Accuracy))]))
puts('Chose k = ', best_k)
best_knn_accuracy <- with(subset(knn_performance, K == best_k), Accuracy)

# Create a dataframe to store accuracies
accuracies <- data.frame(Classifier=c('kNN'), CV=c(best_knn_accuracy))


