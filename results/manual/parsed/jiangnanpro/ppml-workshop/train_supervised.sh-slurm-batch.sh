#!/bin/bash
#SBATCH --job-name=supervDef
#SBATCH --output=logs/%A_%a.stdout
#SBATCH --error=logs/%A_%a.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --qos=default
#SBATCH --array=0-5
#SBATCH --exclude=n[1-5]

SECONDS=0
restart(){
    echo "Calling restart" 
    scontrol requeue $SLURM_JOB_ID
    echo "Scheduled job for restart" 
}
ignore(){
    echo "Ignored SIGTERM" 
}
trap restart USR1
trap ignore TERM
date 
args=()
args+=("supervised_train_resnet50_defender.py --train_path data/QMNIST_ppml_ImageFolder/defender --val_path data/QMNIST_ppml_ImageFolder/reserve --batch_size 64 --weight_decay 1e-4 --scheduler_patience 4 --scheduler_factor 0.1 --epochs 40 --random_seed 68 --train_mode fc --num_workers 8")
args+=("supervised_train_resnet50_defender.py --train_path data/QMNIST_ppml_ImageFolder/defender --val_path data/QMNIST_ppml_ImageFolder/reserve --batch_size 64 --weight_decay 1e-4 --scheduler_patience 4 --scheduler_factor 0.1 --epochs 40 --random_seed 68 --train_mode whole --num_workers 8")
args+=("supervised_train_resnet50_defender.py --train_path data/QMNIST_ppml_ImageFolder/defender --val_path data/QMNIST_ppml_ImageFolder/reserve --batch_size 64 --weight_decay 0 --scheduler_patience 4 --scheduler_factor 0.1 --epochs 80 --random_seed 68 --train_mode fc --overfit --num_workers 8")
args+=("supervised_train_resnet50_defender.py --train_path data/QMNIST_ppml_ImageFolder/defender --val_path data/QMNIST_ppml_ImageFolder/reserve --batch_size 64 --weight_decay 0 --scheduler_patience 4 --scheduler_factor 0.1 --epochs 80 --random_seed 68 --train_mode whole --overfit --num_workers 8")
args+=("supervised_train_resnet50_defender.py --train_path data/QMNIST_ppml_flipped_ImageFolder/defender --val_path data/QMNIST_ppml_flipped_ImageFolder/reserve --batch_size 64 --weight_decay 0 --scheduler_patience 4 --scheduler_factor 0.1 --epochs 80 --random_seed 68 --train_mode fc --overfit --random_labels --num_workers 8")
args+=("supervised_train_resnet50_defender.py --train_path data/QMNIST_ppml_flipped_ImageFolder/defender --val_path data/QMNIST_ppml_flipped_ImageFolder/reserve --batch_size 64 --weight_decay 0 --scheduler_patience 4 --scheduler_factor 0.1 --epochs 80 --random_seed 68 --train_mode whole --overfit --random_labels --num_workers 8")
echo "Starting python ${args[${SLURM_ARRAY_TASK_ID}]}"
srun python ${args[${SLURM_ARRAY_TASK_ID}]}
echo "End python ${args[${SLURM_ARRAY_TASK_ID}]}"
DURATION=$SECONDS
echo "End of the program! $(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed." 
