#!/bin/bash
#FLUX: --job-name=hello-mpi
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=60
#FLUX: --urgency=16

export OMPI_MCA_btl_sm_eager_limit='8192'
export OMPI_MCA_btl_vader_eager_limit='8192'
export OMPI_MCA_mpi_show_mca_params='all'

export OMPI_MCA_btl_sm_eager_limit=8192
export OMPI_MCA_btl_vader_eager_limit=8192
export OMPI_MCA_mpi_show_mca_params=all
mpirun --verbose -np $SLURM_NTASKS ./hello
module load likwid
srun --mpi=pmix -n2 likwid-perfctr -C 0-3 -g CLOCK ./hello_world
