#!/bin/bash
#FLUX: --job-name=expensive-pastry-6722
#FLUX: -c=2
#FLUX: --queue=large
#FLUX: -t=218100
#FLUX: --urgency=16

file_path=/nesi/project/vuw03334/binary_DE/algorithms1
module load Python/3.8.1-gimkl-2018b
python $file_path/main_lr.py $1 ${SLURM_ARRAY_TASK_ID}
mv *.txt  /nesi/project/vuw03334/binary_DE/results/final_01_lr/$1
mv *.npy  /nesi/project/vuw03334/binary_DE/results/final_01_lr/$1
