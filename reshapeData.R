# This reads a tab-delimited file spit out by the Statistics Extraction tool from Net Station.
# In the raw file, the first 6 rows and the rows below the condition names contain metadata 
# such as montage, time window, 
# You'd be wise in opening this raw file first before running this script.
# Triple hashes mean change something on that line!

# install.packages("reshape") ### Un-comment in if you don't have the reshape package.

extract <- read.delim("statsExtract/example-net-station-statistics-extraction-file.xls", ### Read table extracted from Net Station
                      skip=6, # Skip metadata that spans 6 rows; adjust if different
                      header=T, row.names=NULL)
table <- extract[-c(1),] #Drop first row containing montage metadata

table$X <- substr(table$X, # Get subject/session IDs from column named "X" 
                  15,19) ### May ignore this command if subject IDs ok or change start-end index numbers to extract different substring
table$X = table$X # Reassign the rightly-named column
colnames(table)[which(names(table)=="X")] <- "Subject" # Rename column X as "Subject"

View(table) # Check if all observations are there

require(reshape)
melted <- melt(table,
               id=c("Subject")) # Melt the table df so that all DVs are in column, 
                                # condition names in another column. Subject is identifier.

# Now let's mess with the strings of the condition name columns
melted$ConditionsSpaced <- gsub('([[:upper:]])', ' \\1', melted$variable) #Separate with spaces until you hit capital letters
melted$splat <- strsplit(melted$ConditionsSpaced, split=" ") #Split the string by spaces. Splat is past tense for split, duh.
                                                            # This makes it a weird list with the conditions in one cell though.
mat <- matrix(unlist(melted$splat), ncol=3, byrow=T) # Turn the splat list into a matrix with 3 columns
mat <- mat[,-1] # Drop empty first column that was occupied by a space " " when it was assigned to "splat" above
df <- as.data.frame(mat) # Turn the matrix into an actionable dataframe
melted <- cbind(df, melted) # Combine the actionable dataframe with the original melted table
                            # You will have two columns named V1 and V2 since R doesn't know what to call them


View(melted) # Check that ConditionsSpaced matches up with the two factors it was made from
melted <- subset(melted, select=-c(variable, ConditionsSpaced, splat)) # Then drop unnecessary columns

# Rename your factors as your actual conditions or something generic
# Check your dataframe first to be sure you're renaming columns right
names(melted)[names(melted)=="V1"] = "cond1" ### Change condition name
names(melted)[names(melted)=="V2"] = "cond2" ### Change condition name

rm(df, extract, mat) # Clean yo mess up
# You should now have two dataframes: table which is unfactorized, melted which is factorized
# You will use melted for the statistics in tests.R and making bar graphs. table is 
# left there in case you want to do something else with it or write it as a csv.