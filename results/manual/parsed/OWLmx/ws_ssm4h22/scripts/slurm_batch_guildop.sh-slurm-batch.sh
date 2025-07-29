#!/bin/bash
#SBATCH --job-name=misinfo
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --exclude=icsnode05,icsnode06

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export TOKENIZERS_PARALLELISM='false'

. ~/miniconda3/etc/profile.d/conda.sh
echo "[$1] Activating env...."
. env_activate.sh
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export TOKENIZERS_PARALLELISM=false
echo "Running script ...."
if [ -z "$2" ]
  then
    echo "New Run"
    guild run -y $1
  else
    echo "Restarting Run [$2]"
    guild run -y $1 --force-sourcecode --restart $2
fi
echo "---------- FINALIZED -------------"
