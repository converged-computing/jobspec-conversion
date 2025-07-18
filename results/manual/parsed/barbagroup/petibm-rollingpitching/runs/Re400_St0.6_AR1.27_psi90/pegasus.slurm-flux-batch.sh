#!/bin/bash
#FLUX: --job-name=Re400_St0.6_AR1.27_psi90
#FLUX: -N=2
#FLUX: --queue=small-gpu
#FLUX: -t=72000
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1'

module load singularity/3.4.2
module load openmpi/gcc/64/3.1.4
ib=/etc/libibverbs.d
declare -a libs=(
/lib64/libibverbs/*
/lib64/libmlx5.so*
/lib64/libibverbs.so*
/lib64/libnl*.so*
)
libdir="/usr/local/nvidia/lib"
for lib in "${libs[@]}"; do
	ib="$lib:$libdir/$(basename $lib),$ib"
done
printf "\n*** SLURM JOB SCRIPT ***\n"
cat pegasus.slurm
printf "\n*** PRESENT WORKING DIRECTORY  ***\n"
pwd
printf "\n*** NVIDIA-SMI ***\n"
export CUDA_VISIBLE_DEVICES=0,1
nvidia-smi
printf "\n*** JOB ID ***\n"
echo $SLURM_JOB_ID
printf "\n*** JOB NODE LIST ***\n"
echo $SLURM_JOB_NODELIST
simudir="/lustre/groups/barbalab/mesnardo/rollingpitching/Re400_St0.6_AR1.27_psi90-2"
indir="/mnt"
img="/SEAS/home/mesnardo/images/petibm-rollingpitching_petibm0.5.1-xenial.sif"
printf "\n*** STARTING CONTAINERIZED JOB ***\n"
mpirun singularity exec \
	--bind $ib,$simudir:$indir \
	--nv $img petibm-rollingpitching \
	-directory $indir \
	-probes $indir/probes.yaml \
	-options_left \
	-log_view ascii:$indir/view.log
