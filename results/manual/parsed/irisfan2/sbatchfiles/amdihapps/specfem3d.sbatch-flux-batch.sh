#!/bin/bash
#FLUX: --job-name=salted-peanut-4934
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run --pwd /opt/specfem3d/EXAMPLES/homogeneous_poroelastic --writable-tmpfs /shared/apps/bin/specfem3d_9c0626d1-20201122.sif /bin/bash ./run_this_example.sh
