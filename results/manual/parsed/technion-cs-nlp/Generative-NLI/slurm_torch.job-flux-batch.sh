#!/bin/bash
#FLUX: --job-name=sticky-cattywampus-1764
#FLUX: --priority=16

srun --container-image ~/pytorch:21.05-py3.sqsh --container-mounts /home/dimion/PremiseGeneratorBert/ sh -c 'cd /home/dimion/PremiseGeneratorBert/ && python $@'
