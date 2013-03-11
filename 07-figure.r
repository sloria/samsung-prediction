require(ggplot2)
require(reshape)

# Compute the first 2 principal components for plotting purposes
pca <- princomp(scale(test_data[, -ncol(test_data)]))

plot_df <- data.frame(
                        PC1=predict(pca)[,1],
                        PC2=predict(pca)[,2],
                        Target=test_labels,
                        SVM=predict(svm_tuned_fit, test_data),
                        SVM_SVD50=predict(svm_svd50_tuned_fit, reduced_test_data50)
                    )

# Melt df so it's easier to plot
predictions <- melt(plot_df, id.vars=c('PC1', 'PC2'))

# Change "SVM_SVD50" to "SVM + SVD" for the plot
levels(predictions$variable)[levels(predictions$variable)=='SVM_SVD50'] <- "SVM+SVD"

# Plot comparison of predictions vs. the targets
comparison_plot <- ggplot(predictions, aes(x=PC1, y=PC2, color=factor(value))) + 
                            geom_point(alpha=0.9, position='jitter') +
                            facet_grid(variable ~ .) +
                            scale_color_brewer(name="Activity", palette="Set3") +
                            theme_bw()

ggsave(file.path('figures', 'comparison.pdf'), plot=comparison_plot,
        height=5, width=8)