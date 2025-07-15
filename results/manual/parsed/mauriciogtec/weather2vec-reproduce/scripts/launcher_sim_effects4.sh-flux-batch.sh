#!/bin/bash
#FLUX: --job-name=reclusive-toaster-9932
#FLUX: -c=8
#FLUX: --priority=16

source ~/.bashrc
conda activate cuda116
for sparse in "" "--sparse"
do
    for task in "nonlinear" "basic"
    do
        for i in 0 1
        do
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method pca &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method tsne &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method crae &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method cvae &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method unet &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method resnet &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method local &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method avg &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method causal_wx &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method resnet_sup &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method unet_sup &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method unet_sup_car &
            python train_sim_effects.py $sparse --task=$task --embsdir results-sim6 --silent --sim $((2*SLURM_ARRAY_TASK_ID + i)) --method car &
            wait
        done
    done
done
