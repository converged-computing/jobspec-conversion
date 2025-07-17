#!/bin/bash
#FLUX: --job-name=zyf_thesis
#FLUX: -c=4
#FLUX: --queue=day
#FLUX: -t=86400
#FLUX: --urgency=16

cp -R /common/datasets/MNIST/ /scratch/$SLURM_JOB_ID/
singularity exec /common/singularityImages/TCML-Cuda10_0_TF1_15_2_PT1_4.simg python3 ~/evaluation.py ~/model/ /scratch/$SLURM_JOB_ID/MNIST/
echo DONE!
