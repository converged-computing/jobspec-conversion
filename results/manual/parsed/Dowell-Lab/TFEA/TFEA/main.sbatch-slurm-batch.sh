#!/bin/bash
#SBATCH --job-name=TFEA
#SBATCH --output=/scratch/Users/joru1876/e_and_o/%x.out
#SBATCH --error=/scratch/Users/joru1876/e_and_o/%x.err
#SBATCH --mail-user=joru1876@colorado.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50gb
#SBATCH --time=1-00:00:00

module purge
module load python/3.6.3
module load R/3.6.1
module load bedtools/2.25.0
module load meme/5.0.3
module load samtools/1.3.1
module load gcc/7.1.0
if [[ ${venv} != . ]]; then
    source ${venv}/bin/activate
fi
python3 ${cmd}
