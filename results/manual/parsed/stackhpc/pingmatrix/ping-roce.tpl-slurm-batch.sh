#!/bin/bash
#SBATCH --job-name={job_prefix}
#SBATCH --output={job_prefix}.out
#SBATCH --error={job_prefix}.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude={exclude_nodes}

export SLURM_MPI_TYPE='pmix_v2'
export UCX_NET_DEVICES='mlx5_1:1'

echo "running on nodes {node_a} {node_b}"
module load gcc/9.3.0-5abm3xg
module load openmpi/4.0.3-qpsxmnc
export SLURM_MPI_TYPE=pmix_v2
export UCX_NET_DEVICES=mlx5_1:1
module load intel-mpi-benchmarks/2019.5-dwg5q6j
srun IMB-MPI1 pingpong
