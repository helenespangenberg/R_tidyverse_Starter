
lifeExp_Cont <- 
  
  gapminder_plus %>% 
  group_by(continent) %>% 
  summarize(mean_le=mean(lifeExp), 
            min_le=min(lifeExp),
            max_le=max(lifeExp))



#reduces the data set to the information I specified --> loose all the other infos

gapminder_plus %>% 
  ggplot()+
  geom_line(mapping = aes(x=year, y=lifeExp, color=continent, group=country))
#see there are some outliers --> try to facet by continent 

gapminder_plus %>% 
  ggplot()+
  geom_line(mapping = aes(x=year, y=lifeExp, color=continent, group=country))+
  facet_wrap(~continent)
#add a linear model to it to see the trends for the continents 

gapminder_plus %>% 
  ggplot()+
  geom_line(mapping = aes(x=year, y=lifeExp, color=continent, group=country))+
  geom_smooth(mapping = aes(x=year, y=lifeExp), 
              method="lm", color="black")+
  facet_wrap(~continent)
  
#can see the linear model in black in the graphs now 

by_country<- gapminder_plus %>%  group_by(continent, country) %>% 
  nest()
by_country
#has a table in a table 
# can fit a linear model to each table 

str(by_country$data)

by_country$data[1]
by_country$data[[1]]
# only data for Afghanistan as it is in position 1 

# idea of what a map looks like: map(list, function)

map(1:3, sqrt)

library(purrr)

model_by_country<- by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=map(model,broom::glance))
model_by_country

model_by_country$summr[[1]]
#gives me a summary of the element I selected

#model_by_country<- 
  
  by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% 
  arrange(r.squared) %>%
  filter(r.squared<0.3) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  ggplot()+
  geom_line(mapping = aes(x=year, y=lifeExp, color=country, group=country))



#unnest --> I want to unwrap the summary column 
#gdpPercap and lifeExp
  

gapminder_plus %>% ggplot()+
  geom_point(mapping=aes(x=log(gdpPercap), y=lifeExp, color=continent, group=country))

gapminder_plus %>% ggplot()+
  geom_line(mapping=aes(x=log(gdpPercap), y=lifeExp, color=continent, group=country))

  by_country %>% 
    mutate(model=purrr::map(data, ~lm(lifeExp~log(gdpPercap), data=.x))) %>% 
    mutate(summr=map(model,broom::glance)) %>% 
    unnest(summr) %>% 
    arrange(r.squared) %>%
    filter(r.squared<0.1) %>% 
    select(country) %>% 
    left_join(gapminder_plus) %>% 
    ggplot()+
    geom_point(mapping = aes(x=log(gdpPercap), y=lifeExp, color=country))


  by_country %>% 
    mutate(model=purrr::map(data, ~lm(lifeExp~log(gdpPercap), data=.x))) %>% 
    mutate(summr=map(model,broom::glance)) %>% 
    unnest(summr) %>% 
    arrange(r.squared) %>%
    filter(r.squared<0.3) %>% 
    select(country) %>% 
    left_join(gapminder_plus) %>% 
    ggplot()+
    geom_line(mapping = aes(x=log(gdpPercap), y=lifeExp, color=country, group=country))
  
#save data like this  
#can send it to someone and they can open it readRDS("by_country_tibble")
#file extension RDS can save anything I generate in R --> but can also only be opened in R
saveRDS(by_country,"by_country_tibble.rds")  
  
write_csv(gapminder_plus, "gapminder_plus_for_professor.csv")
