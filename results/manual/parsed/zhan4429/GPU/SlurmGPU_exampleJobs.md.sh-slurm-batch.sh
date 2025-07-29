#!/bin/bash
#SBATCH --job-name=XXX
#SBATCH --account=XXXXX
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6-04:00:00
#SBATCH --constraint=ntasks-per-node=16

```
module load rcac
module load ngc
srun --mpi=pmi2 \
singularity run --nv -B ${PWD}:/host_pwd  lammpsGPU2022.sif \
lmp -k on g 3 -sf kk -pk kokkos cuda/aware on -in stay1000K.in >stay.rec
```
