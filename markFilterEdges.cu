/*
 **********************************************
 *  CS314 Principles of Programming Languages *
 *  Fall 2021                                 *
 **********************************************
 */
#include <stdio.h>
#include <stdlib.h>

__global__ void markFilterEdges_gpu(int * src, int * dst, int * matches, int * keepEdges, int numEdges) {
	/** YOUR CODE GOES BELOW **/
  int numThreads = gridDim.x * blockDim.x;
  int tid = (blockDim.x * blockIdx.x ) + threadIdx.x;
  if(numThreads > numEdges){
    if(tid < numEdges){
        keepEdges[tid] = 1;
        int source = src[tid];
        int destination = dst[tid];
        if( matches[source] != -2 || matches[destination] != -2)
          keepEdges[tid] = 0;
      }
  }
  else{
    for(int x = tid; x < numEdges; x += numThreads ){
        keepEdges[x] = 1;
        int source = src[x];
        int destination = dst[x];
        if( matches[source] != -2 || matches[destination] != -2)
          keepEdges[x] = 0;

      }
  }

	/** YOUR CODE GOES ABOVE **/
}
