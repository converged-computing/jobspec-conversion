#!/bin/bash
#FLUX: --job-name=res
#FLUX: -c=2
#FLUX: --queue=gpu_p2s
#FLUX: -t=172800
#FLUX: --urgency=16

module purge # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.11.0 
ulimit -n 4096
set -x # activer l’echo des commandes
cd $WORK/isic2018
srun python -u generate_result.py --loss_type CHML4 --weighting_type CS --hm_delay_type epoch --max_thresh 0.3
