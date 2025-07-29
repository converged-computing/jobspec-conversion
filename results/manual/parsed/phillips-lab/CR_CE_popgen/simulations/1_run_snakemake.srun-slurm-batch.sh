#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=16-16:00:00
#SBATCH --array=0

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
