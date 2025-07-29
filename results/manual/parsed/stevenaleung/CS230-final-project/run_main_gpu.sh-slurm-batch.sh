#!/bin/bash
#SBATCH --job-name=$2
#SBATCH --output=$2-%j.out
#SBATCH --error=$2-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=08:00:00
#SBATCH --partition=normal

echo $1
echo $2
if (($#<2))
then
    echo 'not enough input variables'
    exit
fi
if [[ "$HOSTNAME" = *"rice"* ]]; then
sbatch <<SLURM
module load cuda
module load cudnn
source venv_gpu/bin/activate
$1
SLURM
fi
if [[ "$HOSTNAME" = *"sh-ln"* ]]; then
sbatch <<SLURM
module purge
module load python/3.6.1
source venv/bin/activate
module load py-tensorflow/1.5.0_py36
$1
SLURM
fi
