#!/bin/bash
#FLUX: --job-name=nextflow_singularity_gpu_info
#FLUX: -c=2
#FLUX: --queue=shared
#FLUX: -t=3000
#FLUX: --urgency=16

export NFX_OPTS='-Xms=512m -Xmx=4g'

module purge
module load cpu/0.15.4
module load gpu/0.15.4
module load slurm
module load anaconda3/2020.11
module load singularitypro/3.11
eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
export NFX_OPTS="-Xms=512m -Xmx=4g"
nextflow -C ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example5/nextflow.config  run -profile expanse ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example5/test.nf -resume -with-singularity true --outdir ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example5/example5_workdir
