#!/bin/bash
#SBATCH --job-name=Metaerg_Sing
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=1-00:15:00
#SBATCH --partition=intel,batch

module load metaerg # This auto loads singularity
singularity exec -B data:/data $METAERG_IMG setup_db.pl -o /data -v 132
singularity exec -B data:/data $METAERG_IMG metaerg.pl --dbdir /data/db --outdir /data/my_metaerg_output /data/contig.fasta
