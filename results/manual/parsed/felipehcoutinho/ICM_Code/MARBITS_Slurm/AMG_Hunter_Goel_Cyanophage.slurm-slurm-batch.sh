#!/bin/bash
#SBATCH --job-name=AMG_Hunter_Goel_Cyanophages
#SBATCH --account=emm4
#SBATCH --output=/mnt/lustre/scratch/fcoutinho/Job_Logs/jobLog_%J.out
#SBATCH --error=/mnt/lustre/scratch/fcoutinho/Job_Logs/jobLog_%J.err
#SBATCH --mail-user=felipehcoutinho@gmail.com
#SBATCH --mail-type=All
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=150G
#SBATCH --time=1-00:00:00

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 24 --cds /mnt/lustre/scratch/fcoutinho/Anaerobic_Digester/UL_Cyanophage_AMG.faa --info_cds_output CDS_Info_UL_Cyanophage_AMG.tsv --info_genome_output Genome_Info_UL_Cyanophage_AMG.tsv
