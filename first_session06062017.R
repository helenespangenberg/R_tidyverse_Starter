# hash can be used to annotate my script 

#command to load the tydiverse package
library("tidyverse")

#command to read in data and create it as an object 
gapminder <- read_csv(file = "Data/gapminder-FiveYearData.csv")

gapminder

#select the data set and the plus indicates that the command continues in the next line
# plotted geometric points; aes = aesthetic; dann Achsendefinition 
ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp))

#introduced third variable- color to indicate another variable from the dataset 
ggplot(data = gapminder) + 
  geom_jitter(mapping = aes(x = gdpPercap, y = lifeExp, color= continent))

#transform the axis to get a better distribution of the data points and understand it better 
ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp, color= continent, size= pop))

#linking ggplot to the data
#try out different plotting forms/ grafische Darstellungen 
#mapping is indicating which pieces of data are going where on the plot 
#aes function ?? 
ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp), alpha= 0.1, size= 2, color= "blue")

ggplot(data = gapminder) + 
  geom_line(mapping = aes(x = log(gdpPercap), y = lifeExp, group= country, color= continent))

ggplot(data = gapminder) + 
  geom_line(mapping = aes(x = year, y = lifeExp, group= country, color= continent))

ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))

ggplot(data = gapminder) + 
  geom_jitter(mapping= aes(x = continent, y = lifeExp, color= continent)) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp, color= continent))
#switching the order of the commands will influence the plotting- first command will be in the front
#with a plus I can combine different layers and the first command will be the upper layer
ggplot(data = gapminder) + 
   geom_boxplot(mapping = aes(x = continent, y = lifeExp, color= continent)) +
  geom_jitter(mapping= aes(x = continent, y = lifeExp, color= continent))

#lift repeating sequences up, so that it will be inherted to every layer underneath 
#mapping is in the main function and the underlying commands will see this and use it 
ggplot(data = gapminder, 
       mapping= aes(x = continent, y = lifeExp, color= continent))+
  geom_jitter() + 
  geom_boxplot()

#alpha sets transparency
#jitter plots points with a little noise so that they are not all on top of each other 
#lm means linear model --> are not transparent 
#can change stuff specifically to the layer 
ggplot(data = gapminder, 
       mapping= aes(x = log(gdpPercap), y = lifeExp, color= continent))+
  geom_jitter(alpha= 0.1) + 
  geom_smooth(method= "lm")

#hiding the color continent from the linear model layer
#need to put it in the mapping environment so R knows that continent is a data variable 
ggplot(data = gapminder, 
       mapping= aes(x = log(gdpPercap), y = lifeExp))+
  geom_jitter(mapping= aes(color= continent), alpha= 0.3) + 
  geom_smooth(method= "lm")

#challenge: boxplot life exp. by year 
ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))
#gives me nonsense as an output --> need to define that each year is a category

ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = year, y = lifeExp))

#as character: define it as a category variable --> is a form of function  
ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = as.character(year), y = lifeExp))

ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = as.character(year), y = log(gdpPercap)))

ggplot(data = gapminder) + 
  geom_density2d(mapping = aes(x =lifeExp, y = log(gdpPercap)))
#gives you a kind of elevation map --> can see two clusters of data points within this data set

ggplot(data = gapminder, mapping = aes(x =gdpPercap, y = lifeExp))+ 
         geom_point()

ggplot(data = gapminder, mapping = aes(x =gdpPercap, y = lifeExp))+ 
  geom_point()+
  geom_smooth()+
  scale_x_log10()+
  facet_wrap(~ continent)
#have to have a space between continent and the tilde 
#indicating there is a function between two variables ? 

#assignment: facetting by year 
ggplot(data = gapminder, mapping = aes(x =gdpPercap, y = lifeExp))+ 
  geom_point()+
  geom_smooth(method="lm")+
  scale_x_log10()+
  facet_wrap(~ year)

ggplot(data = gapminder, mapping = aes(x =gdpPercap, y = lifeExp))+ 
  geom_point()+
  geom_smooth(method="lm")+
  scale_x_log10()+
  facet_wrap(~ continent)

#shrink dataset to one year 
filter(gapminder, year==2007)

ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping=aes(x=continent))
#did not define what y is, so R did the statistial counting for the y-dimension 

#this is what R assumes when I don't spell out what y is 
ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping=aes(x=continent), stat= "count")
#count is a substitute for y variable 

filter(gapminder, year==2007, continent=="Oceania")

ggplot(data=filter(gapminder, year==2007, continent=="Oceania"))+
  geom_bar(mapping=aes(x=country, y=pop), stat= "identity")
#stat=identity I tell R to go back to my data set and plot the indicated data 
#point R to specific data set 

#here count definition is already defined 
ggplot(data=filter(gapminder, year==2007, continent=="Oceania"))+
  geom_col(mapping=aes(x=country, y=pop))

ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
  geom_bar(mapping=aes(x=country, y=pop), stat= "identity")
#too much data points- cant read the legend 

ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
  geom_bar(mapping=aes(x=country, y=pop), stat= "identity")+
  coord_flip()


ggplot(data = gapminder, mapping = aes(x =gdpPercap, y = lifeExp, color=continent, size=pop/10^6))+ 
  geom_point()+
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title="Life expectancy vs GDP per Capita over time", 
       subtitle="In the last 50 years, life expectancy has improved in most countries over the world",
       caption="Source: GapMinder Foundation",
       x="GDP per Capita in 1000 USD",
       y="Life expectancy in years",
       color="Continent",
       size="Population in millions")
ggsave("myfancyplot.png")

#find help on the lower right window under help and then type in your question 
  