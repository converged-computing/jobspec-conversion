#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=brown
#FLUX: -t=3600
#FLUX: --urgency=16

module load singularity
module --ignore-cache load CUDA
singularity run --nv -B /home/common/datasets/amazon_review_data_2018,/home/timp/repositories/bringo/data bridger.sif
