#!/bin/bash
#FLUX: --job-name=test_wrapper
#FLUX: -t=90
#FLUX: --priority=16

singularity run --mount type=bind,src=$(pwd),dst=/rootvol \
        /mnt/beegfs/singularity/images/nextflow_kallisto_sc.sif run \
        /rootvol/kallisto_pipeline.nf
