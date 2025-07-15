#!/bin/bash
#FLUX: --job-name=upload
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --priority=16

cd /home/mila/c/chris.emezue/scratch/pet-masakhane-results2/pet-masakhane
module load python/3
module load cuda/11.0/cudnn/8.0
source /home/mila/c/chris.emezue/scratch/pet-env/bin/activate
gdrive upload -r -p 1jtCdy0-TPDRkA_9BXys5JMCR0C9-SRGB results_pet/
