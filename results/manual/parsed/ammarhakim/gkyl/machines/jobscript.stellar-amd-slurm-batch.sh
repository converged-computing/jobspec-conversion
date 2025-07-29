#!/bin/bash
#SBATCH --job-name=gkyl
#SBATCH --mail-user=jdoe@msn.com
#SBATCH --mail-type=END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=00:30:00
#SBATCH --qos=pppl-short

export gComDir='$HOME/gkylsoft/gkyl/bin'

module load gcc/8
module load cudatoolkit/12.0
module load openmpi/cuda-11.1/gcc/4.1.1
module load anaconda3/2020.11
export gComDir="$HOME/gkylsoft/gkyl/bin"
echo 'srun -n 1 --gpus 2 '$gComDir'/gkyl -g input_file.lua'
srun -n 1 --gpus 2 $gComDir/gkyl -g input_file.lua
exit 0
