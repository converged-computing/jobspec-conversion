#!/bin/bash
#SBATCH --job-name=iqtree
#SBATCH --output=logs/iqtree.plastid-%j.out
#SBATCH --error=logs/iqtree.plastid-%j.err
#SBATCH --mail-user=user@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=10gb
#SBATCH --time=4-04:00:00

cd $SLURM_SUBMIT_DIR
date
hostname
module purge
module load cuda/9.2.88 intel/2018.1.163 openmpi/3.1.2 iq-tree/1.6.10
iqtree -s plastid_whole_read_mapped_reduced.fasta -nt $SLURM_CPUS_ON_NODE -seed $RANDOM -m TEST -merit AIC -bb 1000
