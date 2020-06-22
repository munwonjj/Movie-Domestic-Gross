#Import the Data

mov <- read.csv("Section6-Homework-Data.csv", stringsAsFactors = T)

#Data Exploration
head(mov) #top rows
summary(mov) #column summaries
str(mov) #structure of the dataset


#Activate GGPlot2
#install.packages("ggplot2")
library(ggplot2)


ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()
#Notice? No movies are released on a Monday. Ever.

#Now we need to filter our dataset to leave onlly the 
#Genres and Studios that we are interested in
#We will start with the Genre filter and use the Logical 'OR'
#operator to select multiple Genres:
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#Now let's do the same for the Studio filter:
filt2 = mov$Studio %in% c("Buena Vista Studios", "WB", "Fox", "Universal", "Sony", "Paramount Pictures")
#filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio == "WB") | (mov$Studio == "Fox") | (mov$Studio == "Universal") | (mov$Studio == "Sony") | (mov$Studio == "Paramount Pictures")

filt
filt2  
#Apply the row filters to the dataframe
mov2 <- mov[filt & filt2,]
mov2


#Use str() or summary() to fin out the correct column names
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p #Nothing happens. We need a geom.

#Add a Point Geom Layer
p + 
  geom_point(aes(size=Budget...mill.))
#Notice that outliers are part of the boxplot layer

q = p + 
  geom_jitter(aes(size=Budget...mill., color = Studio)) +
  geom_boxplot(alpha=0.7, outlier.color = NA)
q

#Non-data ink
q <- q +
  xlab("Genre") + #x axis title
  ylab("Gross % US") + #y axis title
  ggtitle("Domestic Gross % by Genre") #plot title
q

#changing theme
q = q +
  theme(
    axis.title.x = element_text(color="Blue", size=30),
    axis.title.y = element_text(color="Blue", size=30),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),
    
    plot.title = element_text(size=30, hjust=0.5),
    
    legend.title = element_text(size=20),
    legend.text = element_text(size=20),
    
    text = element_text(family="Comic Sans MS")
  )
q

#refresh which parameters are responsible for what

#Final touch. We haven't discussed this in the course,
#However this is how you can change individual legend titles:
q$labels$size = "Budget $M"
q

