#!/bin/bash
#SBATCH --job-name=ezCGP_simgan
#SBATCH --output=simgant.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=128gb
#SBATCH --time=5-00:08:00
#SBATCH --constraint=TeslaV100S-PCIE-32GB

echo "Started on `/bin/hostname`" # prints name of compute node job was started on
nvidia-smi
if [ -z "$1" ]
then
      setseed=""
else
      setseed="--seed $1"
fi
if [ -z "$2" ]
then
      setprevrun=""
else
      setprevrun="--previous_run $2"
fi
cd ~/ezCGP
module load anaconda3/2020.02
module load cuda/10.1
conda activate simgan-cgp
rm -rf ~/.nv
python main.py -p problem_simgan -v $setseed $setprevrun
