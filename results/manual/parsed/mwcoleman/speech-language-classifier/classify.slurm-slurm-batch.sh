#!/bin/bash
#SBATCH --account=punim1410
#SBATCH --output=/home/ivrik/sounds/modelo.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=20G
#SBATCH --time=5-00:00:00
#SBATCH --qos=gpgpuresplat

module load gcccore/8.3.0
module load python/3.7.4
module purge
module load fosscuda/2019b
module load tensorflow/2.1.0-python-3.7.4
module load  python/3.7.4
cd ~/sounds
python model.py  ${OPTS} &> model${VAR}.log
