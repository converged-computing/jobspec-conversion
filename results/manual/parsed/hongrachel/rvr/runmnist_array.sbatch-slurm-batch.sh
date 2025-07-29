#!/bin/bash
#SBATCH --job-name=runmnist
#SBATCH --output=outfiles/slurm-%A-%a.out
#SBATCH --error=outfiles/slurm-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=2500
#SBATCH --time=00:04:00

module load Anaconda3/5.0.1-fasrc01
module load cuda/9.0-fasrc02 cudnn/7.4.1.5_cuda9.0-fasrc01
source activate tf1.12_cuda9
source sweeps/mnist_sweep/array_commands/${SLURM_ARRAY_TASK_ID}.sh
