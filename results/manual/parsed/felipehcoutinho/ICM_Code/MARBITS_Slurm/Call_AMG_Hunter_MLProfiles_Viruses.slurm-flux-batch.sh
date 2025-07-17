#!/bin/bash
#FLUX: --job-name=AMG_Hunter_MLP_Viruses
#FLUX: -c=24
#FLUX: -t=172800
#FLUX: --urgency=16

module load diamond/2.0.7
module load python/3.8.5
module load hmmer
module load perl/5.28
module load prodigal
python3 /mnt/lustre/bio/users/fcoutinho/Repos/virathon/Virathon.py --threads 23 --genome_files /mnt/lustre/scratch/fcoutinho/Profiles_Malaspina/Assemblies_Round2/Metabat_Binning/Redo_MetaBat_Bins_Round_1/ENA_Submission/MLP_Profiles_Euk+Prok_Virus_Genomic_Sequences.fasta --call_prodigal True
python3 /mnt/lustre/bio/users/fcoutinho/Scripts/AMG_Hunter.py --annotate True --threads 23 --cds /mnt/lustre/scratch/fcoutinho/Profiles_Malaspina/Assemblies_Round2/Metabat_Binning/Redo_MetaBat_Bins_Round_1/ENA_Submission/MLP_Profiles_Euk+Prok_Virus_Genomic_Sequences.faa
