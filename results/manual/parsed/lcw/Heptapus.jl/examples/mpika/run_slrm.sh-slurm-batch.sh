#!/bin/bash
#SBATCH --job-name=test_mpi_cudanative
#SBATCH --output=out_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titanv:2
#SBATCH --mem-per-cpu=12GB
#SBATCH --time=00:10:00
#SBATCH --partition=allgpu

source /etc/profile
module load compile/gcc/7.2.0 openmpi/3.0.0 lib/cuda/10.1.243
mpirun nvprof -o "timeline_job_%q{SLURM_JOBID}_rank_%q{OMPI_COMM_WORLD_RANK}" \
              --context-name "MPI Rank %q{OMPI_COMM_WORLD_RANK}" \
              --process-name "MPI Rank %q{OMPI_COMM_WORLD_RANK}" \
              --annotate-mpi openmpi \
              julia --project=. try.jl
