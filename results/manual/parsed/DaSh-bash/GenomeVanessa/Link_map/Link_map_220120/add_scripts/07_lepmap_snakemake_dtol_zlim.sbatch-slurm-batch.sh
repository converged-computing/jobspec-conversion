#!/bin/bash
#SBATCH --job-name=linkage_map_vanessa_lepmap_dtol
#SBATCH --account=snic2021-5-20
#SBATCH --error=linkage_map_vanessa_lepmap_dtol_zlim
#SBATCH --mail-user=karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

export CONDA_ENVS_PATH='/proj/uppstore2017185/b2014034_nobackup/Karin/envs/'

module load bioinfo-tools
module load conda
export CONDA_ENVS_PATH=/proj/uppstore2017185/b2014034_nobackup/Karin/envs/
module load R/4.0.0
module load R_packages/4.0.0
cd /proj/uppstore2017185/b2014034_nobackup/Karin/link_map_vanessa/output/07_LepMak3r_DTOL
conda activate lepmap_snake
snakemake --unlock
snakemake --cores 4 
wait
conda deactivate
