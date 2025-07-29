#!/bin/bash
#SBATCH --job-name=shortreaddenovo_assembly
#SBATCH --output=/cbio/projects/026/logs/short-read-denovo-assembly-%j-stdout.txt
#SBATCH --error=/cbio/projects/026/logs/short-read-denovo-assembly-%j-stderr.txt
#SBATCH --mail-user=ephie.geza@uct.ac.za
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100GB
#SBATCH --time=14-00:00:00
#SBATCH --partition=Main

echo "Assmbly Started"
proj="/cbio/projects/026/"
module load  nextflow/23.04.4 
module load openmpi/4.1.5
cd /cbio/projects/026/shortread_denovo_assembly_pipeline/
nextflow run main.nf --datadir "/cbio/projects/026/data_1"  \
	--outdir "/cbio/projects/026/results/run1" \
	-config "/cbio/projects/026/shortread_denovo_assembly_pipeline/nextflow.config" \
	-profile singularity,ilifu -resume
