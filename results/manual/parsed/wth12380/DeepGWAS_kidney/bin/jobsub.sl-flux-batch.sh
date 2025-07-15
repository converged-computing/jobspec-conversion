#!/bin/bash
#FLUX: --job-name=moolicious-house-3868
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/nas/longleaf/home/wth12380/.conda/envs/RTensorFlow/lib/python3.10/site-packages/tensorrt_libs:$LD_LIBRARY_PATH'

module add anaconda/2023.03
module add cuda/11.4
module add r/4.1.3
export LD_LIBRARY_PATH=/nas/longleaf/home/wth12380/.conda/envs/RTensorFlow/lib/python3.10/site-packages/tensorrt_libs:$LD_LIBRARY_PATH
R CMD BATCH --no-restore 02-DeepGWAS_Kidney-train.R
