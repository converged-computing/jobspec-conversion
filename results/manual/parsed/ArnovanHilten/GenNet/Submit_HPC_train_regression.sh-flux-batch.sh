#!/bin/bash
#FLUX: --job-name=GenNet_regression
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=432000
#FLUX: --urgency=16

module purge
module load 2021
module load CUDA/11.3.1
module load cuDNN/8.2.1.32-CUDA-11.3.1
source $HOME/env_GenNet/bin/activate
cd /home/ahilten/repositories/GenNet/
python GenNet.py train /home/ahilten/repositories/pheno_height/Input_files/ $1 -genotype_path /projects/0/emc17610/nvidia/UKBB_HRC_imputed/genotype/ -problem_type regression -lr $2 -bs $3 -L1 $4 -network_name regression_height -epoch_size=50000 -patience=50
