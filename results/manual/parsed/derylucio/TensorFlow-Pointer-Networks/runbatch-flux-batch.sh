#!/bin/bash
#FLUX: --job-name=jigsaws_pointer
#FLUX: --queue=k80
#FLUX: -t=16200
#FLUX: --urgency=16

source  .env/bin/activate
module load python/3.5.0
module load cudnn/5.1
module load cuda80/blas/8.0.44
module load cuda80/toolkit/8.0.44
