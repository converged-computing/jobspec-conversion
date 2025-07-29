#!/bin/bash
#SBATCH --job-name=examplejob
#SBATCH --account=project_465000872
#SBATCH --output=examplejob.o%j
#SBATCH --error=examplejob.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=standard-g
#SBATCH --constraint=ntasks-per-node=8

module load LUMI/22.08
module load cotainr
cotainr build lumi_env_container_test.sif --base-image=docker://rocm/dev-ubuntu-22.04:5.3.2-complete --conda-env=lumi_env.yml
