#!/bin/bash
#FLUX: --job-name=example
#FLUX: --queue=v6_384
#FLUX: --urgency=16

module load gcc/10.2.0
module load cmake/3.21.2
module load python/3.9.6
module load oneAPI/2022.1
module load mpi/intel/2022.1
mpirun ../build/dqmc --config ../example/config.toml --fields ../example/output/fields.out --output ../example/output
module purge
exit 0
