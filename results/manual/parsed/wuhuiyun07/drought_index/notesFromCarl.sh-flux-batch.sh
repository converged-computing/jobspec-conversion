#!/bin/bash
#FLUX: --job-name=install_conda
#FLUX: -c=20
#FLUX: --queue=centos7
#FLUX: -t=172800
#FLUX: --urgency=16

export CONDA_ENVS_PATH='/lustre/project/taw/Wu_analysis/conda_envs'
export MINIWDL_CFG='/share/apps/centos7/anaconda3/2023.07/envs/miniwdl/miniwdl.cfg'

export CONDA_ENVS_PATH=/lustre/project/taw/Wu_analysis/conda_envs
module load anaconda3/2020.07
unset PYTHONPATH
source $CONDA_ENVS_PATH/wu-base/etc/profile.d/conda.sh
conda activate wu-base
conda --version
conda install -c conda-forge mamba
mamba --version
idev --partition=centos7
module load singularity/3.9.0
source /lustre/project/singularity_images/setup_cypress.sh
singularity shell -s /bin/bash czid-short-read-mngs-public_latest.sif
export CONDA_ENVS_PATH=/lustre/project/taw/Wu_analysis/conda_envs
conda list -n sing-base 
 # - python=3.1
unset PYTHONPATH          
source $CONDA_ENVS_PATH/sing-base/etc/profile.d/conda.sh
conda activate sing-base
idev74 ##on centos 7 node, 4 hours
module load anaconda3/2023.07 
module load singularity/3.9.0
source activate miniwdl
export MINIWDL_CFG=/share/apps/centos7/anaconda3/2023.07/envs/miniwdl/miniwdl.cfg
source /lustre/project/singularity_images/setup_cypress.sh
cd czid-workflows
miniwdl run workflows/short-read-mngs/local_driver.wdl    \
docker_image_id=ghcr.io/chanzuckerberg/czid-workflows/czid-short-read-mngs-public     \
fastqs_0=workflows/short-read-mngs/test/norg_6__nacc_27__uniform_weight_per_organism__hiseq_reads__v6__R1.fastq.gz    \
fastqs_1=workflows/short-read-mngs/test/norg_6__nacc_27__uniform_weight_per_organism__hiseq_reads__v6__R2.fastq.gz     \
-i workflows/short-read-mngs/test/local_test_viral.yml --verbose
