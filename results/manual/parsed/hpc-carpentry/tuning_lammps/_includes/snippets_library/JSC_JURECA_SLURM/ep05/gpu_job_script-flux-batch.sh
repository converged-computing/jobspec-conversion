#!/bin/bash
#FLUX: --job-name=conspicuous-peas-2706
#FLUX: --queue=develgpus
#FLUX: -t=600
#FLUX: --priority=16

module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/9Jan2020-cuda
srun lmp -in in.lj -sf gpu -pk gpu 4 neigh no newton off split -1.0
