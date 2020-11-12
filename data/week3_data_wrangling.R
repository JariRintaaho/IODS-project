## Week 3, Data wrangling

# Part 2
# Jari Rinta-aho
# Open data science, week 3: Data wrangling excercise

# Part 3
math=read.csv("student-mat.csv", sep=";")
por=read.csv("student-por.csv", sep=";")

# These two lines are commented just for keeping the console tidy
#print(summary(math))
#print(summary(por))

# Both of the data sets have the same 33 variables.

# Part 4
library(dplyr)

join_by=c("school", "sex", "age", "address", "famsize", 
          "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", 
          "reason", "nursery","internet")

math_por = inner_join(math, por, by = join_by, 
                      suffix=c(".math",".por"))

#print(summary(math_por))

# The inner_join function from dplyr library does the asked task 
# The new data set math_por has 382 rows and 53 new variables

# Part 5

alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
#glimpse(alc)

alc$alc_use=(alc$Dalc+alc$Walc)/2

alc$high_use=(alc$alc_use > 2)

write.csv(x=alc, file="alc.csv")


