#!/bin/bash
#SBATCH --job-name=b0d135
#SBATCH --output=YB_L0d75A0d75B0d135_checkNumberOfSuitableGrowth_growthFreq25_strain0d05_
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G

export SINGULARITY_NV='1'

module load singularity
export SINGULARITY_NV=1
module load centos
module load extra
module load GCC
module load cuda/9.1
centos.sh "module load cuda/9.1; ./virus-model -dt=0.001 Data_structure.xml"
