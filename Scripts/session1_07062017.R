library("tidyverse")

library("readxl")


# GAPMINDER PLUS 
download.file(url = "https://raw.githubusercontent.com/dmi3kno/SWC-tidyverse/master/data/gapminder_plus.csv", 
              destfile = "Data/gapminder_plus.csv")

gapminder_plus <- read.csv(file="Data/gapminder_plus.csv")

gapminder_plus

#filter: africa 
#mutate: need population and number of babies to get to the number of babies dead 
#filter for year 2007 --> should have a dataset with seven countries and one coloumn 
#join dataset to the main gapminder 


#african_countries_infant <- 
  
#gapminder_plus %>% 
  #filter(continent=="Africa", year==2007) %>% 
  #mutate(babies_dead=infantMort*pop/1000) %>% 
  #filter(babies_dead==2000000)

gapminder_plus %>% 
  filter(continent=="Africa", year==2007) %>% 
  mutate(babies_dead=infantMort*pop/1000) %>% 
  filter(babies_dead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babies_dead=infantMort*pop/1e3, gdp_bln=gdpPercap*pop/1e9, pop_mln=pop/1e6) %>% 
  select(-c(continent, pop, babies_dead)) %>% 
  gather(key=variables, value=values, -c(country, year)) %>% 
  ggplot(data=.)+
  geom_text(data=. %>% filter(year==2007) %>% group_by(variables) %>%  
            mutate(max_value=max(values)) %>% 
            filter(values==max_value),
            mapping = aes(x=year, y=values, label=country, color=country))+
  geom_line(mapping=aes(x=year, y=values, color=country))+
  facet_wrap(~variables, scales = "free_y")+
  labs(title="Challenge 1", 
       subtitle="Key parameters for select African countries", 
       caption="Stuff about different population parameters",
       x="Year",
       y=NULL)+
  theme_bw()+
  theme(legend.position = "none")



#data=. specifies that the piped data should go there! Pipe output always goes to the dot, if not specified
# it will go to the first "free space" 
#theme can be specified for the graph --> can go to the help and see what I can modify about my theme 
#has also many basic settings that I can pre-select --> theme_bw/_minimal/_dark.... 

#join can be used in a way as a filter --> join the datasets just for the stuff we selected before 

#gather(key=variable, value= values, c(fert,infantMort, babies_dead, gdpPercap, pop, lifeExp))
  