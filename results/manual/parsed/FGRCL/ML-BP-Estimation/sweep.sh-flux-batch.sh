#!/bin/bash
#FLUX: --job-name=scruptious-noodle-5907
#FLUX: -c=4
#FLUX: -t=432000
#FLUX: --urgency=16

sbatch <<EOT
module load python/3.10 cuda cudnn
source venv/bin/activate
pip install --no-index --upgrade pip
pip install -r requirements.txt
export $(cat .env | xargs)
wandb agent --count 1 $1
EOT
