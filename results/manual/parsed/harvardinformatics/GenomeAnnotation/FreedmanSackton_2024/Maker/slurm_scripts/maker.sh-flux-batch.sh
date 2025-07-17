#!/bin/bash
#FLUX: --job-name=persnickety-plant-2527
#FLUX: --exclusive
#FLUX: --queue=shared,bigmem
#FLUX: -t=255600
#FLUX: --urgency=16

export SINGULARITYENV_LIBDIR='${PWD}/LIBDIR'

MAKER_IMAGE=/n/singularity_images/informatics/maker/maker_3.01.03--pl5262h8f1cd36_2-repbase.sif
export SINGULARITYENV_LIBDIR=${PWD}/LIBDIR
mkdir -p LIBDIR
singularity exec ${MAKER_IMAGE} sh -c 'ln -sf /usr/local/share/RepeatMasker/Libraries/* LIBDIR'
singularity exec --home /opt/gm_key --no-home --cleanenv ${MAKER_IMAGE} mpiexec -n $((SLURM_CPUS_ON_NODE*3/4)) maker -fix_nucleotides -nodatastore
