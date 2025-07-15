#!/bin/bash
#FLUX: --job-name=rainbow-blackbean-8855
#FLUX: -c=24
#FLUX: --queue=teramem_inter
#FLUX: -t=57600
#FLUX: --priority=16

export OMP_NUM_THREADS='24'

export OMP_NUM_THREADS=24
source /etc/profile.d/modules.sh
module load python/3.6_intel 
source activate rnaseq 
SAMPLE_SHEET="samples.csv"
nextflow run nf-core/rnaseq --input $SAMPLE_SHEET -r 3.2 --max_cpus 24 --max_memory '250.GB' --genome GRCm38 -profile charliecloud -resume wise_minsky
