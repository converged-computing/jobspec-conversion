#!/bin/bash
#SBATCH --job-name=serial
#SBATCH --output=serial.out
#SBATCH --error=serial.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=01:05:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

export PYTHONPATH='/home/dclure/hathi-mpi'

module load openmpi/1.10.2/gcc
module load python/3.3.2
export PYTHONPATH=/home/dclure/hathi-mpi
$PYTHONPATH/env/bin/python $PYTHONPATH/jobs/serial.py 3600
