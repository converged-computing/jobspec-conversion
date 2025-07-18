#!/bin/bash
#FLUX: --job-name=Regr_GenNet
#FLUX: -n=15
#FLUX: --queue=long
#FLUX: -t=2592000
#FLUX: --urgency=16

module purge
module load Python/3.7.4-GCCcore-8.3.0
module load libs/cuda/10.1.243
module load libs/cudnn/7.6.5.32-CUDA-10.1.243
module load TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
source $HOME/venv_GenNet_37/bin/activate
CUDA_VISIBLE_DEVICES='', python GenNet.py train -path /trinity/home/avanhilten/repositories/UK_biobank/15_gennet_genotyped/height_regressed_out_QC/ -ID $1 -genotype_path /data/scratch/avanhilten/UK_biobank_genotype_not_imputed/genotype/ -problem_type regression -lr $2 -bs $3 -L1 $4 -epoch_size 50000  -resume -network_name $5 -filters $6
