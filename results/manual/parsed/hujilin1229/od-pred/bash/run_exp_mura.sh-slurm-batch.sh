#!/bin/bash
#SBATCH --account=aauhpc_gpu
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:2
#SBATCH --time=1-00:00:00

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
nvidia-smi
module load intel/2018.05
module load openmpi/3.0.2
srun -n 8 --exclusive python resnet_tf_hvd.py 
wait
