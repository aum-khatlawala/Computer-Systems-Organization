#include<stdio.h>

extern long long sq_1_to_n_then_sum(long long N);

int main()
{
	long long N, ret_val;
	// printf("Give the number as input:\n");
	scanf("%lld", &N);
	ret_val = sq_1_to_n_then_sum(N);
	printf("%lld\n", ret_val);
}
