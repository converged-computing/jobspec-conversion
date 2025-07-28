#!/bin/bash
#FLUX: --job-name=$2
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

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
