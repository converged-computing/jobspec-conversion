#!/bin/bash
#SBATCH --job-name=jupyterAE
#SBATCH --output=/home/lgaudet/slurm_output_logs/log_%j.out
#SBATCH --error=/home/lgaudet/slurm_error_logs/error_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1gb
#SBATCH --time=08:00:00
#SBATCH --qos=normal

docker run -v /home/aevans:/home/aevans -v /raid/NYSM:/home/aevans/NYSM --name=jupyter_ae -w /home/aevans -u aevans --runtime=nvidia --gpus=1 -p 8886:88
88 akurbanovas/ae.ai2es:v0.1 /opt/conda/bin/jupyter lab --port=8888 --ip=0.0.0.0 --allow-root --no-browser /home/aevans
88 akurbanovas/lg.ai2es:v0.2 python job.py
