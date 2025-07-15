#!/bin/bash
#FLUX: --job-name=crg2
#FLUX: --queue=all
#FLUX: -t=180000
#FLUX: --priority=16

SF="/srv/shared/pipelines/crg2/Snakefile"
CP="/srv/shared/conda_envs/crg2-conda/"
SLURM="/srv/shared/pipelines/crg2/slurm_profile/"
CONFIG="config_cheo_ri.yaml"
source /storage/modules/anaconda/2020.11/etc/profile.d/conda.sh
conda activate /srv/shared/conda_envs/snakemake_5.10.0/
snakemake --use-conda -s ${SF} --cores 4 --conda-prefix ${CP} --configfile ${CONFIG} --profile ${SLURM}
