#!/bin/bash
#FLUX: --job-name=benchmarks
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=general
#FLUX: -t=14400
#FLUX: --urgency=16

spack load openmpi/nb2qima72b5usivgbcdbkwn5ivmcwlxk
mpirun -n 1 all_to_all 0
mpirun -n 2 all_to_all 0
mpirun -n 4 all_to_all 0
mpirun -n 6 all_to_all 0
mpirun -n 8 all_to_all 0
mpirun -n 16 all_to_all 0
mpirun -n 24 --oversubscribe all_to_all 1
mpirun -n 32 --oversubscribe all_to_all 1
mpirun -n 64 --oversubscribe all_to_all 1
mpirun -n 128 --oversubscribe all_to_all 1
mpirun -n 1 count_primes 0
mpirun -n 2 count_primes 0
mpirun -n 4 count_primes 0
mpirun -n 6 count_primes 0
mpirun -n 8 count_primes 0
mpirun -n 16 count_primes 0
mpirun -n 24 --oversubscribe count_primes 1
mpirun -n 32 --oversubscribe count_primes 1
mpirun -n 64 --oversubscribe count_primes 1
mpirun -n 128 --oversubscribe count_primes 1
