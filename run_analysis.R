
data_col_names <- read.table('features.txt')
activity_lookup <- read.table('activity_labels.txt')

subj_test <- read.table('test/subject_test.txt')
x_test <- read.table('test/X_test.txt')
names(x_test) <- data_col_names[, 2]
y_test <- read.table('test/Y_test.txt')
y_test <- join(y_test, activity_lookup, by = 'V1', match = 'first')
test_data <- cbind(subject = subj_test[, 1], activity = y_test[, 2], x_test)

subj_train <- read.table('train/subject_train.txt')
x_train <- read.table('train/X_train.txt')
names(x_train) <- data_col_names[, 2]
y_train <- read.table('train/Y_train.txt')
y_train <- join(y_train, activity_lookup, by = 'V1', match = 'first')
train_data <- cbind(subject = subj_train[, 1], activity = y_train[, 2], x_train)

combined_data <- rbind(test_data, train_data)
combined_data_extract <- combined_data[, c(1, 2, grep('[Mm]ean|std', names(combined_data)))]

combined_data_extract_tidy <- ddply(combined_data_extract, c(.(subject), .(activity)), function(x) colMeans(x[, 3:ncol(x)]))

write.table(combined_data_extract_tidy)