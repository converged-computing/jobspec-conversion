#!/bin/bash
#SBATCH --job-name=platypus
#SBATCH --account=def-coling
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=evelien.degreef@umanitoba.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=0
#SBATCH --time=12:00:00

module load nixpkgs/16.09 gcc/7.3.0 platypus/0.8.1
cd /scratch/edegreef/whales/dedupRG_bam/samtools_filter/downsampled
python /cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/Compiler/gcc7.3/platypus/0.8.1/bin/Platypus.py callVariants \
--bamFiles=bowhead_whale_bams.txt \
--refFile=/scratch/edegreef/whales/ref_genomes/rclone/BOW_reference.fasta \
--output=/scratch/edegreef/whales/bowhead_allvariantcalls_pp.vcf \
--nCPU=32 --minReads=4
