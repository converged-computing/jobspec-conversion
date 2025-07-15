#!/bin/bash
#FLUX: --job-name=bumfuzzled-spoon-5208
#FLUX: --priority=16

                    # SLURM will compute the number of nodes needed
                    # 16 processes, each process can spawn 4 OpenMP
		    # threads. (the environment variable OMP_NUM_THREADS
		    # will be set to 4)
                    # An MPI program will start 4 processes on 6 nodes each
		    # 24 processes in total
module load 2019
GROMACS/2019.3-intel-2018b-CUDA-10.0.130
mpirun -np $SLURM_CPUS_ON_NODE namd2 min.namd > min.log
