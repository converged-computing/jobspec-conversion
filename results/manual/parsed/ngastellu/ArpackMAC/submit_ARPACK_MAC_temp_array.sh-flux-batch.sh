#!/bin/bash
#FLUX: --job-name=expressive-hippo-7007
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export KMP_BLOCKTIME='0'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export KMP_BLOCKTIME=0
module load julia
frame1=10000
nframes=1000
step=10
Ts=(40 100 200 300 400)
T=${Ts[SLURM_ARRAY_TASK_ID]}
tempdir="${T}K_initplanar_norotate"
if [[ ! -d  $tempdir ]]; then
	mkdir "$tempdir"
fi
cd $tempdir
cp ../run_files/* .
echo "Starting at: $(date)"
julia run_QuickArpackBigMAC_MD_multiframes.jl $T $frame1 $nframes $step
echo "Ending at: $(date)"
