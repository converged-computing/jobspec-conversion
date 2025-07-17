#!/bin/bash
#FLUX: --job-name=adl-mixed-50
#FLUX: -c=64
#FLUX: --queue=dc-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')'
export MASTER_PORT='7010'
export NCCL_DEBUG='INFO'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export NUM_GPU_PER_NODE='4'
export LOG_DIR='/p/scratch/delia-mp/lin4/experiment_result/adl/'
export EXPERIMENT='0804-mixed-50'
export CHANNELS_NUM='1'

echo 'Experiment start !'
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"
MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)"
MASTER_ADDR="${MASTER_ADDR}i"
export MASTER_ADDR="$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')"
export MASTER_PORT=7010
export NCCL_DEBUG=INFO
export CUDA_VISIBLE_DEVICES=0,1,2,3
export NUM_GPU_PER_NODE=4
source /p/project/delia-mp/lin4/Julich_experiment/ADL/adl_env/activate.sh
export LOG_DIR="/p/scratch/delia-mp/lin4/experiment_result/adl/"
export EXPERIMENT="0804-mixed-50"
export CHANNELS_NUM=1
srun python3 train.py \
	--EXPERIMENT ${EXPERIMENT} \
    --json-file configs/ADL_train.json \
    --DENOISER efficient_Unet \
    --effective_batch_size 16 \
    --world_size 4 \
    --noise_type mixed \
    --noise_level 50 \
    --use_special_loss \
	--CHANNELS-NUM ${CHANNELS_NUM} \
    --train-dirs '/p/scratch/delia-mp/lin4/RestormerGrayScaleData/clean/train/DFWB' \
                '/p/scratch/delia-mp/lin4/RestormerGrayScaleData/clean/test/BSD68' \
    --test-dirs '/p/scratch/delia-mp/lin4/RestormerGrayScaleData/clean/test/Set12', \
                '/p/scratch/delia-mp/lin4/RestormerGrayScaleData/clean/test/BSD68', \
                '/p/scratch/delia-mp/lin4/RestormerGrayScaleData/clean/test/Urban100', \
    --distributed \
echo "Finish ADL experiment"
