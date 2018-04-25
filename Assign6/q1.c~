#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <pthread.h>
#include<sys/time.h>

#define MAX_THREADS 60

#define SEED 0x7457

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct thread_params							// thread parameters
{
	pthread_t tid;
        int *array;
        int size;
        int skip;
	int thread_ctr;
        double max_prime;  
        int max_prime_index;


};

int is_prime(int a)							// Prime number checking
{
	int temp=sqrt(a),i;
	int ans=0;
	if (a<2)
		return 0;
	if (a==2||a==3)
		return 1;
	for (i=2;i<temp;i++)
	{
		if(a%i==0)
		{
			break;
		}
	}
	if (i==temp)
		ans=1;
	return ans;
}

void *find_max_prime(void *arg)						// find_max_prime function
{
	struct thread_params *param = (struct thread_params *) arg;
	int ctr=param->thread_ctr;
	param->max_prime=2;
	param->max_prime_index=ctr;

	while(ctr < param->size)
	{
        	int x = is_prime(param->array[ctr]);
 
	        if(x && param->array[ctr] > param->max_prime)
		{
        	        param->max_prime = param->array[ctr];
        	        param->max_prime_index = ctr;
        	}
        	ctr += param->skip;
	}
          
	return NULL;


}


int main(int argc, char **argv)
{
	struct thread_params *params;
	struct timeval start, end;
	int max_prime;
	int max_prime_index;
	int num_elements;
	int num_threads;
	int *a;
	int ctr;

	if(argc!=3)
	{	
		printf("Invalid number of parameters.\n");
		exit(-1);
	}

	num_elements= atoi(argv[2]);
	if (num_elements<=0)
	{
		printf("Invalid number of elements.\n");
		exit(-1);
	}

	num_threads= atoi(argv[1]);
	if (num_threads<=0||num_threads>MAX_THREADS)
	{
		printf("Invalid number of threads.\n");
		exit(-1);
	}
	
	a=(int *)malloc(num_elements*sizeof(int));
	if(!a)
	{
		printf("Number of elements too large for storage.\n");
		exit(-1);
	}

	srand(SEED);							// Generating random numbers
	for (ctr=0;ctr<num_elements;ctr++)
	{
		a[ctr]=random();
	
	}
	
	params = (struct thread_params *)malloc(num_threads*sizeof(struct thread_params));
	memset(params, 0, num_threads * sizeof(struct thread_params));
	gettimeofday(&start, NULL);
	for (ctr=0;ctr<num_threads;ctr++)				// initialising thread parameters
	{
		struct thread_params *param = params+ctr;
		param->size=num_elements;
		param->skip=num_threads;
		param->thread_ctr = ctr;
		param->array=a;
		
		if(pthread_create(&param->tid,NULL,find_max_prime,param)!=0)	// pthread_create
		{
			perror("Thread create.");
			exit(-1);
		}
	}

	for (ctr=0;ctr<num_threads;ctr++)
	{
		struct thread_params *param = params+ctr;
		pthread_join(param->tid, NULL);					//pthread_join
        	if(ctr == 0 || (ctr > 0 && param->max_prime > max_prime))
		{
             		max_prime = param->max_prime;    
             		max_prime_index = param->max_prime_index;
       		}

	}

	
	printf("Max prime is %d at index %d\n",max_prime,max_prime_index); 
	gettimeofday(&end, NULL);
	printf("Time taken = %ld microsecs\n", TDIFF(start, end));

	return 0;
}
