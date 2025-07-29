#!/bin/bash
#SBATCH --job-name=str_sh_rnaseq
#SBATCH --output=/gpfs/scratch/pr63la/ra52noz2/%x.%j.%N.out
#SBATCH --mail-user=adam.sorbie@med.uni-muenchen.de
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=250gb
#SBATCH --time=16:00:00
#SBATCH --partition=teramem_inter
#SBATCH --chdir=/gpfs/scratch/pr63la/ra52noz2

export OMP_NUM_THREADS='24'

export OMP_NUM_THREADS=24
source /etc/profile.d/modules.sh
module load python/3.6_intel 
source activate rnaseq 
SAMPLE_SHEET="samples.csv"
nextflow run nf-core/rnaseq --input $SAMPLE_SHEET -r 3.2 --max_cpus 24 --max_memory '250.GB' --genome GRCm38 -profile charliecloud -resume wise_minsky
