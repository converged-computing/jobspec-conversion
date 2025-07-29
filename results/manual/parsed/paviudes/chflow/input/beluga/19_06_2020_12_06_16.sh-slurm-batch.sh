#!/bin/bash
#SBATCH --account=def-jemerson
#SBATCH --output=/project/def-jemerson/chbank/19_06_2020_12_06_16/results/ouptut_%j.o
#SBATCH --error=/project/def-jemerson/chbank/19_06_2020_12_06_16/results/errors_%j.o
#SBATCH --mail-user=pavithran.sridhar@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=40
#SBATCH --array=0-7:1

module load intel python scipy-stack
cd /project/def-jemerson/pavi/chflow
./chflow.sh 19_06_2020_12_06_16 ${SLURM_ARRAY_TASK_ID}
