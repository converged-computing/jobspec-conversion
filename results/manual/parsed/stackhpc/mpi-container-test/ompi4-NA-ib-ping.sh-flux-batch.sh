#!/bin/bash
#FLUX: --job-name=stanky-cupcake-7642
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --priority=16

export UCX_NET_DEVICES='mlx5_0:1 # force IB only'

module load gcc/9.3.0-5abm3xg # spack package
module load openmpi/4.0.3-qpsxmnc # spack package, uses UCX
export UCX_NET_DEVICES=mlx5_0:1 # force IB only
echo "Nodes:", $SLURM_JOB_NODELIST
module load intel-mpi-benchmarks/2019.5-dwg5q6j # spack package
mpirun IMB-MPI1 pingpong
echo "Results: " $(python imb-stats.py $SLURM_JOB_NAME.out)
