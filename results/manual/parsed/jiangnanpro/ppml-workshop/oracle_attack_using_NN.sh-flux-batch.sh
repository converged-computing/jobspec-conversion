#!/bin/bash
#FLUX: --job-name=WBattack
#FLUX: -c=3
#FLUX: --queue=all
#FLUX: --urgency=16

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
args+=("oracle_attack_using_NN.py --model_path supervised_model_checkpoints/best_model_supervised_resnet50_QMNIST_defender_whole-0.0001-normal-normal_gallant-wildflower-1.pth --results_dir supervised_normal_whole_attack_using_NN --dataset_path data/QMNIST_ppml.pickle --attack_mode forward_target_domain --N 3000 --zip")
echo "Starting python ${args[${SLURM_ARRAY_TASK_ID}]}"
srun python ${args[${SLURM_ARRAY_TASK_ID}]}
echo "End python ${args[${SLURM_ARRAY_TASK_ID}]}"
DURATION=$SECONDS
echo "End of the program! $(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed." 
