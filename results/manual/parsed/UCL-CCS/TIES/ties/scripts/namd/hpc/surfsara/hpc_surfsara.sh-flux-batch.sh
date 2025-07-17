#!/bin/bash
#FLUX: --job-name=angry-blackbean-0657
#FLUX: -t=55230
#FLUX: --urgency=16

                    # SLURM will compute the number of nodes needed
                    # 16 processes, each process can spawn 4 OpenMP
		    # threads. (the environment variable OMP_NUM_THREADS
		    # will be set to 4)
                    # An MPI program will start 4 processes on 6 nodes each
		    # 24 processes in total
module load 2019
module load NAMD/2.13-foss-2018b-mpi
mpirun -np $SLURM_CPUS_ON_NODE namd2 min.namd > min.log
mpirun -np $SLURM_CPUS_ON_NODE namd2 eq_step1.namd > eq_step1.log
mpirun -np $SLURM_CPUS_ON_NODE namd2 eq_step2.namd > eq_step2.log
mpirun -np $SLURM_CPUS_ON_NODE namd2 eq_step3.namd > eq_step3.log
mpirun -np $SLURM_CPUS_ON_NODE namd2 eq_step4.namd > eq_step4.log
mpirun -np $SLURM_CPUS_ON_NODE namd2 prod.namd > prod.log
