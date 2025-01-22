#include <stdio.h>

int binary_search(int*,int,int);

int main(void){
	int arr[5] = {1,2,3,4,5};
	printf("output= %d\n",binary_search(arr,4,5));
}

int binary_search(int* arr,int n,int arr_size){
	
	int low = 0;
	int high=arr_size-1;
	while(low<=high){
		int mid = low+(high-low)/2;
		if(arr[mid]==n){
			return mid;
		}
		if(arr[mid]<n){
			low = mid+1;
		}
		if(arr[mid]>n){
			high = mid-1;
		}
	}	

	return -1;
}
