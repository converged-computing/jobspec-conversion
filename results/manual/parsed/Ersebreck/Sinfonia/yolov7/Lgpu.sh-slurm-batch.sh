#!/bin/bash
#SBATCH --job-name=frame_d
#SBATCH --output=frame_ps.log
#SBATCH --mail-user=es.lozano@uniandes.edu.co
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=01:00:00

echo "Soy un JOB de prueba en GPU"
nvidia-smi
python YoloRos.py
