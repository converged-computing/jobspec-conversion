#!/bin/bash
#SBATCH --job-name=transcribeonsets
#SBATCH --output=transcribeOutput.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu
#SBATCH --mem=51200
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=1

module load python3/intel/3.6.3 cuda/9.0.176 nccl/cuda9.0/2.4.2
python transcribe.py runs/model/model-25000.pt Nuvole_Bianche.wav --save-path output_transcribe1/
