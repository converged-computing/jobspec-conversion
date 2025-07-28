#!/bin/bash
#FLUX: --job-name=mk13_{i}_{log_name}
#FLUX: --queue={partition}
#FLUX: --urgency=16

ml Singularity
cd $HOME/unet
singularity exec --nv --bind /scratch:/scratch tensorflow_1.10.1-devel-gpu-py3.sif python {python_script}
