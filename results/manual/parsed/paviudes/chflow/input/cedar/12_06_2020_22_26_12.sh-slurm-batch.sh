#!/bin/bash
#SBATCH --account=def-jemerson
#SBATCH --output=/Users/pavi/Documents/chbank/12_06_2020_22_26_12/results/ouptut_%j.o
#SBATCH --error=/Users/pavi/Documents/chbank/12_06_2020_22_26_12/results/errors_%j.o
#SBATCH --mail-user=2003adityajain@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --array=0-13:1

module load intel/2016.4 python/3.7.0 scipy-stack/2019a
cd /project/def-jemerson/$USER/chflow
./chflow.sh 12_06_2020_22_26_12 ${SLURM_ARRAY_TASK_ID}
