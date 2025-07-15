#!/bin/bash
#FLUX: --job-name=hairy-poodle-3721
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

singularity exec -e --pwd /app -B $(pwd)/logs:/app/logs,$(pwd)/data:/app/data,$(pwd)/configs:/app/configs --nv docker://spartan300/nianet:cae python main.py
