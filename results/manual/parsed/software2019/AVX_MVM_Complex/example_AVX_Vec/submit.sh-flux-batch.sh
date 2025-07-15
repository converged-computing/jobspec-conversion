#!/bin/bash
#FLUX: --job-name=grated-ricecake-6403
#FLUX: --queue=test
#FLUX: --urgency=16

export I_MPI_DEBUG='5 '
export MPI_DSM_VERBOSE='1 '
export MPI_SHARED_VERBOSE='1 '
export MPI_MEMMAP_VERBOSE='1 '
export OMP_NUM_THREADS='4'
export OMP_DISPLAY_ENV='true # turns on display of OMP's internal control variables'
export OMP_DISPLAY_AFFINITY='true # display the affinity of each OMP thread'
export OMP_AFFINITY_FORMAT='Thread Affinity: %0.3L %.8n %.15{thread_affinity} %.12H'
export OMP_PROC_BIND='close '
export OMP_PLACES='cores #bind each thread to a core'

source /opt/ohpc/pub/oneAPI/setvars.sh
echo "cat /proc/sys/kernel/perf_event_paranoid"
cat /proc/sys/kernel/perf_event_paranoid
export I_MPI_DEBUG=5 
unset MPI_DSM_OFF                 #Turns off nonuniform memory access (NUMA) optimization in the MPI library.
export MPI_DSM_VERBOSE=1 
export MPI_SHARED_VERBOSE=1 
export MPI_MEMMAP_VERBOSE=1 
export OMP_NUM_THREADS=4
export OMP_DISPLAY_ENV=true # turns on display of OMP's internal control variables
export OMP_DISPLAY_AFFINITY=true # display the affinity of each OMP thread
export OMP_AFFINITY_FORMAT="Thread Affinity: %0.3L %.8n %.15{thread_affinity} %.12H"
export OMP_PROC_BIND=close 
export OMP_PLACES=cores #bind each thread to a core
  #echo "Number of Threads = " $OMP_NUM_THREADS
  #icc xandar_openmp.c -o test1 -qopenmp
  #icc avx_complex_vec.c -o test -O3 -march=core-avx2 -mtune=core-avx2 -no-multibyte-chars
  #icc avx_complex_vec.c -o test -O3 -march=core-avx2 -mtune=core-avx2 -no-multibyte-chars 
  #icc avx_complex_vec.c -o test -O3 -march=core-avx2 -mtune=core-avx2 -no-multibyte-chars
./avx_complex_vec
