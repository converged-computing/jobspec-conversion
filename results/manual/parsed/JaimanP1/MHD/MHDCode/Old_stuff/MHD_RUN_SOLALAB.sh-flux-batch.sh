#!/bin/bash
#FLUX: --job-name=conspicuous-platanos-2001
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --priority=16

module purge > /dev/null 2>&1
module use /opt/site/easybuild/modules/all/Core
module load GCC/9.3.0 OpenMPI/4.0.3
echo "Starting job at: "
date
srun ./mhd_run
echo "Finished"
date
