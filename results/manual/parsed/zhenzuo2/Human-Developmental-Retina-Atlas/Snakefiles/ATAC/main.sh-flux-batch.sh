#!/bin/bash
#FLUX: --job-name=gpu_job
#FLUX: --queue=gpu
#FLUX: -t=720000
#FLUX: --urgency=16

set -x
snakemake -j 5
