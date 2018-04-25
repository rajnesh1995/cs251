#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>

#define MAX_THREADS 64

pthread_mutex_t lock;

struct statement							// Structure for Account Data 
{
	int account_no;
	double balance;
};

struct transaction							// Structure for Transaction carried out
{
	int txn_no;
	int txn_type;
	double amount;
	int acc1;
	int acc2;
};


struct thread_params							// Thread parameters
{
	pthread_t tid;
        struct statement *stmts;
	struct transaction *txns;
        int size;
        int skip;
	int thread_ctr;
};



void *execute_transaction(void *args)					// execute_transaction function			
{
	struct thread_params *param = (struct thread_params *) args;
	int ctr=param->thread_ctr;
	int count=1;
	
	while(ctr < param->size && count<=param->skip)
	{	int type=param->txns[ctr].txn_type;
		double amount=param->txns[ctr].amount;
		int acc1=param->txns[ctr].acc1;
		int acc2=param->txns[ctr].acc2;
	
		if (type==1)
		{
			amount=amount-(amount/100);
			param->stmts[acc1-1001].balance=param->stmts[acc1-1001].balance + amount;
		}
		else if (type==2)
		{
			amount=amount+(amount/100);
			param->stmts[acc1-1001].balance=param->stmts[acc1-1001].balance - amount;
		}
		else if (type==3)
		{
        		pthread_mutex_lock(&lock);							// mutex lock
			int amount1=param->stmts[acc1-1001].balance;
		 	amount1=amount1*0.071;
			param->stmts[acc1-1001].balance=param->stmts[acc1-1001].balance + amount1;	
	        	pthread_mutex_unlock(&lock);							// mutex unlock
		}
		else if (type==4)
		{
			
		 	int amount1 = amount + amount/100;
			int amount2 = amount - amount/100;
			param->stmts[acc1-1001].balance=param->stmts[acc1-1001].balance - amount1;
			param->stmts[acc2-1001].balance=param->stmts[acc2-1001].balance + amount2;
			
		}
        	ctr += param->skip;
		count++;
	}
          
	return NULL;



}


int main(int argc,char **argv)
{
	
	int num_threads;
	int num_tranxn;
	int num_accounts;
	int num_transaction;
	int ctr;
	
	if (argc!=5)
	{
		printf("Invalid number of parameters.\n");
		exit(-1);
	}

	char *file_acc, *file_txn;
	file_acc=(char *)malloc(20*sizeof(char));
	file_txn=(char *)malloc(20*sizeof(char));
	file_acc=argv[1];
	file_txn=argv[2];
	
	num_tranxn=atoi(argv[3]);
	
	num_threads=atoi(argv[4]);
	
	if (num_threads<=0||num_threads>MAX_THREADS)
	{
		printf("Invalid number of threads.\n");
		exit(-1);
	}
	pthread_t threads[num_threads];
	
	FILE *fp1=fopen(file_acc,"r");
	FILE *fp2=fopen(file_txn,"r");
	
	char *line;
	int count=0;
	size_t linesize=50*sizeof(char);
	line =(char *)malloc(50*sizeof(char));
	int a;
	double b=0.0;	
	

	while(getline(&line,&linesize,fp1)!=-1)						// Calculating number of entries
		count++;
	
	num_accounts=count;
	fseek(fp1,0,SEEK_SET);
	
	count=0;
	while(getline(&line,&linesize,fp2)!=-1)						// Calculating number of entries
		count++;
	
	num_transaction=count;
	fseek(fp2,0,SEEK_SET);

	if (num_transaction > num_tranxn)
	{
		printf("Invalid number of transactions.\n");
		exit(-1);
	}

	struct statement *stmts;
	struct transaction *txns;
	
	
	stmts=(struct statement *)malloc(num_accounts*sizeof(struct statement));
	txns= (struct transaction *)malloc(num_transaction*sizeof(struct transaction));	
	
	bzero(stmts,num_accounts*sizeof(struct statement));
	bzero(txns,num_transaction*sizeof(struct transaction));
	
	for (count=0;count<num_accounts;count++)					// reading acc.txt file
	{
		fscanf(fp1,"%d %lf",&stmts[count].account_no,&stmts[count].balance);
			
		
	}
	
	for (count=0;count<num_tranxn;count++)						// reading txn.txt file
	{
		fscanf(fp2,"%d %d %lf %d %d",&txns[count].txn_no,&txns[count].txn_type,&txns[count].amount,&txns[count].acc1,&txns[count].acc2);
		
	}

	fclose(fp1);
	fclose(fp2);
	

	pthread_mutex_init(&lock, NULL);						// mutex initializer;

	struct thread_params *params = (struct thread_params *)malloc(num_threads*sizeof(struct thread_params));
	memset(params, 0, num_threads * sizeof(struct thread_params));
	for (ctr=0;ctr<num_threads;ctr++)						// initialising thread parametrs
	{
		struct thread_params *param = params+ctr;
		param->size=num_tranxn;
		param->skip=num_threads;
		param->thread_ctr = ctr;
		param->stmts=stmts;
		param->txns=txns;
		
		if(pthread_create(&param->tid,NULL,execute_transaction,param)!=0)	// pthread_create
		{
			perror("Thread create.");
			exit(-1);
		}
	}
	
	
	for (ctr=0;ctr<num_threads;ctr++)						//pthread_join
	{
		pthread_join(params->tid, NULL);
	}

	
	for (count=0;count<num_accounts;count++)					//writing to console and writing back to file
	{
		printf("%d %.2lf\n",stmts[count].account_no,stmts[count].balance);
	}
	
	
	
	
	

	return 0;



}
