#include<stdio.h>

extern long long largest_prime_factor(long long N);

int main()
{
	long long N, ret_val;
	// printf("Give the number as input:\n");
	scanf("%lld", &N);
	ret_val = largest_prime_factor(N);
	printf("%lld\n", ret_val);
}
