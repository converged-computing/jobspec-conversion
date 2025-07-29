#!/bin/bash
#SBATCH --job-name=gfn
#SBATCH --output=/network/scratch/a/alex.hernandez-garcia/logs/gflownet/slurm/slurm-%j-%x.out
#SBATCH --error=/network/scratch/a/alex.hernandez-garcia/logs/gflownet/slurm/slurm-%j-%x.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=24gb
#SBATCH --partition=long

echo "Arg 0: $0"
echo "Arg 1: $1"
argshydra=$(echo $@ | cut -d " " -f1 --complement)
echo "Hydra arguments: $argshydra"
rsync -av --relative "$1" $SLURM_TMPDIR --exclude ".git"
cd $SLURM_TMPDIR/"$1"
sh setup_gflownet.sh $SLURM_TMPDIR/venv
echo "Currently using:"
echo $(which python)
echo "in:"
echo $(pwd)
echo "sbatch file name: $0"
python main.py $argshydra
