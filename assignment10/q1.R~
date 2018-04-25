a=rexp(n=50000,rate=0.2)
b=sort(a)
plot(b,main="Scatter plot")

x=list()

for (i in 1:500)
{	x1=100*(i-1)+1
	x2=100*i
	x[[i]]=a[x1:x2]
}

for (i in 1:5)
{
	y=ecdf(x[[i]])
	plot(y,main="Cumulative distribution function")
}

for (i in 1:5)
{
	z=density(x[[i]])
	plot(z,main="Probability density function")
}

my.means=vector("numeric",500)
my.sd=vector("numeric",500)
for (i in 1:500)
{
	my.means[i]=mean(x[[i]])
	my.sd[i]=sd(x[[i]])
}

cat ('Means of first five vectors:\n')
for (i in 1:5)
{
	print (my.means[i])
}

cat ('Standard deviation of first 5 vectors:\n')

for (i in 1:5)
{
	print (my.sd[i])
}

c=ecdf(my.means)
plot(c,main="CDF of means")

d=density(my.means)
plot(d,main="PDF of means")

my.freq=table(round(my.means))

plot(my.freq, "h", xlab="Value", ylab="Frequency")

mean.means=mean(my.means)
sd.means=sd(my.means)

mean.vector=mean(a)
sd.vector=sd(a)

cat ("Mean and sd of original distribution: \n")
print (mean.vector)
print (sd.vector)

cat ("\nMean and sd of distribution of sample mean:\n")
print (mean.means)
print(sd.means)
