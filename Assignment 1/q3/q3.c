#include<stdio.h>

extern long long isprime(long long N);

int main()
{
	long long N, ret_val;
	// printf("Give the number as input:\n");
	scanf("%lld", &N);
	ret_val = isprime(N);
    // printf("The number is prime: ");
    if (ret_val == 1) {
	    printf("TRUE\n");
    };
    if (ret_val == 0) {
        printf("FALSE\n");
    };
}
