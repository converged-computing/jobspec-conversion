#!/bin/bash
#FLUX: --job-name=XXX
#FLUX: -t=532800
#FLUX: --urgency=16

```
module load rcac
module load ngc
srun --mpi=pmi2 \
singularity run --nv -B ${PWD}:/host_pwd  lammpsGPU2022.sif \
lmp -k on g 3 -sf kk -pk kokkos cuda/aware on -in stay1000K.in >stay.rec
```
