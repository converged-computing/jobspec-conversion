#!/bin/bash
#FLUX: --job-name=nf_amber
#FLUX: -c=2
#FLUX: --queue=shared
#FLUX: -t=18000
#FLUX: --urgency=16

export NFX_OPTS='-Xms=512m -Xmx=4g'

module purge --force
module load cpu/0.15.4
module load slurm
module load gcc/9.2.0
module load openmpi/3.1.6
module load amber/20
module load anaconda3/2020.11
eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
export NFX_OPTS="-Xms=512m -Xmx=4g"
nextflow -C ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example10/nextflow.config  \
    run -profile expanse ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example10/test.nf  \
    -params-file ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example10/config.yml  \
    -resume  \
    --outdir ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example10/example10_workdir
