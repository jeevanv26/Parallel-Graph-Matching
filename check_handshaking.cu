/*
 **********************************************
 *  CS314 Principles of Programming Languages *
 *  Fall 2021                                 *
 **********************************************
 */
#include <stdio.h>
#include <stdlib.h>

__global__ void check_handshaking_gpu(int * strongNeighbor, int * matches, int numNodes) {
	/** YOUR CODE GOES BELOW **/
  int numThreads = gridDim.x * blockDim.x;
  int tid = (blockDim.x * blockIdx.x ) + threadIdx.x;
  if(numThreads > numNodes){
    if(tid < numNodes){
      if(strongNeighbor[strongNeighbor[tid]] == tid && matches[tid] == -2)
        matches[tid] = strongNeighbor[tid];
    }
  }
  else{
      for(int x = tid; x < numNodes; x += numThreads ){
        if(strongNeighbor[strongNeighbor[x]] == x && matches[x] == -2)
          matches[x] = strongNeighbor[x];
      }
}
	/** YOUR CODE GOES ABOVE **/
}
