require(e1071)
require(ggplot2)
require(reshape)

# Order classifiers by accuracy
accuracies <- accuracies[order(-accuracies$CV),]
print(accuracies)
# So far, the radial SVM with dimension reduction has the best accuracy

# Confusion matrix for the radial svm with dim reduction
confusion_matrix <- table(test_labels, predict(radial_svm_svd75_tuned_fit, reduced_test_data75))
print('Confusion matrix: ')
print(confusion_matrix)

# Compute the first 2 principal components for plotting purposes
pca <- princomp(scale(test_data[, 1:562]))

plot_df <- data.frame(
                        PC1=predict(pca)[,1],
                        PC2=predict(pca)[,2],
                        Target=test_labels,
                        SVM=predict(radial_svm_tuned_fit, test_data),
                        SVM_SVD=predict(radial_svm_svd75_tuned_fit, reduced_test_data75)
                    )

predictions <- melt(plot_df, id.vars=c('PC1', 'PC2'))

levels(predictions$variable)[levels(predictions$variable)=='SVM_SVD'] <- "SVM + SVD"


comparison_plot <- ggplot(predictions, aes(x=PC1, y=PC2, color=factor(value))) + 
                            geom_point(alpha=0.9) +
                            facet_grid(variable ~ .) +
                            scale_color_brewer(name="Activity", palette="Set3") +
                            theme_bw()

ggsave(file.path('figures', 'comparison.pdf'), plot=comparison_plot,
        height=5, width=8)
