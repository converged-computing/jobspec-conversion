#!/bin/bash
#SBATCH --job-name=nf2_analytic
#SBATCH --output=/gpfs/gpfs0/robert.jarolim/nf2/logs/nf2_train_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=24000
#SBATCH --time=12:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=4

module load python/pytorch-1.6.0
cd /beegfs/home/robert.jarolim/projects/pub_NF2
python3 -m nf2.train.extrapolate_analytic --config config/multi_height/4tau.json
