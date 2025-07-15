#!/bin/bash
#FLUX: --job-name=creamy-hippo-0708
#FLUX: -t=7200
#FLUX: --urgency=16

export gmx='/scratch/s/scinet/rzon/gmxb/gromacs-2024/gmx_install/bin/gmx'
export GMX_ENABLE_DIRECT_GPU_COMM='1'

module load cmake cuda/12.3.1 gcc/12.3.0
nvidia-smi
export gmx="/scratch/s/scinet/rzon/gmxb/gromacs-2024/gmx_install/bin/gmx"
export GMX_ENABLE_DIRECT_GPU_COMM=1
cd "/scratch/s/scinet/rzon/gmxb/gromacs-2024/gmx_run"
$gmx mdrun -ntmpi 8 -ntomp 16 -nb gpu -pme gpu -npme 1 -update gpu -bonded gpu -nsteps 100000 -resetstep 90000 -noconfout -dlb no -nstlist 300 -pin on -v -gpu_id 0123
grep Performance md.log
rm ener.edr
