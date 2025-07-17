#!/bin/bash
#FLUX: --job-name=expensive-lamp-3422
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "cp -r /benchmark ./"
singularity run --bind ./benchmark:/benchmark /shared/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark BSF --ngpus 1"
singularity run --bind ./benchmark:/benchmark /shared/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark tgv --ngpus 1"
