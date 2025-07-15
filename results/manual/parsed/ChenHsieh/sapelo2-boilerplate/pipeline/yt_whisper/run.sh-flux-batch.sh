#!/bin/bash
#FLUX: --job-name=whisper
#FLUX: -c=8
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

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
