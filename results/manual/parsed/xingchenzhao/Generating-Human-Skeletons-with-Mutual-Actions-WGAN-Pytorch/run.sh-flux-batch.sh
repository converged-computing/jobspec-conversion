#!/bin/bash
#FLUX: --job-name=run_gan
#FLUX: --queue=gtx1080
#FLUX: -t=18000
#FLUX: --urgency=16

module purge #make sure the modules environment is sane
module load python/3.7.0 cuda/10.1 venv/wrap
workon pytorch
python vae0_train.py > vae_result.txt
python gan0_train.py > gan_result.txt
