#!/bin/bash
#FLUX: --job-name=Jul6_Cont_SS_HKNN_job
#FLUX: --queue=celltypes
#FLUX: -t=864000
#FLUX: --urgency=16

mkdir $TMPDIR/tmp
singularity exec --bind=/scratch/fast/$SLURM_JOBID/tmp:/tmp docker://alleninst/mapping_on_hpc Rscript R_scripts/Cont_SS_HKNN.R > logfiles/Jul6_Cont_SS_HKNN_logfile
