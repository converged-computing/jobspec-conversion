#!/bin/bash
#FLUX: --job-name=KavehJob2
#FLUX: --queue=lrgmem
#FLUX: -t=86400
#FLUX: --priority=16

module reset
module load python/2.7
python -m pip install --user --no-cache-dir -r requirements.txt 
python run_parallel.py
