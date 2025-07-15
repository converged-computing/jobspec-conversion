#!/bin/bash
#FLUX: --job-name=phi-2
#FLUX: --urgency=16

module load miniconda/22.11.1-1
conda activate harness
nvidia-smi
cd /work/pi_dhruveshpate_umass_edu/vdorna_umass_edu/SmallLMReasoning
bash eval-scripts/phi2-gsm8k.sh
echo "Done"
