#!/bin/bash
#FLUX: --job-name=S12CDM
#FLUX: -n=512
#FLUX: --queue=hpg2-compute
#FLUX: -t=172800
#FLUX: --priority=16

export OMPI_MCA_pml='ucx'
export OMPI_MCA_btl='^vader,tcp,openib'
export OMPI_MCA_oob_tcp_listen_mode='listen_thread'

module purge
module load intel/2018.1.163
module load openmpi/3.1.2
module load gsl/2.4
module load fftw/3.3.7
module list
export OMPI_MCA_pml="ucx"
export OMPI_MCA_btl="^vader,tcp,openib"
export OMPI_MCA_oob_tcp_listen_mode="listen_thread"
srun --mpi=pmix_v2 ./Arepo param.txt 1
