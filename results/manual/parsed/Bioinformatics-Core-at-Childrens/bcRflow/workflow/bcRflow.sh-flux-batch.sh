#!/bin/bash
#FLUX: --job-name=<bcr-nextflow>
#FLUX: -c=4
#FLUX: -t=259200
#FLUX: --urgency=16

export NXF_SINGULARITY_CACHEDIR='/path/to/bcRflow/singularity-images'
export SINGULARITY_CACHEDIR='/path/to/bcRflow/singularity-images'

unset TMPDIR
module purge
module load squashfs-tools/4.4 gcc/12.2.0 nextflow/23.04.2 singularity/3.9.6
export NXF_SINGULARITY_CACHEDIR=/path/to/bcRflow/singularity-images
export SINGULARITY_CACHEDIR=/path/to/bcRflow/singularity-images
cd /path/to/bcRflow/workflow
nextflow run ./main.nf -profile slurm -resume -work-dir ./work
