#!/bin/bash
#FLUX: --job-name=sc_velo
#FLUX: --queue=shortterm
#FLUX: --priority=16

PATH=$WORK/.omics/anaconda3/bin:$PATH #add the anaconda installation path to the bash path
source $WORK/.omics/anaconda3/etc/profile.d/conda.sh # some reason conda commands are not added by default
conda activate scVelocity
module load nextflow/v22.04.1
cp * $SCRATCH/
cp -r ../src $SCRATCH/
cd $SCRATCH
nextflow run sc_velo.nf -params-file sc_velo_params.yaml --id ${SCRATCH/"/scratch/"/}
