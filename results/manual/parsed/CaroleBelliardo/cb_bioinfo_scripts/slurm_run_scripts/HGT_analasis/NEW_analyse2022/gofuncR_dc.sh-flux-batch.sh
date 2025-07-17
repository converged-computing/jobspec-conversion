#!/bin/bash
#FLUX: --job-name=gofunc
#FLUX: -c=8
#FLUX: --queue=all
#FLUX: --urgency=16

module load singularity/3.5.3 
IMG='/lerins/hub/projects/25_tools/GOfuncR/GOFunc.sif'
singularity run -B "/lerins/hub" -B "/work/$USER" $IMG snakemake --snakefile /lerins/hub/DB/WORKFLOW/GOfuncR/Snakefile -j $SLURM_CPUS_PER_TASK --configfile ${path}/param.yaml
