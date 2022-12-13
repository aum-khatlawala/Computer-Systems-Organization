#include<stdio.h>

extern long long quotient(long long M, long long N);
extern long long rem(long long M, long long N);

int main()
{
	long long M, N, ret_val, ret_val_2;
	// printf("Give two numbers as inputs:\n");
	scanf("%lld %lld", &M, &N);
	ret_val = quotient(M,N);
	ret_val_2 = rem(M,N);
	// printf("Quotient: %lld\n", ret_val);
	// printf("Remainder: %lld\n", ret_val_2);
	printf("%lld %lld\n", ret_val, ret_val_2);
}
