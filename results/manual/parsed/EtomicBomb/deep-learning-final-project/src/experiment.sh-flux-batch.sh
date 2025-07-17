#!/bin/bash
#FLUX: --job-name=bumfuzzled-chip-0683
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
unset LD_LIBRARY_PATH
srun apptainer exec --nv /oscar/runtime/software/external/ngc-containers/tensorflow.d/x86_64.d/tensorflow-24.03-tf2-py3.simg python3 src/main.py "$@"
