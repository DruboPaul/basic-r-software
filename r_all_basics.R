# Author Drubo Paul
# The basics of R programming  
    # The four quadrants
    # How to get help when you need it
    # Objects and functions
    # Built in data sets to practice
    # Installing and using packages

# Data Exploration
    # Data structure and types of variable
    # Name of variables
    # Unique categories
    # Missing data

# Data Cleaning 
    # Select variables
    # Changing variable order
    # Changing variable name
    # Changing a variable type
    # Changing factor levels
    # Filter rows
    # Recode data
    # Dealing with missing data
    # Dealing with duplicates

# Data Manipulation
    # Create or change a variable
    # Conditional change (if_else)
    # Reshape data with Pivot wider
    # Reshape data with Pivot longer

# Description of Data
    # Range / spread
    # Centrality
    # Variance
    # Summarize your data
    # Create tables

# Data Visualisation
    # The grammer of graphics
    # Bar plots
    # Histograms
    # Box plots
    # Density plots
    # Scatter plots
    # Smoothed model

# Data Analyse
    # Hypothesis testing
    # T - test
    # ANova
    # Chi Squared
    # Linear Model



# Objects and functions
5 + 6

a <- 5
b <- 6

a + b

sum(a,b)

ages <- c(6, 6)
ages

sum(ages)



# Define the vectors
names <- c("John", "James")
ages <- c(25, 30)

# Create a data frame
friends <- data.frame(names, ages)

# View the data frame
View(friends)

# Check the structure of the data frame
str(friends)

friends$ages
friends$names

sum(friends$ages)

friends[1,1]
friends[1, ]
friends[ ,1]

# Built in data set to practice with
data()
View(starwars)

# Installing and using packages
install.packages("tidyverse")
library(tidyverse)

library(dplyr) # Ensure you have loaded dplyr for piping

# Display the first few rows
head(starwars)
# Filter and transform data

starwars %>% # Shift + Ctrl + m = %>% 
  filter(height > 150 & mass < 200) %>%
  mutate(height_in_meters = height/100) %>%
  select(height_in_meters, mass) %>%
  arrange(mass) %>%
  View()
  plot()
 

# Explore
# Data structure and types of variables
view(msleep)

glimpse(msleep)

head(msleep)

class(msleep$name)

length(msleep)

names(msleep)

unique(msleep$vore)

missing <- !complete.cases(msleep)

msleep[missing, ]


# Clean
# Select variables

starwars %>%
  select(name, height, mass)

starwars %>% 
  select(1:3)

starwars %>%
  select(ends_with("color")) %>% 
  view()

# Changing the variable order
starwars %>% 
  select(name, mass, height, everything()) %>% 
  view()

# Changing the variable name
starwars %>%
  rename("characters" = "name") %>%
  head()

class(starwars$hair_color)

starwars$hair_color <- as.factor(starwars$hair_color)

class(starwars$hair_color)


starwars %>%
  mutate(hair_color = as.character(hair_color)) %>% 
  glimpse()


# Changing factor levels
df <- starwars
df$sex <- as.factor(df$sex)

levels(df$sex)

df <- df %>%
  mutate(sex = factor(sex,
                      levels = c("male","female", "hermaphroditic", "none")))

levels(df$sex)

# Filter rows
starwars %>% 
  select(mass,sex) %>%
  filter(mass < 55 & 
           sex == "male")

# Recode data
starwars %>%
  select(sex) %>%
  mutate(sex = recode(sex,
                      "male" = "man",
                      "female" = "women"))

# Dealing with missing data
mean(starwars$height, na.rm = TRUE)

starwars %>% 
  select(name, gender, hair_color, height)
  
starwars %>% 
  drop_na(hair_color)

# Dealing with duplicates

Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)
friends <- data.frame(Names, Age)

friends

friends %>% 
  distinct()
distinct(friends)


# Manipulate
# Create or change a variable (mutate)

starwars %>%
  mutate(height_m = height/100) %>% 
  select(name, height, height_m)


# Conditional Change (if_else)
starwars %>%
  mutate (height_m = height/100) %>%
  select(name, height, height_m) %>%
  mutate(tallness = 
           if_else(height_m < 1,
                    "short",
                   "tall"))
# Reshape data with Pivot wider
install.packages("gapminder")
library(gapminder)
view(gapminder)

data <- select(gapminder, country, year, lifeExp)
view(data)

wide_data <- data %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

# Reshape data with Pivot longer
long_data <- wide_data %>%
  pivot_longer(2:13,
               names_to = "year",
               values_to = "lifeExp")

View(long_data)

# Describe
View(msleep)

# Range / spread
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)

# Centrality
mean(msleep$awake)
median(msleep$awake)

# Variance
var(msleep$awake)

summary(msleep$awake)

msleep %>% 
  select(awake, sleep_total) %>%
  summary()

# Summarize your data 
msleep %>%
  drop_na(vore) %>%
  group_by(vore) %>%
  summarise(Lower = min(sleep_total),
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            difference = 
              max(sleep_total)-min(sleep_total)) %>%
  arrange(Average) %>%
  View()

# Create tables

table(msleep$vore)

msleep %>%
  select(vore, order) %>%
  filter(order %in% c("Rodentia", "Primates")) %>%
  table()


# Visualise

plot(pressure)

# The grammer of graphics 
   # Data
   # Mapping
   # Geometry

# Bar plots

ggplot(data = starwars,
      mapping = aes(x = gender))+
  geom_bar()

# Histograms

starwars %>%
  drop_na(height) %>%
  ggplot(mapping = aes(x = height))+
  # ggplot(mapping = aes(x = height))+
  geom_histogram()

# Box Plots
starwars %>%
  drop_na(height) %>%
  ggplot(aes(height))+
  geom_boxplot(fill = "steelblue")+
  theme_bw()+
  labs(title = "Boxplot of height",
       x = "Height of characters")

# Density Plots
library(tidyverse)


starwars %>%
  drop_na(height) %>%
  filter(sex %in% c("male", "female")) %>%
  ggplot(aes(height,
                     color = sex,
                     fill = sex))+
  geom_density(alpha = 0.2)+
  theme_bw()









# Scatter Plots
starwars 
install.packages("tidyverse")  # Run this if you don't have tidyverse installed
library(tidyverse)             # Load the package
install.packages("dplyr")
library(dplyr)



library(tidyverse)

# Ensure 'sex' is character and filter rows properly
starwars_clean <- starwars %>%
  mutate(sex = as.character(sex)) %>%
  drop_na(height) %>%
  filter(sex %in% c("male", "female"))

# Plot the data
starwars_clean %>%
  ggplot(aes(height, color = sex, fill = sex)) +
  geom_density(alpha = 0.2) +
  theme_bw()


# Scatter Plots
starwars %>%
  filter(mass < 200) %>%
  ggplot(aes(height, mass, color = sex))+
  geom_point(size = 5, alpha = 0.5)+
  theme_minimal()+
  labs(title = "Height and mass by sex")

# Smoothed model
starwars %>%
  filter(mass < 200) %>%
  ggplot(aes(height, mass, color = sex))+
  geom_point(size = 3, alpha = 0.8)+
  geom_smooth()+
  facet_wrap(~sex)+
  theme_bw()+
  labs(title = "Height and mass by sex")


# Analyze 
# Hypothesis testing
# T-test

library(gapminder)
View(gapminder)
t_test_plot

gapminder %>%
  filter(continent %in% c("Africa", "Europe")) %>%
  t.test(lifeExp ~ continent, data = .,
         alternative = "two.sided",
         paired = FALSE)

# ANOVA
 
library(gapminder)
library(dplyr)

# Perform ANOVA
ANOVA_result <- gapminder %>%
  filter(year == 2007) %>%
  filter(continent %in% c("Americas", "Europe", "Asia")) %>%
  aov(lifeExp ~ continent, data = .)

# Display the ANOVA summary
summary(ANOVA_result)

gapminder %>%
  filter(year == 2007) %>%
  filter(continent %in% c("Americas", "Europe", "Asia")) %>%
  aov(lifeExp ~ continent, data = .) %>%
  TukeyHSD()

# There is a problem in below code.To identify later , it is drafted as comment.
##gapminder %>%
###filter(year == 2007) %>%
### filter(continent %in% c("Americas", "Europe", "Asia")) %>%
### aov(lifeExp ~ continent, data = .) %>%
###  TukeyHSD()
### plot() ###

  library(gapminder)
  library(dplyr)
  
  # Perform ANOVA
  ANOVA_result <- gapminder %>%
    filter(year == 2007) %>%
    filter(continent %in% c("Americas", "Europe", "Asia")) %>%
    aov(lifeExp ~ continent, data = .)
  
  # Perform Tukey's HSD test
  Tukey_result <- TukeyHSD(ANOVA_result)
  
  # Display the Tukey test result
  print(Tukey_result)
  
  # Plot the Tukey HSD result
  plot(Tukey_result)
  
  
# Chi Squared 
  
  # There is a problem in below code.To identify later , it is drafted as comment
  #chi_plot
  
  # head(iris)
  
  #flowers <- iris %>%
  #   mutate(size = cut(Sepal.Length,
  #     breaks = 3,
  #     labels = c("Small", "Medium", "Large"))) %>%
  # select(Species, size)
  
  
  # Load necessary libraries
  library(dplyr)
  
  # View the first few rows of the iris dataset
  head(iris)
  
  # Create a new 'size' variable and select relevant columns
  flowers <- iris %>%
    mutate(size = cut(Sepal.Length, 
                      breaks = 3, 
                      labels = c("Small", "Medium", "Large"))) %>%
    select(Species, size)
  
  # Perform Chi-Square Test of Independence
  chi_result <- chisq.test(table(flowers$Species, flowers$size))
  
  # Display the result of the Chi-Square test
  print(chi_result)
  
  # Bar Plot to visualize the contingency table
  chi_plot <- flowers %>%
    count(Species, size) %>%
    ggplot(aes(x = Species, y = n, fill = size)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Species vs. Sepal Size", y = "Count") +
    theme_minimal()
  
  # Display the plot
  chi_plot
  
  
  # Chi Squared goodness of fit test
  flowers %>%
    select(size) %>%
    #table()
    table() %>%
    chisq.test()
  
  # Chi squared test of independence
  flowers %>%
    table() %>%
    chisq.test()
    
  # Linear Model
    
  #  head(cars, 10)
  
  #   cars %>%
  #  lm(dist ~ speed, data = .) %>%
  # summary()
 
  # View the first 10 rows of the 'cars' dataset
  head(cars, 10)
  plot(cars)
  
  # Perform linear regression of 'dist' on 'speed' and display the summary
  model <- lm(dist ~ speed, data = cars)
  summary(model)
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  










