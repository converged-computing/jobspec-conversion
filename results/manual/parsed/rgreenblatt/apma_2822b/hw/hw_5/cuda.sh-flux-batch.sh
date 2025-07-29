#!/bin/bash
#FLUX --job-name=psycho-gato-2445
#FLUX -n=8
#FLUX --queue=gpu
#FLUX -t=300
#FLUX --urgency=16

module load cuda/10.0.130
nvidia-smi
nvprof -f -o app.nvpf ./bin/app
