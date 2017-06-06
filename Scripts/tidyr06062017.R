download.file(url = c("http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=xlsx", 
                      "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx"), 
              destfile = c("Data/indicator undata total_fertility.xlsx", 
                           "Data/indicator gapminder infant_mortality.xlsx"))

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")
library("tidyverse")

library("readxl")
raw_fert <- read_excel(path = "Data/indicator undata total_fertility.xlsx", sheet = "Data")
#as default the data from the first sheet is selected unless I tell R otherwise sheet= "sheetname"
raw_infantMort <- read_excel(path = "Data/indicator gapminder infant_mortality.xlsx")


gapminder
#long vs wide format of data 
# not long format as there are more observation variables in one row
# also not wide --> actually gapminder data is tidy 


raw_fert
#data format is wide, because all the measurements in fertility rate- for each year there is one column, could 
# collect all the dates in one seperate column to tidy it up 

fert <-raw_fert %>% 
  rename(country=`Total fertility rate`) %>% 
  gather(key=year,value=fert, -country) %>% 
  mutate(year=as.integer(year))
fert








