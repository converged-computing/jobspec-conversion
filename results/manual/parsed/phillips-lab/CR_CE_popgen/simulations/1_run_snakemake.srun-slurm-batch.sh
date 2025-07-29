#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=phillips
#FLUX: -t=1440000
#FLUX: --urgency=16

dir="/projects/phillipslab/ateterina/slim/worms_snakemake"
cd $dir/sim30rep
snakemake -p --profile slurm --jobs 80
cd $dir/sim70rep
snakemake -p --profile slurm --jobs 80
cd $dir/simmut15
snakemake -p --profile slurm --jobs 80
cd $dir/neutral_extra
snakemake -p --profile slurm --jobs 80
cd $dir/balancing
snakemake -p --profile slurm --jobs 80
cd $dir/decay
snakemake -p --profile slurm --jobs 80
cd $dir/decay_balancing
snakemake -p --profile slurm --jobs 80
cd $dir/exponent
snakemake -p --profile slurm --jobs 80
cd $dir/fluctuations
snakemake -p --profile slurm --jobs 80
