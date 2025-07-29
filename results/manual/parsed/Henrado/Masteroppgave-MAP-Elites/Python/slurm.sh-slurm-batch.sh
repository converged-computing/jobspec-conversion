#!/bin/bash
#FLUX: --job-name=$1
#FLUX: --urgency=16

sbatch<<EOT
source ~/.bashrc
conda activate env39
srun python main3.py -c conf/$1.yaml -w $4 -o $5/$1/$4
sleep 60
EOT
