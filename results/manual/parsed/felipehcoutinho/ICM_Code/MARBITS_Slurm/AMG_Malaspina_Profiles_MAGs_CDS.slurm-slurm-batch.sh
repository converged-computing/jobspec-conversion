#!/bin/bash
#SBATCH --job-name=Malaspina_Profiles_CDS_AMG_Hunter
#SBATCH --account=emm4
#SBATCH --output=/mnt/lustre/scratch/fcoutinho/Job_Logs/jobLog_%A_%a.out
#SBATCH --error=/mnt/lustre/scratch/fcoutinho/Job_Logs/jobLog_%A_%a.err
#SBATCH --mail-user=felipehcoutinho@gmail.com
#SBATCH --mail-type=All
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-20%5

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
file=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --parse_only True --threads 12 --cds $file --info_cds_output CDS_Info_$file.tsv --info_genome_output Genome_Info_$file.tsv
