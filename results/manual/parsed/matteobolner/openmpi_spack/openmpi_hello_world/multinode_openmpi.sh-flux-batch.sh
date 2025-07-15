#!/bin/bash
#FLUX: --job-name=fuzzy-parsnip-4159
#FLUX: -N=2
#FLUX: --queue=skl_usr_prod
#FLUX: -t=60
#FLUX: --priority=16

module use /marconi_work/ExaF_prod_0/spack/opt/spack/linux-centos7-broadwell/gcc-7.3.0/openmpi-4.0.1-tsuqdoly7rjs3vy6dk5pugjj4so3cu26
module load openmpi-4.0.1-gcc-7.3.0-tsuqdol
srun -display-allocation -N $SLURM_NTASKS hello
