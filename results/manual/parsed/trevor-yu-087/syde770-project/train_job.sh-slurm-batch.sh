#!/bin/bash
#SBATCH --account=def-s2mclach
#SBATCH --mail-user=jh3chu@uwaterloo.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64000M
#SBATCH --time=02:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Hello World"
nvidia-smi
module load python/3.10 cuda cudnn
source ~/envs/lstm-transf/bin/activate
cd ~/workspace/syde770-project
tensorboard --logdir="~/scratch/lstm-transformer/outputs" --host 0.0.0.0 --load_fast false &
python run.py run ~/scratch/lstm-transformer/subjects_2023-07-12/cc_data.json ~/scratch/lstm-transformer/outputs cnn-transformer --enable-checkpoints
