# Unit testing

require(testthat)

source('main.r')

# training set should include only subjects 1, 3, 5, and 6
expect_that(unique(train_data$subject), equals(c(1,3,5,6)))

expect_that(unique(test_data$subject), equals(c(27,28,29,30)))

