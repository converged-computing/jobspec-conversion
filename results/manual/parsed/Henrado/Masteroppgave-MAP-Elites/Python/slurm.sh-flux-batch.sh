#!/bin/bash
#FLUX: --job-name=crunchy-salad-0455
#FLUX: --priority=16

sbatch<<EOT
source ~/.bashrc
conda activate env39
srun python main3.py -c conf/$1.yaml -w $4 -o $5/$1/$4
sleep 60
EOT
