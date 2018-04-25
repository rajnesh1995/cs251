A=['0','1','2','3','4','5','6','7','8','9', \
	 'A','B','C','D','E','F','G','H','I','J','K','L', \
	'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']




number=raw_input()		#input number
base=raw_input()		#input base

part1=""
part2=""
revPart1=""
sign='+'


#print int(base)


if (number[0]=='-'):
	sign='-'
	number=number[1:]
	#print sign

if ('.' in number):
	i=number.index('.')
	part1+=number[:i]
	part2+=number[i+1:]
	revPart1+=part1[::-1]


#print part1
#print part2
#print revPart1

	
	ansPart1=0
	ansPart2=0.0
	i=0
	for chr in revPart1:
		if(A.index(chr)>int(base)):
			print "Invalid Input"
			exit(0)
		ansPart1+=A.index(chr)*(int(base)**i)
		i+=1





#print ansPart1


	i=-1
	for chr in part2:
		if(A.index(chr)>int(base)):
			print "Invalid Input"
			exit(0)
		ansPart2+=A.index(chr)*(int(base)**i)
		i-=1


#print ansPart2	



	ansPart1=str(ansPart1)


	if (sign=='-'):
		if (ansPart2==0.0):
			print '-' + ansPart1
		else:
			ansPart2=str(ansPart2)
			print '-' + ansPart1 + ansPart2[1:]

	else:
		if (ansPart2==0.0):
			print  ansPart1
		else:
			ansPart2=str(ansPart2)
			print  ansPart1 + ansPart2[1:]

else:
	revPart1+=number[::-1]
	ansPart1=0
	
	i=0
	for chr in revPart1:
		if(A.index(chr)>int(base)):
			print "Invalid Input"
			exit(0)
		ansPart1+=A.index(chr)*(int(base)**i)
		i+=1


	ansPart1=str(ansPart1)


	if (sign=='-'):
		print '-' + ansPart1

	else:
		print  ansPart1 

	





