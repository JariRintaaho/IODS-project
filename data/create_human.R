## Data wrangling task for the week 4
library(dplyr)

## Task 2

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Meta file for these data sets can be seen here
# http://hdr.undp.org/en/content/human-development-index-hdi
#
# Here is some technical notes
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

## Task 3

print(summary(hd))
print(str(hd))

# hd data set seems to have 195 rows and 8 variables
# the data is somehow related to HDI indeces of different countries

print(summary(gii))
print(str(gii))

# gii data set seems to have 195 rows and 10 variables
# the data is somehow related to equality and economics of different countries

## Task 4
new_vars_hdi=c("HDI_Rank", "Country", "HDI", "LifeExpect", 
               "EduExpect", "MeanEdu", "GNI_capita",
               "GNI_HDI_diff")
colnames(hd)=new_vars_hdi

new_vars_gii=c("GII_Rank", "Country", "GII", "MaternMort", 
               "AdolBirth", "ParlRep", "EduFem",
               "EduMale", "LabourFem", "LabourMale")
colnames(gii)=new_vars_gii

## Task 5

gii$EduFM_ratio=gii$EduFem/gii$EduMale
gii$LabourFM_ratio=gii$LabourFem/gii$LabourMale

## Task 6

human = hd %>% inner_join(gii,by="Country")

write.csv(human, file="human.csv")
