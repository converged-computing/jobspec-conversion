#!/bin/bash
#SBATCH --job-name=clustering
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --mail-user=tsoelter@uab.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=65000
#SBATCH --time=12:00:00
#SBATCH --partition=short

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='$USER'

module load Singularity/3.5.2-GCC-5.4.0-2.26
wd="/data/user/tsoelter/projects/230418_TS_AgingCCC"
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER=$USER
INPUT="${wd}/src/functions_CCCin3xTgAD.R"
INPUT2="${wd}/data/seurat/integrated_seurat.rds"
INPUT3="${wd}"
singularity exec \
--cleanenv \
--containall \
-B ${wd} \
${wd}/bin/docker/rstudio_aging_ccc_1.0.0.sif \
Rscript --vanilla ${wd}/src/seurat_preprocessing/02_3xtgad_clustering.R ${INPUT} ${INPUT2} ${INPUT3}
