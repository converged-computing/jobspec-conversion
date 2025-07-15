#!/bin/bash
#FLUX: --job-name=goodbye-snack-7486
#FLUX: --urgency=16

module load nvidia/cuda-11.0
module load nvidia/cudnn-v8.0.180-forcuda11.0
papermill ./30_input.ipynb ./30_output.ipynb
