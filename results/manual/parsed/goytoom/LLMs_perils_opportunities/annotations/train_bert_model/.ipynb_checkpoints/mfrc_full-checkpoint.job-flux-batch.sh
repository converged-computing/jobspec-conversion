#!/bin/bash
#FLUX: --job-name=quirky-lentil-3643
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home1/sabdurah/.conda/envs/DT/lib/python3.7/site-packages/tensorrt'

module purge
module load gcc/11.3.0
module load cuda/11.6.2
module load cudnn/8.4.0.27-11.6
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home1/sabdurah/.conda/envs/DT/lib/python3.7/site-packages/tensorrt
source /spack/conda/miniconda3/4.12.0/bin/activate
source activate mftc
python train_classifier.py "mfrc" "full" "final"
