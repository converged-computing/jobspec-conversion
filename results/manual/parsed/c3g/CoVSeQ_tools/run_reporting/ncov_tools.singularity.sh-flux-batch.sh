#!/bin/bash
#FLUX: --job-name=hanky-pancake-8418
#FLUX: -t=43200
#FLUX: --urgency=16

export ENVDIR='/genfs/projects/analyste_dev/python_venvs/snakemake/bin/activate'
export NCOVTOOLS_SIF='/genfs/projects/analyste_dev/singularity/images/ncov-tools_v1.1.sif'

module purge 
module load singularity/3.6 python/3.7
echo "Finished loading modules..."
export ENVDIR="/genfs/projects/analyste_dev/python_venvs/snakemake/bin/activate"
source ${ENVDIR}
export NCOVTOOLS_SIF="/genfs/projects/analyste_dev/singularity/images/ncov-tools_v1.1.sif"
PROJ="REPLACE-PWD"
RUN_DIR="${PROJ}/ncov_tools"
cd ${RUN_DIR}
singularity exec \
    -B /genfs:/genfs \
    -B /lustre01:/lustre01 \
    -B /lustre02:/lustre02 \
    -B /lustre03:/lustre03 \
    -B /lustre04:/lustre04   \
    -B /cvmfs:/cvmfs \
    -B /project:/project \
    -B /scratch:/scratch \
    --cleanenv ${NCOVTOOLS_SIF} \
    bash ${RUN_DIR}/snakemake_run_all.sh
deactivate
