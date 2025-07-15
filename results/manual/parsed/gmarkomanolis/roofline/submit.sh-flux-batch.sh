#!/bin/bash
#FLUX: --job-name=lu_c_16
#FLUX: -t=180
#FLUX: --priority=16

module swap PrgEnv-cray/5.2.82 PrgEnv-intel
module load advisor/2018.1.1.535164
module swap intel/15.0.2.164 intel/17.4.4.196
srun -n 16 --hint=nomultithread --threads-per-core=1 --multi-prog ./config_initial.txt
exit 0
