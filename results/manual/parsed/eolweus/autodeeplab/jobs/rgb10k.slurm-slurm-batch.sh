#!/bin/bash
#FLUX: --job-name=rgb10k
#FLUX: -c=8
#FLUX: --queue=GPUQ
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONBUFFERED='1'

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"
GPU_MEMORY=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
if [[ $GPU_MEMORY -gt 80000 ]]; then
    BATCH_SIZE=24
else
    BATCH_SIZE=12
fi
truncate -s 0 /cluster/home/erlingfo/autodeeplab/out/rgb10k_gpu_usage.log
truncate -s 0 /cluster/home/erlingfo/autodeeplab/out/rgb10k_cpu_usage.log
while true; do
    nvidia-smi --query-gpu=index,name,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv >> /cluster/home/erlingfo/autodeeplab/out/rgb10k_gpu_usage.log
    sleep 0.1
done &
GPU_MONITOR_PID=$!
while true; do
    cpu_memory=$(free -m | awk 'NR==2{printf "Memory: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
    echo "$cpu_memory" >> /cluster/home/erlingfo/autodeeplab/out/rgb10k_cpu_usage.log
    sleep 1
done &
CPU_MONITOR_PID=$!
module purge
source ~/.bashrc
module load CUDA/11.3.1
conda activate autodl
export PYTHONBUFFERED=1
echo "starting autodeeplab"
CUDA_VISIBLE_DEVICES=0 python ../train_autodeeplab.py \
 --batch_size $BATCH_SIZE --dataset solis --checkname "no_bb_rgb_10010" \
 --alpha_epoch 20 --filter_multiplier 8 --resize 224 --crop_size 224 \
 --num_bands 3 --epochs 40 --num_images 10010 --loss-type ce --workers 8 \
 --resume /cluster/home/erlingfo/autodeeplab/run/solis/no_bb_rgb_10010/experiment_6/checkpoint.pth.tar
kill $GPU_MONITOR_PID
kill $CPU_MONITOR_PID
uname -a 
