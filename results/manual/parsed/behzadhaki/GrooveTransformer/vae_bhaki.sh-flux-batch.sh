#!/bin/bash
#FLUX: --job-name=milky-dog-6548
#FLUX: -c=8
#FLUX: -t=28800
#FLUX: --urgency=16

export PATH='$HOME/.conda/envs/GrooveTransformer/bin:$PATH'
export WANDB_API_KEY='API_KEY'

source /etc/profile.d/lmod.sh
source /etc/profile.d/zz_hpcnow-arch.sh
module load Anaconda3/2020.02
export PATH="/soft/easybuild/x86_64/software/Anaconda3/2020.02/bin:$PATH"
export PATH="$HOME/.conda/envs/GrooveTransformer/bin:$PATH"
source /soft/easybuild/x86_64/software/Anaconda3/2020.02/etc/profile.d/conda.sh
conda activate GrooveTransformer
export WANDB_API_KEY=API_KEY
python -m wandb login
cd GrooveTransformer
python train.py
