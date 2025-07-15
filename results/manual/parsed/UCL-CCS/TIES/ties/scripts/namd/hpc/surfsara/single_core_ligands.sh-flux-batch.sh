#!/bin/bash
#FLUX: --job-name=stinky-hippo-7698
#FLUX: --priority=16

                    # SLURM will compute the number of nodes needed
                    # 16 processes, each process can spawn 4 OpenMP
		    # threads. (the environment variable OMP_NUM_THREADS
		    # will be set to 4)
                    # An MPI program will start 4 processes on 6 nodes each
		    # 24 processes in total
module load 2019
module load NAMD/2.13-foss-2018b-mpi
namd2 min.namd > min.log
namd2 eq_step1.namd > eq_step1.log
namd2 eq_step2.namd > eq_step2.log
namd2 eq_step3.namd > eq_step3.log
namd2 eq_step4.namd > eq_step4.log
namd2 prod.namd > prod.log
