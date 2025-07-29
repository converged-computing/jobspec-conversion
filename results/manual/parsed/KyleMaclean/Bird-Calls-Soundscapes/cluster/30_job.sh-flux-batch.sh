#!/bin/bash
#FLUX --job-name=quirky-blackbean-4112
#FLUX -c=4
#FLUX --queue=csug
#FLUX --urgency=16

module load nvidia/cuda-11.0
module load nvidia/cudnn-v8.0.180-forcuda11.0
papermill ./30_input.ipynb ./30_output.ipynb
