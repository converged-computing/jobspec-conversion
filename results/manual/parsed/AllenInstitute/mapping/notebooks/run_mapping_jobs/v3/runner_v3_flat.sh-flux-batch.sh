#!/bin/bash
#FLUX: --job-name=v3_flat_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

mkdir $TMPDIR/tmp
singularity exec --bind=/scratch/fast/$SLURM_JOBID/tmp:/tmp docker://alleninst/mapping_on_hpc Rscript R_scripts/v3_flat.R > logfiles/v3_flat_logfile
