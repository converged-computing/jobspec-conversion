#!/bin/bash
#FLUX: --job-name=ISIC
#FLUX: --queue=prod
#FLUX: --priority=16

module load anaconda3
if [ "$SLURM_ARRAY_TASK_ID" -eq "1" ]; then
srun python -u /homes/sallegretti/ISIC_2020/classification_net.py --network densenet201 --batch_size 8 --save_dir /nas/softechict-nas-1/sallegretti/SUBMISSIONMODELS --augm_config 16 -c 0 -c 1 2 3 4 5 6 7 --load_epoch 102 --epochs 0 --dataset isic2020
fi
