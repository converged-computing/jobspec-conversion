#!/bin/bash
#SBATCH --job-name=nextflow
#SBATCH --account=cbcb
#SBATCH --mail-user=dhe17@umd.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --time=21-00:00:00
#SBATCH --qos=highmem

PROJDIR="/fs/nexus-projects/sc_read_census/nextflow"
cd $PROJDIR
$PROJDIR/nextflow $PROJDIR/main.nf -resume
