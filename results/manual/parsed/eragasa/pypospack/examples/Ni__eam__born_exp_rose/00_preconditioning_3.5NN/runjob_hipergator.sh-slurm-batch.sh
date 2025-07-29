#!/bin/bash
#SBATCH --job-name=Ni_rose
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3000mb
#SBATCH --time=1-00:00:00
#SBATCH --qos=phillpot-b

pwd; hostname; date
module load intel/2018.1.163 
module load openmpi/3.0.0
OMPI_MCA_mpi_warn_on_fork=0
export OMPI_MCA_mpi_warn_on_fork
echo PYTHONPATH=$PYTHONPATH
echo python=$(which python)
echo PATH=$PATH
echo "start_time:$(date)"
srun --mpi=pmix_v1 python mc_iterative_sampler.py
echo "end_time:$(date)"
