#!/bin/bash
#FLUX: --job-name=ams288-res-1024
#FLUX: --queue=pascal
#FLUX: -t=7200
#FLUX: --urgency=16

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-gpu              # REQUIRED - loads the basic environment
module load miniconda3-4.5.4-gcc-5.4.0-hivczbz
module unload cuda/8.0
module load cuda/10.0
module load cuda/9.0 intel/mkl/2017.4 
module load cudnn/7.3_cuda-9.0
source activate thesisenvcl
cd "$HOME/MThesis/repos/mine/light_obj_detection/SolotNet"
python train.py ctdet --exp_id visdrone_res_1024 --batch_size 32  --arch resdcn_18 --dataset visdrone --input_res 1024 --num_epochs 100 --lr 5e-4 --lr_step 45,60 --gpus 0,1,2,3 --num_workers 32 --resume
