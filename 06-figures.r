require(ggplot2)

# Compute the first 2 principal components for plotting purposes
pca <- princomp(scale(test_data[, 1:562]))

plot_df <- data.frame(
                        PC1=predict(pca)[,1],
                        PC2=predict(pca)[,2],
                        activity=test_labels,
                        RadialSVM=predict(radial_svm_fit, test_data),
                        RadialSVM_withSVD=predict(radial_svm_svd75_fit, reduced_test_data75)
                    )

predictions <- melt(plot_df, id.vars=c('PC1', 'PC2'))

comparison_plot <- ggplot(predictions, aes(x=PC1, y=PC2, color=factor(value))) + 
                            geom_point() + 
                            facet_grid(variable ~ .)

ggsave(file.path('figures', 'comparison.pdf'), plot=comparison_plot,
        height=4, width=7)
