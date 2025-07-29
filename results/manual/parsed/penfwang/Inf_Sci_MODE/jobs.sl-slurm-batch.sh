#!/bin/bash
#SBATCH --account=vuw03334
#SBATCH --output=log.%j.out
#SBATCH --error=log.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=3600
#SBATCH --time=2-12:35:00
#SBATCH --array=1-30

file_path=/nesi/project/vuw03334/binary_DE/algorithms1
module load Python/3.8.1-gimkl-2018b
python $file_path/main_lr.py $1 ${SLURM_ARRAY_TASK_ID}
mv *.txt  /nesi/project/vuw03334/binary_DE/results/final_01_lr/$1
mv *.npy  /nesi/project/vuw03334/binary_DE/results/final_01_lr/$1
