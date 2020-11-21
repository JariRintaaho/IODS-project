## Data wrangling task for the week 5

# Loading the data

url="http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt"

human=read.csv(url, sep=",")

# The data set is related to HDI index and GNI of various countries.
# The data set has 195 rows and 19 columns.

# The summary of the data set

#summary(human)

#HDI.Rank        Country               HDI            Life.Exp    
#Min.   :  1.00   Length:195         Min.   :0.3480   Min.   :49.00  
#1st Qu.: 47.75   Class :character   1st Qu.:0.5770   1st Qu.:65.75  
#Median : 94.00   Mode  :character   Median :0.7210   Median :73.10  
#Mean   : 94.31                      Mean   :0.6918   Mean   :71.07  
#3rd Qu.:141.25                      3rd Qu.:0.8000   3rd Qu.:76.80  
#Max.   :188.00                      Max.   :0.9440   Max.   :84.00  
#NA's   :7                                                           

#    Edu.Exp         Edu.Mean          GNI            GNI.Minus.Rank    
# Min.   : 4.10   Min.   : 1.400   Length:195         Min.   :-84.0000  
# 1st Qu.:11.10   1st Qu.: 5.550   Class :character   1st Qu.: -9.0000  
# Median :13.10   Median : 8.400   Mode  :character   Median :  1.5000  
# Mean   :12.86   Mean   : 8.079                      Mean   :  0.1862  
# 3rd Qu.:14.90   3rd Qu.:10.600                      3rd Qu.: 11.0000  
# Max.   :20.20   Max.   :13.100                      Max.   : 47.0000  
#                                                     NA's   :7         

#GII.Rank           GII            Mat.Mor         Ado.Birth     
#Min.   :  1.00   Min.   :0.0160   Min.   :   1.0   Min.   :  0.60  
#1st Qu.: 47.75   1st Qu.:0.2030   1st Qu.:  16.0   1st Qu.: 15.45  
#Median : 94.00   Median :0.3935   Median :  69.0   Median : 40.95  
#Mean   : 94.31   Mean   :0.3695   Mean   : 163.2   Mean   : 49.55  
#3rd Qu.:141.25   3rd Qu.:0.5272   3rd Qu.: 230.0   3rd Qu.: 71.78  
#Max.   :188.00   Max.   :0.7440   Max.   :1100.0   Max.   :204.80  
#NA's   :7        NA's   :33       NA's   :10       NA's   :5       

#Parli.F          Edu2.F          Edu2.M           Labo.F     
#Min.   : 0.00   Min.   :  0.9   Min.   :  3.20   Min.   :13.50  
#1st Qu.:12.47   1st Qu.: 27.8   1st Qu.: 38.30   1st Qu.:44.50  
#Median :19.50   Median : 55.7   Median : 60.00   Median :53.30  
#Mean   :20.60   Mean   : 54.8   Mean   : 60.29   Mean   :52.61  
#3rd Qu.:27.02   3rd Qu.: 81.8   3rd Qu.: 85.80   3rd Qu.:62.62  
#Max.   :57.50   Max.   :100.0   Max.   :100.00   Max.   :88.10  
#NA's   :3       NA's   :26      NA's   :26       NA's   :11   

#Labo.M         Edu2.FM          Labo.FM      
#Min.   :44.20   Min.   :0.1717   Min.   :0.1857  
#1st Qu.:68.88   1st Qu.:0.7284   1st Qu.:0.5987  
#Median :75.55   Median :0.9349   Median :0.7514  
#Mean   :74.74   Mean   :0.8541   Mean   :0.7038  
#3rd Qu.:80.15   3rd Qu.:0.9968   3rd Qu.:0.8513  
#Max.   :95.50   Max.   :1.4967   Max.   :1.0380  
#NA's   :11      NA's   :26       NA's   :11   

## Task 1

#this mutates the GNI variable from string to numeric.

library(tidyr)
library(stringr)
human$GNI=str_replace(human$GNI, pattern=",", replace =".") %>% as.numeric

#summary(human$GNI)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1.096   4.689  12.040  39.748  24.512 908.000 

## Task 2
library(dplyr)

# This removes all the columns except those mentioned in keep_cols

keep_cols=c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human = select(human, one_of(keep_cols))

## Task 3

# this filters out all rows with NA values
human_ = filter(human, complete.cases(human))


## Task 4

# last 7 rows in the data set are related to continets etc. Let's remove them

last = nrow(human_) - 7
human_ = human_[1:last, ]


## Task 5

rownames(human_) <- human_$Country

human_ = select(human_, -Country)

write.csv(human_, "human.csv")





