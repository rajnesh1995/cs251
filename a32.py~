import numpy as np							# import statements
							

from numpy import genfromtxt

import matplotlib.pyplot as plt

from numpy.linalg import inv




X_train = genfromtxt('train.csv',delimiter=',',dtype='int64',usecols=0)	# read csv file
Y_train = genfromtxt('train.csv',delimiter=',',dtype='int64',usecols=1)
shape_X=X_train.shape[0]
shape_Y=Y_train.shape[0]
X_train.shape=(shape_X,1)						# X_train
Y_train.shape=(shape_Y,1)						# Y_train

X_col = np.ones((shape_X,1),dtype='int64')

X_train = np.append(X_col,X_train,axis=1)				# New X_train

#print X_col

#print X_train
#print Y_train


w=np.random.rand(2,1)							# w
#print a
plt.figure(1)
plt.plot(X_train[:,1],Y_train,'bo')					#Y_train vs X_train plot


X1 = np.zeros((shape_X,1))						# w^T*X1
for i in range(0,shape_X):
	X1[i]=np.dot(np.transpose(w),np.transpose(X_train[i]))

plt.plot(X_train[:,1],X1,'b-')						# w^T*X1 plot

plt.figure(2)								#Step: 4

plt.plot(X_train[:,1],Y_train,'bo')

xT=np.transpose(X_train)						#calculating w_direct

xTxInverse=inv(np.dot(xT,X_train))
w_direct=np.dot(np.dot(xTxInverse,xT),Y_train)

X2=np.zeros((shape_X,1))
for i in range(0,shape_X):
	X2[i]=np.dot(np.transpose(w_direct),np.transpose(X_train[i]))

plt.plot(X_train[:,1],X2,'b-')






k=3
for j in range(0,2):								#training step:5
	for i in range(0,shape_X):
		s1=np.dot(np.transpose(w),np.transpose(X_train[i]))
		s2=np.subtract(s1,Y_train[i])
		s3=np.dot(0.00000001,s2)
		s4=np.multiply(np.transpose(X_train[i]),s3)
		s4.shape=(2,1)
		w=np.subtract(w,s4)
		if(i%100==0):							#Ploting every 100th iteration
			plt.figure(k)
			plt.plot(X_train[:,1],Y_train,'bo')
			X1 = np.zeros((shape_X,1))						
			for i in range(0,shape_X):
				X1[i]=np.dot(np.transpose(w),np.transpose(X_train[i]))

			plt.plot(X_train[:,1],X1,'b-')
			k+=1







plt.figure('Final Training')							#plot with final w
plt.plot(X_train[:,1],Y_train,'bo')
X1 = np.zeros((shape_X,1))						
for i in range(0,shape_X):
	X1[i]=np.dot(np.transpose(w),np.transpose(X_train[i]))

plt.plot(X_train[:,1],X1,'b-')


plt.show()





## Evaluation Part Step:6 ##



X_test = genfromtxt('test.csv',delimiter=',',dtype='int64',usecols=0)	# read csv file
Y_test = genfromtxt('test.csv',delimiter=',',dtype='int64',usecols=1)
shape_x=X_test.shape[0]
shape_y=Y_test.shape[0]
X_test.shape=(shape_x,1)						# X_test
Y_test.shape=(shape_y,1)						# Y_test

X_col = np.ones((shape_x,1),dtype='int64')

X_test = np.append(X_col,X_test,axis=1)

error1=0.0								# Calculating RMS Error1
for i in range(0,shape_x):
	y_pred1=np.dot(X_test[i],w)
	error1+=(abs(Y_test[i]-y_pred1))**2

error1=error1/shape_x

rootMSerror1=error1**(0.5)

print 'Root Mean Squared Error btw y_pred1 and Y_test: ' +str(rootMSerror1[0])


error2=0.0								# Calculating RMS Error2

x_testT=np.transpose(X_test)

x_testTx_testInverse=inv(np.dot(x_testT,X_test))
w_direct_test=np.dot(np.dot(x_testTx_testInverse,x_testT),Y_test)

for i in range(0,shape_x):
	y_pred2=np.dot(X_test[i],w_direct_test)
	error2+=(abs(Y_test[i]-y_pred2))**2

error2=error2/shape_x

rootMSerror2=error2**(0.5)

print 'Root Mean Squared Error btw y_pred2 and Y_test: ' +str(rootMSerror2[0])




