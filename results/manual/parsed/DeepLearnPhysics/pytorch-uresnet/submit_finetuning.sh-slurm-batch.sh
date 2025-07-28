#!/bin/bash
#FLUX: --job-name=uresnet_finetuning
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

WORKDIR=/cluster/kappa/90-days-archive/wongjiradlab/twongj01/pytorch-uresnet
DATADIR=/cluster/kappa/90-days-archive/wongjiradlab/twongj01/ssnet_training_data
CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/larbys/images/singularity-larbys-pytorch/singularity-larbys-pytorch-larcv1-nvidia384.66.img
module load singularity
singularity exec --nv ${CONTAINER} bash -c "cd ${WORKDIR} && source run_finetuning_job.sh ${WORKDIR} ${DATADIR}"
