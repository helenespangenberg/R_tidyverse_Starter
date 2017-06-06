library("tidyverse")

gapminder<-read_csv("Data/gapminder-FiveYearData.csv")
gapminder


rep("this is an example", times=3)
"this is an example" %>% rep(time=3)
#shortcut for pipe symbol: Shift+Strg+m = %>% 

#define a dataset from the original that only contains defined columns 
year_country_gdp <- select(gapminder, year, country, gdpPercap)
year_country_gdp
#shows only the header plus first 6 lines of the data set 
head(year_country_gdp)

year_country_gdp <- gapminder %>% select(year, country, gdpPercap)
head(year_country_gdp)

#filter command
gapminder %>% filter(year==2002) %>% 
ggplot(mapping=aes(x=continent, y=pop))+
  geom_boxplot()
#one = is an assignment; == means that it should test and then use the data if test result is true

year_country_gdp_euro <- gapminder %>% filter(continent=="Europe") %>% 
  select(year,country,gdpPercap)

year_country_gdp_euro


norwegian_lifeExp <- gapminder %>% filter(country=="Norway") %>% 
  select(lifeExp, gdpPercap, year)
norwegian_lifeExp

gapminder %>% 
  group_by(continent)
 
gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))

#gives me the mean GDP per Cap of the whole data set
gapminder %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap)) %>% 
  ggplot(mapping=aes(x=continent, y=mean_gdpPercap))+
  geom_point()

#challenge: calculate average life Exp per country in asia 
gapminder %>% 
  filter(continent=="Asia") %>% group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  filter(mean_lifeExp==min(mean_lifeExp)|mean_lifeExp==max(mean_lifeExp)) %>% 
  ggplot(mapping= aes(x=country, y=mean_lifeExp))+
  geom_point()+
  coord_flip()

gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  ggplot(mapping= aes(x=country, y=mean_lifeExp))+
  geom_point()+
  coord_flip()

gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9)
  


gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>%
  group_by(continent, year) %>% 
  summarize(mean_gdp_billion=mean(gdp_billion))


gapminder_country_summary <- gapminder %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp))

library(maps)

map_data("world") %>% 
  rename(country=region) %>% 
  left_join(gapminder_country_summary, by="country") %>% 
  ggplot()+
  geom_polygon(aes(x=long, y=lat, group=group, fill=mean_lifeExp))+
  scale_fill_gradient(low="blue", high="red")+
  coord_equal()+
ggsave("secondfancyplot_countries.png")

# renamed the data variable region to country
  

