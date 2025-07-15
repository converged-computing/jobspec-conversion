#!/bin/bash
#FLUX: --job-name="nextflow_test_info_v5"
#FLUX: -c=2
#FLUX: --queue=shared
#FLUX: --priority=16

module purge
module load cpu/0.15.4
module load gpu/0.15.4
module load slurm
module load anaconda3/2020.11
eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
nextflow -C ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3/nextflow.config  run -profile expanse ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3/test.nf -resume -with-conda true --outdir ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3/example3_workdir
