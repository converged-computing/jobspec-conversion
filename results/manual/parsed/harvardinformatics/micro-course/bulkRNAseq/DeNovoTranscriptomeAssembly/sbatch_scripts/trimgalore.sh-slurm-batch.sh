#!/bin/bash
#SBATCH --job-name=tgalore
#SBATCH --account=informatics_workshop
#SBATCH --output=tgalore_ERR1101637_%A.out
#SBATCH --error=tgalore_ERR1101637_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000
#SBATCH --time=05:00:00

module purge
module load cutadapt/1.8.1-fasrc01
/n/scratchlfs/informatics/nanocourse/rna-seq/denovo_assembly/util/TrimGalore/trim_galore --paired  --illumina --retain_unpaired  --phred33  --output_dir $(pwd) --length 36 -q 5 --stringency 1 -e 0.1 $1 $2
