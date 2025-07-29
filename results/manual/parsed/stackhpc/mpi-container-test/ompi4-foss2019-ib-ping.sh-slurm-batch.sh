#!/bin/bash
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=openhpc-compute-[2-15]

export UCX_NET_DEVICES='mlx5_0:1 # force IB only - host'
export SINGULARITYENV_OMPI_MCA_btl_openib_if_include='mlx5_0:1 # force IB only - container'

module load gcc/9.3.0-5abm3xg # spack package
module load openmpi/4.0.3-qpsxmnc # spack package, uses UCX
export UCX_NET_DEVICES=mlx5_0:1 # force IB only - host
export SINGULARITYENV_OMPI_MCA_btl_openib_if_include=mlx5_0:1 # force IB only - container
echo "Nodes:", $SLURM_JOB_NODELIST
mpirun /alaska/steveb/opt/singularity-dev/bin/singularity exec mpi-benchmarks.sif IMB-MPI1 pingpong
echo "Results: " $(python imb-stats.py $SLURM_JOB_NAME.out)
