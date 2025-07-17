#!/bin/bash
#FLUX: --job-name=preprocess_kp20k
#FLUX: --queue=smp
#FLUX: -t=518400
#FLUX: --urgency=16

cmd="srun python -m preprocess -config config/preprocess/config-preprocess-keyphrase-kp20k.yml"
echo $cmd
$cmd
