## Data wrangling exercise for week 6

library(dplyr)
library(tidyr)


# Task 1

url1="https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt"

url2="https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt"

BPRS=read.csv(url1, sep=" ")
RATS=read.csv(url2, sep="\t")

print("BRRS summary")
#print(summary(BPRS))
#treatment      subject          week0           week1           week2          week3      
#Min.   :1.0   Min.   : 1.00   Min.   :24.00   Min.   :23.00   Min.   :26.0   Min.   :24.00  
#1st Qu.:1.0   1st Qu.: 5.75   1st Qu.:38.00   1st Qu.:35.00   1st Qu.:32.0   1st Qu.:29.75  
#Median :1.5   Median :10.50   Median :46.00   Median :41.00   Median :38.0   Median :36.50  
#Mean   :1.5   Mean   :10.50   Mean   :48.00   Mean   :46.33   Mean   :41.7   Mean   :39.15  
#3rd Qu.:2.0   3rd Qu.:15.25   3rd Qu.:58.25   3rd Qu.:54.25   3rd Qu.:49.0   3rd Qu.:44.50  
#Max.   :2.0   Max.   :20.00   Max.   :78.00   Max.   :95.00   Max.   :75.0   Max.   :76.00  
#week4           week5           week6           week7          week8      
#Min.   :20.00   Min.   :20.00   Min.   :19.00   Min.   :18.0   Min.   :20.00  
#1st Qu.:28.00   1st Qu.:26.00   1st Qu.:22.75   1st Qu.:23.0   1st Qu.:22.75  
#Median :34.50   Median :30.50   Median :28.50   Median :30.0   Median :28.00  
#Mean   :36.35   Mean   :32.55   Mean   :31.23   Mean   :32.2   Mean   :31.43  
#3rd Qu.:43.00   3rd Qu.:38.00   3rd Qu.:37.00   3rd Qu.:38.0   3rd Qu.:35.25  
#Max.   :66.00   Max.   :64.00   Max.   :64.00   Max.   :62.0   Max.   :75.00  

print("RATS summary")

#print(summary(RATS))
#ID            Group           WD1             WD8             WD15            WD22      
#Min.   : 1.00   Min.   :1.00   Min.   :225.0   Min.   :230.0   Min.   :230.0   Min.   :232.0  
#1st Qu.: 4.75   1st Qu.:1.00   1st Qu.:252.5   1st Qu.:255.0   1st Qu.:255.0   1st Qu.:267.2  
#Median : 8.50   Median :1.50   Median :340.0   Median :345.0   Median :347.5   Median :351.5  
#Mean   : 8.50   Mean   :1.75   Mean   :365.9   Mean   :369.1   Mean   :372.5   Mean   :379.2  
#3rd Qu.:12.25   3rd Qu.:2.25   3rd Qu.:480.0   3rd Qu.:476.2   3rd Qu.:486.2   3rd Qu.:492.5  
#Max.   :16.00   Max.   :3.00   Max.   :555.0   Max.   :560.0   Max.   :565.0   Max.   :580.0  
#WD29            WD36            WD43            WD44            WD50            WD57      
#Min.   :240.0   Min.   :240.0   Min.   :243.0   Min.   :244.0   Min.   :238.0   Min.   :247.0  
#1st Qu.:268.8   1st Qu.:267.2   1st Qu.:269.2   1st Qu.:270.0   1st Qu.:273.8   1st Qu.:273.8  
#Median :356.5   Median :360.0   Median :360.0   Median :362.0   Median :370.0   Median :373.5  
#Mean   :383.9   Mean   :387.0   Mean   :386.0   Mean   :388.3   Mean   :394.6   Mean   :398.6  
#3rd Qu.:497.8   3rd Qu.:504.2   3rd Qu.:501.0   3rd Qu.:510.5   3rd Qu.:516.0   3rd Qu.:524.5  
#Max.   :590.0   Max.   :597.0   Max.   :595.0   Max.   :595.0   Max.   :612.0   Max.   :618.0  
#WD64      
#Min.   :245.0  
#1st Qu.:278.0  
#Median :378.0  
#Mean   :404.1  
#3rd Qu.:530.8  
#Max.   :628.0  

# both files clearly contains some time series. BPRS has 40 samples with 9 data points 
#(and two point identification). RATS have 16 samples with 10 data points 
#(and two points for identification)


## Task 2

# Let's hope that the cathegorical datas are RATS$Group RATS$ID and BPRS$subject 
#and BPRS$treatment

RATS$ID=as.factor(RATS$ID)
RATS$Group=as.factor(RATS$Group)

BPRS$treatment=factor(BPRS$treatment)
BPRS$subject = factor(BPRS$subject)


#str(RATS)
#str(BPRS)

## Task 3

BPRSL = BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL = BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

## Task 4

print("RATSL")
print(str(RATSL))

#'data.frame':	176 obs. of  5 variables:
#  $ ID    : Factor w/ 16 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
#$ Group : Factor w/ 3 levels "1","2","3": 1 1 1 1 1 1 1 1 2 2 ...
#$ WD    : chr  "WD1" "WD1" "WD1" "WD1" ...
#$ Weight: int  240 225 245 260 255 260 275 245 410 405 ...
#$ Time  : int  1 1 1 1 1 1 1 1 1 1 ...

print("BPRSL")
print(str(BPRSL))

#'data.frame':	360 obs. of  5 variables:
#  $ treatment: Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
#$ subject  : Factor w/ 20 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
#$ weeks    : chr  "week0" "week0" "week0" "week0" ...
#$ bprs     : int  42 58 54 55 72 48 71 30 41 57 ...
#$ week     : int  0 0 0 0 0 0 0 0 0 0 ...

# In long format, the number of variables is dramatically dropped and number of rows 
# is significatly larger. This makes easier to make (y ~ x1 + x2 + ... x3) -type 
# syntaxes for R inbuild model fitting algorithms.

write.csv(BPRSL, file="BPRSL.csv")
write.csv(RATSL, file="RATSL.csv")

