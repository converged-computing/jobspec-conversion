#!/bin/bash
#FLUX: --job-name=bloated-pastry-0552
#FLUX: -t=60
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export KMP_BLOCKTIME='0'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export KMP_BLOCKTIME=0
nn=$SLURM_ARRAY_TASK_ID
if [[ ! -d sample-${nn} ]]; then
	mkdir sample-${nn}
else
	rm sample-${nn}/*
fi
cp run_files/* sample-${nn}
cd sample-${nn}
julia runARPACK_MAC.jl ~/scratch/clean_bigMAC/10x10/relax/relaxed_structures/bigMAC-${nn}_relaxed.xsf
