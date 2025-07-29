#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --account=pa181004
#SBATCH --output=test_job.%j.out
#SBATCH --error=test_job.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1G
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=1

export I_MPI_FABRICS='shm:dapl'

export I_MPI_FABRICS=shm:dapl
if [ x$SLURM_CPUS_PER_TASK == x ]; then
  export OMP_NUM_THREADS=1
else
  export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
fi
module purge            # clean up loaded modules 
module use ${HOME}/modulefiles
module load gnu/8.3.0
module load intel/18.0.5
module load intelmpi/2018.5
module load cuda/10.1.168
module load python/3.6.5
module load pytorch/1.3.1
module load slp/1.3.1
srun python test.py
