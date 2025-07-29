#!/bin/bash
#FLUX: --job-name=cyaneapopgen
#FLUX: -c=32
#FLUX: --queue=ycga_bigmem
#FLUX: -t=172800
#FLUX: --urgency=16

module purge # Unload any existing modules that might conflict
module load SAMtools
module load BWA
module load picard
module load BCFtools
module load miniconda
module load BEDTools
module load Trimmomatic
module load FastQC
module list
conda activate snakemake
snakemake --scheduler greedy --verbose --rerun-incomplete --cores $SLURM_CPUS_PER_TASK --latency-wait 60
