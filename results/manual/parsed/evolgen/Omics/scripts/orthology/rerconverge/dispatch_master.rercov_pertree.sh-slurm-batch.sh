#!/bin/bash
#SBATCH --job-name=rer_masterfilename
#SBATCH --account=co_genomicdata
#SBATCH --output=/global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/list_configs/masterfilename/log
#SBATCH --error=/global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/list_configs/masterfilename/error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --partition=savio22_bigmem
#SBATCH --qos=savio_lowprio

module load gcc/4.8.5 openmpi # or module load intel openmpi, ALWAYS required
cd /global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/list_configs/masterfilename/ ;
rm -fr .snakemake ;
snakemake -s /global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/multi_rerconv_trees_Snakefile_new --configfile /global/scratch2/rohitkolora/Rockfish/Genomes/orthologs/Lifted/Sebastes_55/rerconverge/list_configs/masterfilename/config_masterfilename.json -j 7 -k
