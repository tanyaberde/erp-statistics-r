####### Import and factorize all data textouts from xlsx
data<-melted # Read the data produced by reshapeData.R

View(data) # Make sure it's kosher

#Factorize first
data$cond1 = factor(data$cond1) ### Change condition name
data$cond2 = factor(data$cond2) ### Change condition name
data$Subject = factor(data$Subject)
data$value = as.numeric(as.character(data$value))

#Check number of subjs/cells per condition
table(data$cond1, data$cond2) ### Change condition names

# cond1 = "Expect" ### Assign your actual condition names
# cond2 = "Valence" ### Assign your actual condition names

# Load Rmisc package to run summarySE function. Used to be # source("summarySE.R")
require(Rmisc)
bar <- summarySE(data, measurevar="value", 
                 groupvars=c("cond1","cond2")) ### Change condition names

# Use grouping var as a factor rather than numeric
bar2 <- bar
bar2$cond1 <- factor(bar2$cond1)
bar2$cond2 <- factor(bar2$cond2)

# Bar graph, Prediction on x-axis, color fill grouped by Outcome -- use position_dodge()
# Error bars represent standard error of the mean
require(ggplot2)

graph <- ggplot(bar2, aes(x=cond1, y=value, fill=cond2)) + ### Condition names
  geom_bar(stat="identity", position=position_dodge())  + 
  geom_errorbar(aes(ymin=value-se, ymax=value+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9))

graph.clean <- graph +
  scale_fill_brewer(type="qual", palette=1) + #Neat auto colors 
  ggtitle("Your Graph Title") + ###
  ylab("Mean amplitude (µV)") + 
  xlab("Your x variable") + ###
  coord_fixed(ratio=1/.3) +
  #   scale_y_continuous(breaks=seq(-1.2,0,0.25), limits=c(-1.4,0)) + ### Constrain axis limits
  #   guides(fill=F)
  guides(fill=guide_legend(title="Your fill condition"))

print(graph)
print(graph.clean)

#! Save plots as images
ggsave("graph-clean.png", ### Image file title
       graph.clean, width=6, height=8)