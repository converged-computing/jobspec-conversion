#!/bin/bash
#FLUX: --job-name=clustering
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

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
