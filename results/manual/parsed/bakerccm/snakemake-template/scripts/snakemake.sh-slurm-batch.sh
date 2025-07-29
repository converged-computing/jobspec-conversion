#!/bin/bash
#SBATCH --output=snakemake.out
#SBATCH --error=snakemake.err
#SBATCH --mail-user=xxxxxxxx@xxxxx.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=1-00:00:00

module load conda2/4.2.13
source activate snakemake
snakemake --use-conda -j 8 some_rule
