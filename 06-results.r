require(e1071)

# Order classifiers by accuracy
accuracies <- accuracies[order(-accuracies$CV),]
print("Validation accuracies")
print(accuracies)
# So far, the radial SVM with dimension reduction has the best accuracy


n_dimensions <- 280 # reduce dimensions 50%
reduced_test_data50 <- reduce_dataset(test_data, n_dimensions)
reduced_test_data50_labels <- reduced_test_data50[, ncol(reduced_test_data50)]

n_dimensions <- 140 # reduce dimensions 50%
reduced_test_data75 <- reduce_dataset(test_data, n_dimensions)
reduced_test_data75_labels <- reduced_test_data75[, ncol(reduced_test_data75)]

print("Testing KNN")
knn_test_predictions <- knn(train_data[, -ncol(train_data)],
                            test_data[, -ncol(test_data)], 
                            train_labels, k=5)
print("Testing KNN+SVD (50%)")
knn_svd50_predictions <- knn(reduced_train_data50[,-ncol(reduced_train_data50)],
                            reduced_test_data50[,-ncol(reduced_test_data50)], 
                            train_labels, k=5)
print("Testing KNN+SVD (75%)")
knn_svd75_predictions <- knn(reduced_train_data75[,-ncol(reduced_train_data75)],
                            reduced_test_data75[,-ncol(reduced_test_data75)], 
                            train_labels, k=5)

test_accuracies <- data.frame(
                    Classifier=c("SVM", "SVM+SVD (50%)", "SVM+SVD (75%)", "kNN", "kNN+SVD (50%)", "kNN+SVD (75%)"),
                    TestAccuracy=c(
                                    cv_accuracy(svm_tuned_fit, test_data, test_labels),
                                    cv_accuracy(svm_svd50_tuned_fit, reduced_test_data50, reduced_test_data50_labels),
                                    cv_accuracy(svm_svd75_tuned_fit, reduced_test_data75, reduced_test_data75_labels),
                                    mean(knn_test_predictions == test_labels),
                                    mean(knn_svd50_predictions == reduced_test_data50_labels),
                                    mean(knn_svd75_predictions == reduced_test_data75_labels)
                                  )
                    )

print("Test accuracies")
print(test_accuracies)

# Confusion matrix for the radial svm with dim reduction
print('Confusion matrix for SVM: ')
confusion_matrix1 <- table(test_labels, predict(svm_tuned_fit, test_data))
print(confusion_matrix1)

# Confusion matrix for the radial svm with dim reduction
print('Confusion matrix for SVM+SVD: ')
confusion_matrix2 <- table(test_labels, predict(svm_svd50_tuned_fit, reduced_test_data50))
print(confusion_matrix2)
