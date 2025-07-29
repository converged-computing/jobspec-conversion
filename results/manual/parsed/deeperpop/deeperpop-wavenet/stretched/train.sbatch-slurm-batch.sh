#!/bin/bash
#SBATCH --job-name=tf-wavenet-stretched
#SBATCH --output=train.log
#SBATCH --mail-user=brinton@cs.stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=08:00:00

export LD_LIBRARY_PATH='..:$LD_LIBRARY_PATH'

source /usr/share/lmod/lmod/init/bash
module load cudnn
source ../bin/activate
export LD_LIBRARY_PATH="/farmshare/software/free/cudnn/6.0/lib64/:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="..:$LD_LIBRARY_PATH"
source train.sh
