#!/bin/bash
#FLUX: --job-name=render_ftle
#FLUX: -N=16
#FLUX: -c=48
#FLUX: -t=600
#FLUX: --priority=16

module load cmake/3.13.2
module load gcc/8
module load LIBRARIES
module load boost/1_69_0
module load hdf5/1.10.4
module load inteltbb/2019
srun --mpi=pmi2 /rwthfs/rz/cluster/home/ad784563/source/pars/build/pars_benchmark/pars_benchmark 48 ./render_ftle.json
