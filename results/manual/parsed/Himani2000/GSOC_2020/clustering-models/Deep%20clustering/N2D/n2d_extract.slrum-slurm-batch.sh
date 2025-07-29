#!/bin/bash
#SBATCH --job-name=n2d model 
#SBATCH --output=mygpu_n2d_extract.stdout
#SBATCH --mail-user=hxn147@case.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=70gb
#SBATCH --time=22:00:00
#SBATCH --constraint=gpuk40

module spider tensorflow/1.4.0-py3
module load intel/17 openmpi/2.0.1 
module load tensorflow/1.4.0-py3
echo "Running the n2d clustering algorithm"
python n2d_extract.py
echo "completed job "s
