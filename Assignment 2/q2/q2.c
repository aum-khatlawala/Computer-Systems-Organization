#include<stdio.h>
#include<stdlib.h>

extern long long rec_count(long long N, long long diff);

int main()
{
	long long N, ret_val;
	scanf("%lld", &N);
    ret_val = rec_count(N, 0);
    printf("%lld\n", ret_val);
}

/* pseudo code in C:
if (abs(diff) > n) {
    return 0;
}
if (n == 1) {
    if (diff == 0) {
        return 2;
    }
    if (abs(diff) == 1) {
        return 1;
    }
}
ret_val = (rec_count(N-1, diff+1) + 2 * rec_count(N-1, diff) + rec_count(N-1, diff-1))
return ret_val
*/

// code returns 0 for negative inputs