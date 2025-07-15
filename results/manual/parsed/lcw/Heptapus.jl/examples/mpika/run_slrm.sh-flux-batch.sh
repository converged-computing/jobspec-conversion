#!/bin/bash
#FLUX: --job-name=test_mpi_cudanative
#FLUX: -n=2
#FLUX: --queue=allgpu
#FLUX: -t=600
#FLUX: --priority=16

source /etc/profile
module load compile/gcc/7.2.0 openmpi/3.0.0 lib/cuda/10.1.243
mpirun nvprof -o "timeline_job_%q{SLURM_JOBID}_rank_%q{OMPI_COMM_WORLD_RANK}" \
              --context-name "MPI Rank %q{OMPI_COMM_WORLD_RANK}" \
              --process-name "MPI Rank %q{OMPI_COMM_WORLD_RANK}" \
              --annotate-mpi openmpi \
              julia --project=. try.jl
