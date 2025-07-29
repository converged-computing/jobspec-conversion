#!/bin/bash
#SBATCH --job-name=gofunc
#SBATCH --output=slurm-go-%j.out
#SBATCH --error=slurm-go-%j.err
#SBATCH --mail-user=carole.belliardo@inra.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --partition=all

module load singularity/3.5.3 
IMG='/lerins/hub/projects/25_tools/GOfuncR/GOFunc.sif'
singularity run -B "/lerins/hub" -B "/work/$USER" $IMG snakemake --snakefile /lerins/hub/DB/WORKFLOW/GOfuncR/Snakefile -j $SLURM_CPUS_PER_TASK --configfile ${path}/param.yaml
