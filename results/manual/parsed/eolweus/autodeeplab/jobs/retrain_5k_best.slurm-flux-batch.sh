#!/bin/bash
#FLUX: --job-name="best_5k_retrain"
#FLUX: -c=10
#FLUX: --queue=GPUQ
#FLUX: -t=86400
#FLUX: --priority=16

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
    BATCH_SIZE=280
else
    BATCH_SIZE=140
fi
truncate -s 0 /cluster/home/erlingfo/autodeeplab/out/best_5k_retrain_gpu_usage.log
truncate -s 0 /cluster/home/erlingfo/autodeeplab/out/best_5k_retrain_cpu_usage.log
while true; do
    nvidia-smi --query-gpu=index,name,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv >> /cluster/home/erlingfo/autodeeplab/out/best_5k_retrain_gpu_usage.log
    sleep 0.1
done &
GPU_MONITOR_PID=$!
while true; do
    cpu_memory=$(free -m | awk 'NR==2{printf "Memory: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
    echo "$cpu_memory" >> /cluster/home/erlingfo/autodeeplab/out/best_5k_retrain_cpu_usage.log
    sleep 1
done &
CPU_MONITOR_PID=$!
module purge
source ~/.bashrc
module load CUDA/11.3.1
conda activate autodl
export PYTHONBUFFERED=1
CUDA_VISIBLE_DEVICES=0 python ../train.py \
 --batch_size $BATCH_SIZE --dataset solis --checkname "best_5k_retrain" \
 --resize 224 --crop_size 224 --num_bands 12 --epochs 100 --workers 10 \
 --net_arch /cluster/home/erlingfo/autodeeplab/run/solis/5k/network_path.npy \
 --cell_arch /cluster/home/erlingfo/autodeeplab/run/solis/5k/genotype.npy \
kill $GPU_MONITOR_PID
kill $CPU_MONITOR_PID
uname -a 
