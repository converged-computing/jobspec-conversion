#!/bin/bash
#FLUX: --job-name=SAMDETR
#FLUX: -c=3
#FLUX: --queue=gpu_p2s
#FLUX: -t=54000
#FLUX: --urgency=16

module purge                      # nettoyer les modules herites par defaut
module load pytorch-gpu/py3/1.9.0 # charger les modules
set -x                            # activer l'echo des commandes
srun python -u my_app.py # executer son sc
