#!/bin/bash
#SBATCH --job-name=bowtie2-index
#SBATCH --output=stdout.%j.%N
#SBATCH --error=stderr.%j.%N
#SBATCH --mail-user=bpward2@ncsu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=short

module load bowtie2/2.3.4
ref_file="/project/genolabswheatphg/v1_refseq/Clay_splitchroms_reference/161010_Chinese_Spring_v1.0_pseudomolecules_parts.fasta"
nthreads=40
date
ind_name="${ref_file%.*}"
bowtie2-build --threads $nthreads "${ref_file}" "${ind_name}"
date
