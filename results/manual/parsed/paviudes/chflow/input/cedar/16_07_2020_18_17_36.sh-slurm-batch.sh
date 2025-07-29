#!/bin/bash
#SBATCH --account=def-jemerson
#SBATCH --output=/project/def-jemerson/chbank/16_07_2020_18_17_36/results/ouptut_%j.o
#SBATCH --error=/project/def-jemerson/chbank/16_07_2020_18_17_36/results/errors_%j.o
#SBATCH --mail-user=pavithran.sridhar@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --array=0-1:1

module load intel/2016.4 python/3.7.0 scipy-stack/2019a
cd /project/def-jemerson/pavi/chflow
./chflow.sh 16_07_2020_18_17_36 ${SLURM_ARRAY_TASK_ID}
