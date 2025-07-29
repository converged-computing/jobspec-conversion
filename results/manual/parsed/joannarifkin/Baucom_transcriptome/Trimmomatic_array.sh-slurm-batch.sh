#!/bin/bash
#SBATCH --job-name=Trimmomatic_Rifkin
#SBATCH --account=rsbaucom0
#SBATCH --output=STAR_pass_2-%A-%a.log
#SBATCH --mail-user=jlrifkin@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-89%5

module purge
module load Bioinformatics
module load Bioinformatics  gcc/10.3.0-k2osx5y
module load trimmomatic
module list
mkdir -p ./Trimmomatic/
file=$(ls *.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p)
echo $file
TrimmomaticSE -threads 8 $file /Trimmomatic/trimmed_$file ILLUMINACLIP:TruSeq2-SE:2:30:10 LEADING:3 TRAILING:3 MAXINFO:50:0.5 MINLEN:36 
