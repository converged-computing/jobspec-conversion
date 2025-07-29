#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:12:00

module load jdk/18.0.1.1
module load singularity/3.7.0
curl -s https://get.nextflow.io | bash
mkdir -p ~/bin && mv nextflow ~/bin
PATH=~/bin:$PATH
SINGULARITY_CACHEDIR=~/.singularity
SINGULARITY_TMPDIR=/tmp
NXF_SINGULARITY_CACHEDIR=/home/${USER}/.singularity
