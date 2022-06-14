# Author: Zoumana KEITA
# https://zoumanakeita.medium.com/

install.packages("sqldf")
install.packages("tcltk")

library("sqldf")

# Load the data frame into the memory
data_url = "https://raw.githubusercontent.com/keitazoumana/Medium-Articles-Notebooks/main/data/adult-all.csv"
income_data <- read.csv(data_url, header = FALSE)

# Look at the first 5 rows of the data set
head(income_data, 5)


new_columns = c("Age", "Workclass", "fnlwgt", "Education", "EducationNum", "MartialStatus", "Occupation", 
           "Relationship", "Race", "Sex", "CapitalGain", 
           "CapitalLoss", "HoursPerWeek", "Country", "Income")


# Change column names
colnames(income_data) <- new_columns

# Add the ID column to the dataset
income_data$ID <- 1:nrow(income_data)

# Look at the first 5 rows of the data set
head(income_data, 5)


# Get the first 5 observations
query = "SELECT * FROM income_data LIMIT 5"
sqldf(query)

### COLUMN SELECTION 
cuba_query = "SELECT Age, Race, Sex, HoursPerWeek, Income \
              FROM income_data \ 
              WHERE Country = 'Cuba'"
cuba_data = sqldf(cuba_query)
head(cuba_data, 5)

# More than 50 hours and less than 40 years old.

cuba_query_2 = "SELECT Age, Race, Sex, HoursPerWeek, Income \
              FROM income_data \ 
              WHERE Country = 'Cuba'\ 
              AND HoursPerWeek > 40 \ 
              AND Age > 40"

cuba_data_2 = sqldf(cuba_query_2)
head(cuba_data_2, 5)


##### GROUP BY
# Average Weekly Working hours Per Country
wwh_per_country_query = "SELECT Country, AVG(HoursPerWeek) AS AvgWorkHours \
                        FROM income_data GROUP BY Country ORDER BY AvgWorkHours"

wwh_per_country_data = sqldf(wwh_per_country_query) 
head(wwh_per_country_data, 5)
tail(wwh_per_country_data, 5)

# Create a plot
graphics.off()
par("mar")
par(mar = c(12, 4, 2, 2) + 0.2)

barplot(height = wwh_per_country_data$AvgWorkHours, 
        names.arg = wwh_per_country_data$Country,
        main ="Average Working Hours Per Country",
        ylab = "Average Weekly Hours",
        las = 2)


# Generate Plots
wwh_per_country_query = "SELECT Country, AVG(HoursPerWeek) AS AvgWorkHours \
                        FROM income_data GROUP BY Country ORDER BY AvgWorkHours"

wwh_per_country_data = sqldf(wwh_per_country_query) 


# Data sets Creation 
# - Create personal_info_data
query_pers_info = "SELECT ID, Age, MartialStatus, Relationship, Race, Sex, Country FROM income_data"
personal_info_data = sqldf(query_pers_info)
head(personal_info_data, 5)

# - Create background_info_data
query_backg_info = "SELECT ID,Workclass, Education, Occupation, CapitalGain, CapitalLoss, HoursPerWeek, Income FROM income_data"
backg_info_data = sqldf(query_backg_info)
head(backg_info_data, 5)


#### JOINS 
join_query = "SELECT p_info.ID, \
                  p_info.Age, \
                  p_info.MartialStatus, \
                  p_info.Country, \
                  bg_info.Education,\
                  bg_info.Income \
              FROM personal_info_data p_info \ 
              INNER JOIN backg_info_data bg_info \
              ON p_info.ID = bg_info.ID"

join_data = sqldf(join_query)
head(join_data, 5)
