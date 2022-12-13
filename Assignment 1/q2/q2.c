#include<stdio.h>

extern long long gcd(long long M, long long N);

int main()
{
	long long M, N, ret_val;
	// printf("Give two numbers as inputs:\n");
	scanf("%lld %lld", &M, &N);
	ret_val = gcd(M,N);
	printf("%lld\n", ret_val);
}
