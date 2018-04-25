CC=gcc
CGCC=nvcc
CFLAGS=-I. -g
CUDACFLAGS=--gpu-architecture=sm_60
LDFLAGS=-lm -lpthread

all: q1 q2

q1:qn1.cu
	$(CGCC) $(CFLAGS) $(CUDACFLAGS) qn1.cu $(LDFLAGS) -o q1
q2:qn2.cu
	$(CGCC) $(CFLAGS) $(CUDACFLAGS) qn2.cu $(LDFLAGS) -o q2
clean:
	rm -f *.o q1 q2
	
