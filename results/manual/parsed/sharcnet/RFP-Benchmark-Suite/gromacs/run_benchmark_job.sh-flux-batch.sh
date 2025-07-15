#!/bin/bash
#FLUX: --job-name=scruptious-pedo-3312
#FLUX: -c=12
#FLUX: -t=1800
#FLUX: --priority=16

export gmx='/home/ppomorsk/gromacs_2024_build/gromacs-2024/build/bin/gmx'
export GMX_ENABLE_DIRECT_GPU_COMM='1'

module load StdEnv/2023 cmake gcc/12.3 cuda/12.2
export gmx=/home/ppomorsk/gromacs_2024_build/gromacs-2024/build/bin/gmx
export GMX_ENABLE_DIRECT_GPU_COMM=1
$gmx mdrun -ntmpi 4 -ntomp 12 -nb gpu -pme gpu -npme 1 -update gpu -bonded gpu -nsteps 100000 -resetstep 90000 -noconfout -dlb no -nstlist 300 -pin on -v -gpu_id 0123
grep Performance md.log
rm ener.edr
