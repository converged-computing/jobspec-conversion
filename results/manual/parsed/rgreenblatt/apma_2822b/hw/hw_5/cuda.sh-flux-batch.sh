#!/bin/bash
#FLUX: --job-name=misunderstood-knife-6007
#FLUX: --urgency=16

module load cuda/10.0.130
nvidia-smi
nvprof -f -o app.nvpf ./bin/app
