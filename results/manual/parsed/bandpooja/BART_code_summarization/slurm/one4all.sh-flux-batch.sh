#!/bin/bash
#FLUX: --job-name=doopy-lizard-9384
#FLUX: -n=4
#FLUX: -t=86400
#FLUX: --urgency=16

module load gcc/9.3.0 arrow cuda/11 python/3.8
source /home/mjyothi/home/mjyothi/bart/bin/activate
python -m experiment.one4all.exp01 -o /home/mjyothi/scratch/one4all/run5 --cache_dir /home/mjyothi/home/mjyothi/cache --initial_wts_dir /home/mjyothi/home/mjyothi/initial_wts &> /home/mjyothi/scratch/one4all/run5/run.log
