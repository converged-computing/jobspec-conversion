#!/bin/bash
#FLUX: --job-name=arid-lizard-1423
#FLUX: --priority=16

module load cuda/10.0.130
nvidia-smi
nvprof -f -o app.nvpf ./bin/app
