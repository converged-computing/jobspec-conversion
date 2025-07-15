#!/bin/bash
#FLUX: --job-name=test
#FLUX: --gpus-per-task=1
#FLUX: --queue=RTXA6000
#FLUX: --priority=16

srun -K --container-mounts=/netscratch/$USER:/netscratch/$USER,/home/$USER/.cache_slurm:/root/.cache,/ds:/ds:ro,"`pwd`":"`pwd`" \
--container-image=/netscratch/enroot/nvcr.io_nvidia_pytorch_21.07-py3.sqsh \
--container-workdir="`pwd`" \
training_scripts/cluster/wrapper.sh \
python training_scripts/sweeps/start_agent.py -c 1
