#!/bin/bash
#FLUX: --job-name=AtariDQN
#FLUX: --priority=16

set -euxo pipefail
source ${MODULESHOME}/init/bash
module add openmind/singularity/2.2.1
module add openmind/miniconda/4.0.5-python3  
module add openmind/cuda/8.0
module add openmind/cudnn/8.0-5.1
singularity pull shub://1858
singularity pull shub://xboix/singularity:tensorflow
singularity exec -B /om:/om /om/user/tkreiman/singularity/xboix-singularity-tensorflow.img \
python /om/user/tkreiman/GymProjects/AtariDQN
