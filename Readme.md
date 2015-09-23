# ERP Statistics on R
Because I don't want to use proprietary software to analyze my data

---

**Purpose:** Perform statistical analyses and produce bar graphs depicting the ERP dependent measure after visualizing ERP waveforms (see [https://github.com/tanyaberde/net-station-plots](https://github.com/tanyaberde/net-station-plots)). 

**Input:** Tab-delimited text/xls file exported from Net Station 5 using its Statistic Extraction Tool

**Output:**   
1) .csv file containing statistical results  
2) .png image of bar graph depicting dependent measure (usually mean amplitude)

---

## To do
1. Open `erp statistics.Rproj` on RStudio
2. Source/Run the three R scripts in the sequence defined below

## Script sequence
1. reshapeData.R
2. tests.R
3. barGraphs.R


## Good to know
1. Lines with three pound signs `###` indicate input fields
2. In the example, the input text file is a printout of Net Station 5's Statistical Extraction tool. The first 6 rows contain metadata. Each cell is a mean amplitude spanning a time window and electrode montage specified in Net Station, for 11 participants (rows) at 4 conditions (columns) from 2 x 2 factorial design, cond1 x cond2).
3. Will add planned pairwise contrasts (t-tests) to tests.R! Right now it can only do ANOVAs.


