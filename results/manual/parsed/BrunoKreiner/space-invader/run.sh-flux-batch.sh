#!/bin/bash
#FLUX: --job-name=bloated-lizard-3725
#FLUX: -c=16
#FLUX: --queue=performance
#FLUX: -t=21600
#FLUX: --urgency=16

singularity pull docker://yanickschraner/rle-mini-challenge
singularity exec -B ${HOME}/rle-assginment:${HOME}/rle-assginment rle-mini-challenge_latest.sif ${HOME}/rle-assginment/dqn_example.py --mode train --nocuda --num_envs 16 --total_steps 10000000
