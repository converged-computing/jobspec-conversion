#!/bin/bash
#FLUX: --job-name=np
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

srun -u python scraper.py
