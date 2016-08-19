Process:

The script run_analysis.R process the given data in the following manner:

1.The train data(x, y, subject) and test data(x, y, subject) are read from the corresponding files from the given extracted zip folder.
2. The train and test data are now merged to form x_data, y_data and subject_data using the rbind()
3. The required features(columns containing mean and std) are extracted using the grep() function from the features table.
4. The corresponding names are now given to the x_data
5. The activity labels are extract and given to the rows in y_data.
6. The complete data set is now formed by cbind() of x_data, y_data and subject_data
7. Appropriate column names are now assigned.
8. A subset of this data is taken to form the tidy data set consisting of the mean of activity for every subject using aggregate() and order() functions.
9. The data attained is written to a text file.
