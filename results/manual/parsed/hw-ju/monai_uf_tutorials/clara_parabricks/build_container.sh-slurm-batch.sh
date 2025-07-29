#!/bin/bash
#FLUX: --job-name=crunchy-lamp-0924
#FLUX: -c=2
#FLUX: -t=28800
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity pull /blue/vendor-nvidia/hju/clara-parabricks-4.0.1-1 docker://nvcr.io/nvidia/clara/clara-parabricks:4.0.1-1
