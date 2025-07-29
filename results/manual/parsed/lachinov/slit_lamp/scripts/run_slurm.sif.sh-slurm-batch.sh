#!/bin/bash
#SBATCH --job-name=UPD_FRMWRK
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=40000
#SBATCH --time=2-00:00:00
#SBATCH --array=0-4

export SINGULARITYENV_CUDA_VISIBLE_DEVICES='$CUDA_VISIBLE_DEVICES'

module add cuDNN/8.0.5-CUDA-11.0.3
module list
echo $HOSTNAME
echo $CUDA_VISIBLE_DEVICES
echo $GPU_DEVICE_ORDINAL
export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES
singularity exec --nv -B /home/optima -B /optima ~/singularity/slamp.sif bash -c \
	"echo 'running from singularity' &&\
	nvidia-smi && \
    echo $CUDA_VISIBLE_DEVICES && \
    export MKL_DEBUG_CPU_TYPE=5 && \
	cd /home/optima/dlachinov/slit_lamp/scripts/ && \
	sleep $SLURM_ARRAY_TASK_ID &&\
	OMP_NUM_THREADS=4 python ./main_config_queue.py
	"
echo "finished"
