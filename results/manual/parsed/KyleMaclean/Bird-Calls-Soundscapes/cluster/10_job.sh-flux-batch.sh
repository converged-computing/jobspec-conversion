#!/bin/bash
#FLUX: --job-name=crunchy-lemur-7251
#FLUX: --queue=csug
#FLUX: --urgency=16

module load nvidia/cuda-11.0
module load nvidia/cudnn-v8.0.180-forcuda11.0
papermill ./10_input_fresh.ipynb ./10_input_fresh_OUT.ipynb
