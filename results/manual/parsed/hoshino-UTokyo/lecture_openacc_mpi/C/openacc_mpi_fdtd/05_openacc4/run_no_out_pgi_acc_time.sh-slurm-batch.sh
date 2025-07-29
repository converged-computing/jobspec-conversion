#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hoshino-UTokyo/lecture_openacc_mpi/C/openacc_mpi_fdtd/05_openacc4/run_no_out_pgi_acc_time.sh
