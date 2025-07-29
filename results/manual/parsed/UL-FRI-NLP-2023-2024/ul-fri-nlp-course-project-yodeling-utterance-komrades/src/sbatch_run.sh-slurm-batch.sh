#!/bin/bash
#FLUX: --job-name=nlp-baseline
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

FILE=baseline.py
module load CUDA/12.1.1
srun singularity exec --nv ./containers/container-torch.sif python "baseline_run.py"
