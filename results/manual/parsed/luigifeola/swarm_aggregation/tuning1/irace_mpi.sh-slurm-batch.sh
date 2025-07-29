#!/bin/bash
#SBATCH --job-name=irace_mpi_tuning1
#SBATCH --output=res_irace_mpi_tuning1.txt
#SBATCH --nodes=1
#SBATCH --ntasks=21
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=23:59:59

module load OpenMPI
module load R
srun /opt/sw/arch/easybuild/2021b/software/R/4.1.2-foss-2021b/lib64/R/library/irace/bin/irace --exec-dir=/home/unamur/fac_info/asion/swarm_aggregation/tuning1 --parallel 19 --mpi 1 --scenario scenario.txt
