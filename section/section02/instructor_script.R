# InClassExercise1Rscript.R

#1.  Download and read in the salary.txt dataset 
#from the "files" folder within the course canvas page, 
#using a function from the command line; call this data object salary.
#Also using a function from the command line, read in the salary.txt 
#dataset which is available on the web at:
#http://faculty.washington.edu/tathornt/Biost509/DataSets/salary.txt 
#call this data object othersalary. 
#Verify that salary and othersalary are the same 
#using the identical() function. 
myfile<-file.choose()
salary<-read.table(myfile,header=TRUE)
othersalary<-read.table(
    "http://faculty.washington.edu/tathornt/Biost509/DataSets/salary.txt",
    header=T)
identical(salary,othersalary) # TRUE

# Note that salary is an object that has 11 variables
# one of the variables of the salary object is also called salary
# So, below, when you see salary, that is the object salary.
# And, when you see salary$salary, that is the variable salary

#Answer the following questions using the salary dataset. 
#Note, when I use "entries", I mean all the 19792 rows. 
#When I use people or "id", I mean the 1597 unique "id"s.

# 2. In class today, we saw that 4 entries had missing salary variables.
#Using is.na() and other commands, determine which number rows have
#these missing values.


missing<-is.na(salary$salary)
salary[!missing,]



salary[is.na(salary$salary),] #4, 44, 444, 4444
# or
rownames(salary[is.na(salary$salary),])
which(is.na(salary$salary))
# note the following doesn't work (see lecture 2, slide 2.16)


test<-salary[salary$salary==NA,]
dim(test) # test has dimensions 19792 by 11
# salary$salary==NA returns 19792 NAs, 
# so salary[salary$salary==NA,] is a 19792 by 11 data frame of NAs
# you can see the first few entries by 
head(test)

# 3. Create a dataset with the 4 entries (rows) with missing salary data excluded, and rename the data object salary.


salary<-subset(salary,!is.na(salary))

# or

salary<-othersalary[-c(4,44,444,4444),]
dim(salary) # 19788 by 11, so yes 4 rows were deleted
# or
salary<-othersalary[!is.na(othersalary$salary),]
dim(salary) # 19788 by 11, so yes 4 rows were deleted


#For the remaining questions, use the dataset without 
#the 4 rows containing NAs for the salary variable.
#(19788 rows, 1596 unique ids).

#4.	What is the mean salary of the entries? 

mean(salary$salary) # $4721.7 

#What proportion of the entries have a greater "salary" than 
#the mean "salary"?

mean(salary$salary> mean(salary$salary)) # 0.425 (or 42.5%)

sum(salary$salary> mean(salary$salary))/length(salary$salary)

# note salary$salary> mean(salary$salary) is a vector of 1 and 0's
# 1 if the salary is > mean, 0 otherwise
# the mean of a bunch of 1's and 0's is the proportion of 1's

# or 
gtmeansalary<-salary[salary$salary>mean(salary$salary),]
# above is subset of salary data set such that the variable salary
# is greater than the mean salary
# below is number of entries in gtmeansalary divided by number of
# entries in salary
length(gtmeansalary$salary)/length(salary$salary) # 0.425

#5.	What is the earliest "startyr"? Which "id" started this year?

min(salary$startyr) #48
salary$id[which.min(salary$startyr)] # 1535



#6.	Which "rank" has the largest average "salary"
#(averaged over all entries)? 
#Which "rank" has the lowest average "salary"? 
#What is the difference between these average salaries?

assistsal<-salary[salary$rank=="Assist" & !is.na(salary$rank),]

## Can also use the subet() function

assistsal<-subset(salary,rank=="Assist" & !is.na(salary$rank))

assocsal<-salary[salary$rank=="Assoc" & !is.na(salary$rank),]
fullsal<-salary[salary$rank=="Full" & !is.na(salary$rank),]
mean(assistsal$salary)
mean(assocsal$salary)
mean(fullsal$salary)
# can see that assist salary is smallest and full salary is largest
mean(fullsal$salary,na.rm=T)-mean(assistsal$salary,na.rm=T) 
  # difference in largest and lowest average salaries = 2447.6
# Note: & !is.na(salary$rank) is needed because there are missing RANKS

