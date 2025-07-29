#!/bin/bash
#SBATCH --job-name=whisper
#SBATCH --output=whisper.%j.out
#SBATCH --error=whisper.%j.err
#SBATCH --mail-user=youremail@uga.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=32gb
#SBATCH --time=04:00:00
#SBATCH --partition=batch

date
ml Nextflow
ml Anaconda3
ml FFmpeg
ml snakemake
cd $SLURM_SUBMIT_DIR
conda init bash
source ~/.bashrc
conda activate video_transcript
snakemake --cores all --config youtube_url="https://www.youtube.com/watch?v=EiEXiuawcq8"
date
