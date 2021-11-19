# --- R Exercises BIOS-IN5410, Fri Nov 11th, 2021 ---
# https://github.com/jonbra/BIOS-IN5410_H2021/tree/main/exercises

library(tidyverse)

### Exercise 1a
n_1a = 100
sum_1_100 = 0

for (i in range(1,n_1a,1)){
  sum_1_100 = sum_1_100 + (i*(i+1)/2)
}
cat("The sum of the first 100 positive integers is", sum_1_100, ".")

### Exercise 1b
n_1b = 1000
sum_1_1000 = 0

for (i in range(1,n_1b,1)){
  sum_1_1000 = sum_1_1000 + (i*(i+1)/2)
}
cat("The sum of the first 100 positive integers is", sum_1_1000, ".")

### Exercise 1c
# seq(a,b) creates a vector with all numbers from and including a, to and 
# including b, by steps of 1. sum() adds together all the elements of a 
# vector. 

# The better solution for exercises 1a,b would have been:
# n = 100
# x = seq(1:n)
# print(sum(x))



### Exercise 2a
# The forked Github repo has been cloned to a local R project in advance

files = list.files("C:/Users/larsj/R/BIOS-IN5410_H2021/data", full.names = T)
length(files)

### Exercise 2b,c
file1 = read.csv(files[1])
file2 = read.csv(files[2], header=F)
file3 = read.delim(files[3], header=T, sep=";")

cat("Columns:",ncol(file1),"Rows:",nrow(file1))
cat("Columns:",ncol(file2),"Rows:",nrow(file2))



### Exercise 3a
file1 %>% select(Gene)
file1 %>% select(Gene,length)

# Different ways of selecting the length column
file1 %>% select(starts_with("l"))
file1 %>% select(contains("l"))
file1[,3]
select(file1,length)

# Showing columns in reverse order
file1 %>% select(ncol(file1):1)

# Arranging column by counting order
file1 %>% select(length) %>% arrange(desc(length))

# Selecting by dropping columns
file1 %>% select(-Gene, -count)

### Exercise 3b
# Showing only the row containing information about gene A
file1[1,]
file1 %>% filter(Gene=="A")

# Selecting genes longer than 200
file1 %>% filter(length > 200) %>% select(Gene)

# Showing all genes except gene A
file1 %>% filter(Gene!="A")

### Exercise 3c
# Showing only Gene and count columns for genes with count >= 50
file1 %>% filter(count>=50) %>% select(Gene,count)

### Exercise 3d
# Adding column long_genes which returns TRUE for genes longer than 200
file1 = file1 %>% mutate(long_genes = length > 200)
file1
# Or mutate(file1, long_genes = length > 200)

# Grouping by long_genes and showing avg. length in each group
file1 %>% group_by(long_genes) %>% summarize(mean(length))



### Exercise 4
# Creating scatterplot showing gene length/count relationship
a = ggplot(file1, aes(length,count,colour=Gene)) + geom_point() + theme_light() + 
  ggtitle("Gene length vs. count in file1") + geom_text(label=file1$Gene, 
  nudge_x = 50, check_overlap = T) + scale_x_continuous(breaks=seq(0,1300,by=50)) +
  scale_y_continuous(breaks=seq(0,260,by=10))
a

# Our data are categorical, so we can't use a histogram. A bar chart will resemble a histogram
# (I might have understood what the purpose is)
b = ggplot(file1,aes(Gene,count)) + geom_col() + theme_light
b

# Histogram
hist(file1$count,breaks=5)



### Exercise 5a
for (i in 1:7){
  print(i^2)
}

### Exercise 5b
# Printing column names with a for loop
for (name in names(file1)){
  print(name)
}

# Printing column name lengths with a for loop
for (name in names(file1)){
  print(nchar(name))
}

# Combining the above two outputs
for (name in names(file1)){
  print(paste0(name, ": ",nchar(name)))
}

# Storing outputs to a vector
column_names = character()
for (name in names(file1)){
  x = paste0(name, ": ",nchar(name))
  column_names = c(column_names,x)
}



### Exercise 6
# Printing a statement about the genes' length
for (i in 1:nrow(file1)){
  if(file1$length[i] >= 200){
    y = " "
  }
  else{
    y = " _NOT_ "
  }
  print(paste0("Gene ", file1$Gene[i], " is", y, "200 bp or longer."))
}

# Printing a statement about the genes' length (solving the exercise better)
for (i in 1:nrow(file1)){
  if(file1$length[i]>200){
    print(paste0("Gene ", file1$Gene[i], " is longer than 200."))
  }
  else if(file1$length[i]<200){
    print(paste0("Gene ", file1$Gene[i], " is shorter than 200."))
  }
  else if(file1$length[i]==200){
    print(paste0("Gene ", file1$Gene[i], " has length 200."))
  }
}



### Exercise 7

