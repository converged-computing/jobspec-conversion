#!/bin/bash
#FLUX: --job-name=salted-omelette-8668
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
source /shared/share/aac1plano.modules.bash
module purge
module load rocm-5.6.0
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
module avail
module list
rocm-smi
rocminfo
clinfo
tuned-adm active
which srun
which singularity
which python3
pip3 list
which gcc
singularity --version
python3 --version
gcc --version
g++ --version
amdclang --version
hipcc --version
cmake --version
wait
