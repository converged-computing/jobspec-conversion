#!/bin/bash
#SBATCH --job-name=ModNeTst
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:rtx2080ti:1
#SBATCH --mem=20000
#SBATCH --partition=compute

python mask_rcnn.py --lr=0.005 --job_name="$SLURM_JOB_NAME" --lr_scheduler=StepLR --batch_size=2 --n_cpu=2 --num_epochs=1 --epoch=0 --checkpoint_interval=1 --HPC_run=True --redirect_std_to_file=True --pretrained_model=True --train_percentage=0.5 --dataset_name=Modanet
