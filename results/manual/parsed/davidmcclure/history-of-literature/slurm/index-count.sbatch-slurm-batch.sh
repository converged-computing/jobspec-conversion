#!/bin/bash
#SBATCH --job-name=index-count
#SBATCH --output=index-count.out
#SBATCH --error=index-count.err
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64000
#SBATCH --time=15:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=16

export PYTHONPATH='/home/dclure/history-of-literature'

module load openmpi/1.10.2/gcc
module load python/3.3.2
export PYTHONPATH=/home/dclure/history-of-literature
mpirun -x PYTHONPATH $PYTHONPATH/env/bin/python \
    $PYTHONPATH/bin/index_count
