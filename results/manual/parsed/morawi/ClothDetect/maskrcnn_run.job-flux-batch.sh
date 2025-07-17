#!/bin/bash
#FLUX: --job-name=ModNeTst
#FLUX: -c=2
#FLUX: --queue=compute
#FLUX: --urgency=16

python mask_rcnn.py --lr=0.005 --job_name="$SLURM_JOB_NAME" --lr_scheduler=StepLR --batch_size=2 --n_cpu=2 --num_epochs=1 --epoch=0 --checkpoint_interval=1 --HPC_run=True --redirect_std_to_file=True --pretrained_model=True --train_percentage=0.5 --dataset_name=Modanet
