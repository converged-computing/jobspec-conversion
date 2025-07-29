#!/bin/bash
#SBATCH --job-name=Ni_fs
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3000mb
#SBATCH --time=12:00:00
#SBATCH --qos=phillpot

export OMPI_MCA_pml='^ucx'

pwd; hostname; date
module load intel/2018.1.163
module load openmpi/3.1.2
echo PYTHONPATH=$PYTHONPATH
PYTHON_BIN=$(which python)
echo PYTHON_BIN=$PYTHON_BIN
echo python=$(which python)
echo PATH=$PATH
echo "start_time:$(date)"
export OMPI_MCA_pml=^ucx
srun --mpi=pmi2 $PYTHON_BIN run__iterative_cluster_sampling.py
echo "end_time:$(date)"
