#!/bin/bash
#SBATCH --job-name=Singularity install VEP annotator
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=02:00:00

module load any/singularity/3.7.3
module load squashfs/4.4
singularity exec vep.sif INSTALL.pl -c $HOME/vep_data -a c -s homo_sapiens -y GRCh37 -n --CACHE_VERSION 108
