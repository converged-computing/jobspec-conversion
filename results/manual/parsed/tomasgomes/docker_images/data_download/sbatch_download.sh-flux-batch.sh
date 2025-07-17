#!/bin/bash
#FLUX: --job-name=download_data
#FLUX: -c=6
#FLUX: -t=21600
#FLUX: --urgency=16

singularity run --mount type=bind,src=$(pwd),dst=/rootvol /mnt/beegfs/singularity/images/data_download_nextflow.sif run nf-core/fetchngs --max_memory 31GB --max_cpus 6 --input /rootvol/ids.csv --outdir /rootvol/
