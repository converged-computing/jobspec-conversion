#!/bin/bash
#SBATCH --job-name=nextflow_test_info_v5
#SBATCH --account=sds196
#SBATCH --output=nextflow_test_info_v5.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2000M
#SBATCH --time=00:50:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=1

module purge
module load cpu/0.15.4
module load gpu/0.15.4
module load slurm
module load anaconda3/2020.11
eval "$(conda shell.bash hook)"
conda activate /home/$USER/a/conda_envs/nextflow
nextflow -C ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3/nextflow.config  run -profile expanse ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3/test.nf -resume -with-conda true --outdir ~/a/CIP_Nextflow_on_HPC/examples/nextflow_slurm/example3/example3_workdir
