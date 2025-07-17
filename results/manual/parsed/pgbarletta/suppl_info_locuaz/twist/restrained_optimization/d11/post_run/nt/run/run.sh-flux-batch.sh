#!/bin/bash
#FLUX: --job-name=nt_npt
#FLUX: -c=8
#FLUX: --queue=m100_usr_prod
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'
export OMP_PLACES='threads'
export GMX_GPU_DD_COMMS='true'
export GMX_GPU_PME_PP_COMMS='true'
export GMX_FORCE_UPDATE_DEFAULT_GPU='true'

module load profile/lifesc
module load autoload gromacs/2022
export OMP_NUM_THREADS=8
export OMP_PLACES=threads
export GMX_GPU_DD_COMMS=true
export GMX_GPU_PME_PP_COMMS=true
export GMX_FORCE_UPDATE_DEFAULT_GPU=true
num_mpi='1'
cd $SLURM_SUBMIT_DIR
gpu_idx=0
thread_idx=8
mol='d11'
mdp="/m100_work/AIRC_Fortun21/barletta/twist/run/mdp/npt_250ns.mdp"
gmx_thread_mpi mdrun -ntomp $OMP_NUM_THREADS -ntmpi $num_mpi -nb gpu -pme gpu -bonded gpu -deffnm npt_${mol} -pin on -pinoffset ${thread_idx} -gpu_id ${gpu_idx} -cpi npt_${mol}
