#!/bin/bash
#FLUX: --job-name="nf_amber"
#FLUX: -c=2
#FLUX: --queue=shared
#FLUX: --priority=16

export NFX_OPTS='-Xms=512m -Xmx=4g'

module purge --force
module load  gpu/0.15.4  
module load openmpi/4.0.4
module load slurm
module load amber/20-patch15
module load anaconda3/2020.11
eval "$(conda shell.bash hook)"
eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
export NFX_OPTS="-Xms=512m -Xmx=4g"
nextflow -C ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example11/nextflow.config  \
    run -profile expanse ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example11/test.nf  \
    -params-file ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example11/config.yml  \
    -resume  \
    -with-trace \
    --outdir ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example11/example11_workdir
