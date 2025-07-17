#!/bin/bash
#FLUX: --job-name=red-caramel-4931
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load gcc/11.3.0
module load cuda/11.6.2
module load cudnn/8.4.0.27-11.6
source /spack/conda/miniconda3/4.12.0/bin/activate
source activate mftc
python predict_labels.py "mfrc" "full" "normal" 0.3
