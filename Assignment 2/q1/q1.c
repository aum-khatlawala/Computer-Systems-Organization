#include<stdio.h>
#include<stdlib.h>

extern long long nearest_tallest_person_to_the_right(long long N, long long* arr, long long* ret_arr);

int main()
{
	long long N, *ret_arr;
    long long *arr;
	scanf("%lld", &N);
    arr = (long long*)malloc(N * sizeof(long long));
    ret_arr = (long long*)malloc(N * sizeof(long long));
    for (long long i = 0; i < N; i++) {
        scanf("%lld", &arr[i]);
        ret_arr[i] = -1;
    }
	nearest_tallest_person_to_the_right(N, arr, ret_arr);
    for (long long i = 0; i < N; i++) {
        printf("%lld ", ret_arr[i]);
    }
    printf("\n");
}

/* pseudo code in C:
for each element in the array,
while (!s.empty() && arr[s.top()] < arr[i]) {
    ret_arr[s.top()] = arr[i];
    s.pop();
}
s.push(i);
*/