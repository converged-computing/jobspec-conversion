#!/bin/bash
#SBATCH --job-name=ddc model 
#SBATCH --output=mygpu_ddc.stdout
#SBATCH --mail-user=hxn147@case.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=70gb
#SBATCH --time=22:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=gpuk40

module spider tensorflow/1.4.0-py3
module load intel/17 openmpi/2.0.1 
module load tensorflow/1.4.0-py3
python DDC.py
echo "completed job "s
