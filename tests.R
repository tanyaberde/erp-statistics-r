# Statistics for ___ project
# Factors: ____ x ____
# Equivalent to segmentation to <stim>, according to <segmentation tool>

# install.packages("ez") # Un-comment back in if you don't have these packages.

# GribbleLab tutorial note: To adhere to the sum-to-zero convention 
# for effect weights, you should always do this before running anovas in R.
# This ensures your output matches what SPSS would spit out.
# Thanks to this blog post: 
# https://gribblelab.wordpress.com/2009/03/09/repeated-measures-anova-using-r/
options(contrasts=c("contr.sum","contr.poly"))

#Factorize first
melted$cond1 = factor(melted$cond1) ### Change condition name
melted$cond2 = factor(melted$cond2) ### Change condition name
melted$Subject = factor(melted$Subject)
melted$value = as.numeric(as.character(melted$value))

# # Un-comment lines 23-28 below if you want to use R's native anova method. 
# # You have to put in the actual condition names instead of 'cond1' and 'cond2'.
# # Traditional R ANOVA
# anova<-aov(value~(cond1*cond2)+Error(Subject/cond1)+cond2, data=melted) ## DV ~ IV or IV*IV2
# summary(anova)
# model.tables(anova)

# Check number of subjs/cells per condition
table(melted$cond1, melted$cond2) ### Change condition names

# cond1 = "Expect"
# cond2 = "Valence"

# Do ANOVA using ez package
require(ez)
ez.ANOVA <- ezANOVA(data=melted, dv=.(value), 
                    wid=.(Subject), 
                    within=.(cond1, cond2), ### Change condition names
                    detailed=T) 

print(ez.ANOVA)
e <- as.data.frame(ez.ANOVA) # Turns results into a table
write.csv(e,            # Exports e table as csv
          file="anova-out.csv") ### Change filename as desired