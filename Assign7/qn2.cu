#include<stdio.h>
#include<stdlib.h>
#include <math.h>
#include<sys/time.h>

#define NUM 10000000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct num_array{
                    int Xn;
};



__device__ void myXOR(struct num_array *a, int x,int y)
{
    int ans = x^y;
    a->Xn = ans;
    return;
}
__global__ void calculate(char *mem, char *result, int num)
{
	int i = blockDim.x * blockIdx.x + threadIdx.x;
	if(i >= num)
		return;
	
	struct num_array *b = (struct num_array *)(result);
	struct num_array *a = (struct num_array *)(mem + (i*sizeof(int)));
	if(b->Xn==(int)INFINITY)
	{
		b->Xn=a->Xn;
	}
	
	else
	{
		int x = b->Xn;	
		int y= a->Xn;
		myXOR(a,x,y);
	}
}

int main(int argc, char **argv)
{
	struct timeval start, end, t_start, t_end;
	int i;
	struct num_array *pa;
	char *ptr;
	char *ans_ptr;
	char *sptr;
	char *gpu_mem;
	char *gpu_ans;	   
	unsigned long num = NUM;   /*Default value of num from MACRO*/
	int blocks;

	if(argc == 2)
	{
		num = atoi(argv[1]);   /*Update after checking*/
		if(num <= 0)
			num = NUM;
	}

	/* Allocate host (CPU) memory and initialize*/

	ptr = (char *)malloc(num * sizeof(int));
	ans_ptr=(char *)malloc(sizeof(int));
	sptr = ptr; 
	for(i=0; i<num; ++i)
	{
		pa = (struct num_array *) sptr;
		pa->Xn = random();
		sptr += sizeof(int);
	}
    
	pa=(struct num_array *) ans_ptr;
	pa->Xn=(int)INFINITY;
    
	gettimeofday(&t_start, NULL);
    
	/* Allocate GPU memory and copy from CPU --> GPU*/

	cudaMalloc(&gpu_mem, num*sizeof(int));
	CUDA_ERROR_EXIT("cudaMalloc");

	cudaMalloc(&gpu_ans,sizeof(int));
	CUDA_ERROR_EXIT("cudaMalloc");

	cudaMemcpy(gpu_mem, ptr, num*sizeof(int) , cudaMemcpyHostToDevice);
	CUDA_ERROR_EXIT("cudaMemcpy");

	cudaMemcpy(gpu_ans, ans_ptr,sizeof(int) , cudaMemcpyHostToDevice);
	CUDA_ERROR_EXIT("cudaMemcpy");
    
	gettimeofday(&start, NULL);
    
	blocks = num /1024;
    
	if(num % 1024)
		++blocks;

	calculate<<<blocks, 1024>>>(gpu_mem,gpu_ans,num);
	CUDA_ERROR_EXIT("kernel invocation");
	gettimeofday(&end, NULL);
    
	/* Copy back result*/

	
	cudaMemcpy(ans_ptr, gpu_ans,sizeof(int) , cudaMemcpyDeviceToHost);
	CUDA_ERROR_EXIT("memcpy");

	gettimeofday(&t_end, NULL);
    
	printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
	cudaFree(gpu_mem);
	cudaFree(gpu_ans);
   
	/*Print result*/ 
	pa=(struct num_array *) ans_ptr;
	printf("Result=%d\n",pa->Xn);

    
	free(ptr);
	free(ans_ptr);
}
