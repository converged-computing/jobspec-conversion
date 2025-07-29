#!/bin/bash
#SBATCH --job-name=Si_sw
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3000mb
#SBATCH --time=1-00:00:00
#SBATCH --qos=phillpot-b

pwd; hostname; date
module load intel/2016.0.109
module load impi/5.1.1
echo PYTHONPATH=$PYTHONPATH
PYTHON_BIN=$(which python)
echo PYTHON_BIN=$PYTHON_BIN
echo python=$(which python)
echo PATH=$PATH
echo "start_time:$(date)"
srun --mpi=pmi2 $PYTHON_BIN mc_iterative_sampler.py
echo "end_time:$(date)"
