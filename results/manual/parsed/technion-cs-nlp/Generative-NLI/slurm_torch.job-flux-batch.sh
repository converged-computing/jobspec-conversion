#!/bin/bash
#FLUX: --job-name=confused-squidward-4504
#FLUX: --urgency=16

srun --container-image ~/pytorch:21.05-py3.sqsh --container-mounts /home/dimion/PremiseGeneratorBert/ sh -c 'cd /home/dimion/PremiseGeneratorBert/ && python $@'
