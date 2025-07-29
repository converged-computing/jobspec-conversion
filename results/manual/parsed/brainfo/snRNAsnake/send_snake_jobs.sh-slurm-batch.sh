#!/bin/bash
#SBATCH --job-name=snakemake_pcos_qc
#SBATCH --account=naiss2023-5-328
#SBATCH --output=/proj/snic2022-6-176/nobackup/private/human_placenta/pcos/workflow/logs/clean.%A.%a.out
#SBATCH --error=/proj/snic2022-6-176/nobackup/private/human_placenta/pcos/workflow/logs/clean.%A.%a.err
#SBATCH --mail-user=scilavisher@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=19
#SBATCH --time=00:06:00

module purge
ml conda
conda init bash
ml bioinfo-tools
ml snakemake
snake_base_dir="/proj/snic2022-6-176/nobackup/private/human_placenta/pcos/workflow"
cd ${snake_base_dir}
snakemake -s Snakefile -j 19 --use-conda
