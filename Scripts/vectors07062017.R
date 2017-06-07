#vectors 

x <-5*6
x
#test whether we have a vector
is.vector(x)
#show length of the vector 
length(x)

#add number to the vector 
x[2]<-31
x

x[5]<-44
x
#get NA for the unspecified positions --> 0 would be a value und would be unwise to put there 

#what is at position 11? 
x[11]
#nothing (NA) --> no value there

#what is at position 0? 
x[0]
#for r the position 0 in the vector is always 0 

#gives me an integer sequence from 1 to 4 with all the values in between 
x <- 1:4
x
y<- x^2
y
#applies the function to each element of the vector x 

x<-1:5
y<-3:7
x
y


x+y
#adds the values position wise 

z<-y[-5]
#in the square brackets we specify the position in the vector and that value will be taken away 

x+z
#will recycle the z vector to make the differing lengths work --> recycling can also be quiet so have to be careful 

z<-1:10
x+z
#now recycling goes on quietly 
#recycling actually happens all the time in R - required for x^2 --> always recycling the 2 for all x values

y<-x[-5]
y[5]<-NA
x+y


#coercion in R --> everything is resolved first and then the coercion happens so it recognizes it before  

c("hello", "workshop", "participants")

#gives me the structure of a vector 
str(c("hello", "workshop", "participants"))

c(9:11, 200, x)
#for x the numbers we assigned earlier will be used 

c("something", pi, 2:4, pi >3)
str(c("something", pi, 2:4, pi >3))
#check the output- if it's in quotation marks it's reduced to characters 
#be aware of changing in types! 

c(pi, 2:4, pi >3)
#drops to numeric as true and false can also be given in 0 and 1 (true) 
str(c( pi, 2:4, pi >3))
#coerced to numeric

str(c( 2L:4L, pi >3))
#coerced to integer

#R basically lets you do what you want, you just have to be aware of that and check the structure to know
# that nothing weird happend


w<- rnorm(10) 
#numbers picked randomly from a normal distribution 

seq_along(w)
w
which(w<0)
#gives me the position of the vector values that are less than 0

w[which(w<0)]
#gives me the values of the vector that are less than 0 

w

w[-c(2,5)]
# I can lose two (or another defined amount of) values of my vector 


#a vector can only contain one kind of data!! --> will be coerced to one kind 
#what if I don't want a coercion? Than I use lists :) 

list("something", pi,2:4, pi>3)

str(list("something", pi,2:4, pi>3))
# gives me this output for 2:4 $ : int [1:3] 2 3 4 -_> first the indices and than the values 
#can have different types of data in one list 
#also allows me to specify names 

x<-list(vegetable="cabbage", 
     number= pi, 
     series=2:4, 
     telling=pi>3)
#got the different elements by a name 

str(x$vegetable)
x[[3]]
#returns the list that is reduced to that element
str(x[[3]])

x<-list(vegetable=list("cabbage", "carrott", "spinach"), 
        number= list(c(pi, 0, 2.14, NA)), 
        series=list(list(2:4,3:5)), 
        telling=pi>3)
str(x)
str(x$vegetable)
#remove the packaging but there is still a list underneath that 





mod<- lm(lifeExp~gdpPercap, data=gapminder_plus)
mod
str(mod)
#make a complex list 
mod$df.residual

str(mod[8])
str(mod[["df.residual"]])
 
#can "search" by name or by position number 

str(mod$qr$qr[1])









