#!/bin/bash
#SBATCH --job-name=MGPU
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=60G
#SBATCH --time=01:00:00
#SBATCH --qos=allgpus

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo "JOB ID            = $SLURM_JOB_ID"
echo ""
echo "Hostname                       = $SLURM_NODELIST"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of CPUs on host         = $SLURM_CPUS_ON_NODE"
echo "GPUs                           = $GPU_DEVICE_ORDINAL"
nvidia-smi nvlink -gt d > nvlink_start-$SLURM_JOB_ID.out
nvidia-smi --query-gpu=index,timestamp,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv -l 5 > util-$SLURM_JOB_ID.csv &
singularity exec --nv -B .:/code -B output_data:/output_data tensorflow_keras.sif horovodrun -np $SLURM_NTASKS --mpi-args="-x NCCL_DEBUG=INFO" python /code/example.py
nvidia-smi nvlink -gt d > nvlink_end-$SLURM_JOB_ID.out
