/*
 **********************************************
 *  CS314 Principles of Programming Languages *
 *  Fall 2021                                 *
 **********************************************
 */
#include <stdio.h>
#include <stdlib.h>

__global__ void exclusive_prefix_sum_gpu(int * oldSum, int * newSum, int distance, int numElements) {
	/** YOUR CODE GOES BELOW **/
  int numThreads = gridDim.x * blockDim.x;
  int tid = (blockDim.x * blockIdx.x ) + threadIdx.x;
    if(numThreads > numElements){
      if(tid < numElements){
        if( distance == 0){
          newSum[tid] = 0;
          if(tid-1 >= 0)
          newSum[tid] = oldSum[tid-1];
        }
        else{
          newSum[tid] = oldSum[tid];
          if(tid - distance >= 0)
          newSum[tid] = oldSum[tid-distance] + oldSum[tid];
        }
      }
    }
  else{
    if( distance == 0){
      for(int x = tid; x < numElements; x += numThreads ){
          newSum[x] = 0;
          if(x-1 >= 0)
            newSum[x] = oldSum[x-1];
      }
    }
    else{
      for(int x = tid; x < numElements; x += numThreads ){
          newSum[x] = oldSum[x];
        if(x - distance >= 0)
          newSum[x] = oldSum[x-distance] + oldSum[x];
      }
  }
}
	/** YOUR CODE GOES ABOVE **/

}
