#Jari Rinta-aho
#02.11.2020
#This is a description

url="http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt"

data=read.csv(url,sep="\t")

gender = data$gender
age = data$Age
attitude = data$Attitude
deep = data$D03+data$D11+data$D19+data$D27+data$D07+data$D14+data$D22+data$D30+data$D06+data$D15+data$D23+data$D31
stra=data$ST01+data$ST09+data$ST17+data$ST25+data$ST04+data$ST12+data$ST20+data$ST28
surf =data$SU02+data$SU10+data$SU18+data$SU26+data$SU05+data$SU13+data$SU21+data$SU29+data$SU08+data$SU16+data$SU24+data$SU32
points = data$Points

analysis = data.frame(gender=gender, age=age, attitude=attitude, deep=deep, stra=stra, surf=surf, points=points)
analysis=analysis[analysis$points != 0,]

write.csv(analysis,file="learning2014.csv",row.names = FALSE)

read_test=read.csv("learning2014.csv")

str(read_test)