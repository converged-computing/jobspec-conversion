#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10GB
#SBATCH --time=04:00:00
#SBATCH --constraint=[amd20]

ml AOCC/2.2.0 
ml OpenMPI
srun  -n 1 ~/julia-1.7.0/bin/julia MPI_code.jl 
srun  -n 2 ~/julia-1.7.0/bin/julia MPI_code.jl 
srun  -n 4 ~/julia-1.7.0/bin/julia MPI_code.jl 
srun  -n 8 ~/julia-1.7.0/bin/julia MPI_code.jl 
srun  -n 16 ~/julia-1.7.0/bin/julia MPI_code.jl 
srun  -n 32 ~/julia-1.7.0/bin/julia MPI_code.jl 
scontrol show job $SLURM_JOB_ID     ### write job information to SLURM output file.
js -j $SLURM_JOB_ID                 ### write resource usage to SLURM output file (powertools command).
