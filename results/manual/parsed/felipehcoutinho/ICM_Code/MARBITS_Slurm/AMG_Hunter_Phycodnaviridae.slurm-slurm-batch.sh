#!/bin/bash
#SBATCH --job-name=Phycodnaviridae_AMG_Hunter
#SBATCH --account=emm4
#SBATCH --output=/mnt/lustre/scratch/fcoutinho/Job_Logs/jobLog_%J.out
#SBATCH --error=/mnt/lustre/scratch/fcoutinho/Job_Logs/jobLog_%J.err
#SBATCH --mail-user=felipehcoutinho@gmail.com
#SBATCH --mail-type=All
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl
hmmsearch -o RefSeq_Genomes_PhycodnaviridaexAll_KOs.hmmsearch --noali --cpu 24 /mnt/lustre/bio/users/fcoutinho/KOfam/All_KOs.hmm /mnt/lustre/scratch/fcoutinho/xlopez/Phylogenies/RefSeq_Genomes_Phycodnaviridae.faa
hmmsearch -o RefSeq_Genomes_PhycodnaviridaexPfam-A.hmmsearch --noali --cpu 24 /mnt/lustre/repos/bio/databases/public/pfam/pfam_release_34.0/Pfam-A.hmm /mnt/lustre/scratch/fcoutinho/xlopez/Phylogenies/RefSeq_Genomes_Phycodnaviridae.faa
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --parse_only True --threads 24 --cds /mnt/lustre/scratch/fcoutinho/xlopez/Phylogenies/RefSeq_Genomes_Phycodnaviridae.faa
