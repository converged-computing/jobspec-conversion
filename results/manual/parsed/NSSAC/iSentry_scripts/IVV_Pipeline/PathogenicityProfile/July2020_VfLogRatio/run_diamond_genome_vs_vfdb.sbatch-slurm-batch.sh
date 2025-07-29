#!/bin/bash
#SBATCH --account=isentry
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=128000
#SBATCH --time=04:00:00
#SBATCH --partition=bii

PATH=$PATH:/project/biocomplexity/isentry/bin
module load gcc
module load diamond
module load singularity
vfdb="/project/biocomplexity/isentry/ref_data/vfdb/VFDB_setB_pro.dmnd"
evalue="1e-9"
fields="qseqid sseqid length evalue bitscore stitle"
genome_file=$1
for genome in for f in `cut -f 1 $genome_file `
do
	if [ -e ${genome}_vfdb.blastx ]
	then
		echo "file exists: ${genome}_vfdb.blastx"
		continue
	fi
	echo "fetch genome $genome"
	singularity exec /scratch/awd5y/patric-1.026.simg p3-genome-fasta $genome > ${genome}.fasta
	if [ -e $genome.fasta ]
	then
		command="diamond blastx --threads 4 --db $vfdb --out ${genome}_vfdb.blastx --outfmt 6 $fields -e $evalue -q $genome.fasta"
		echo $command
		$command
		rm $genome.fasta
	fi
done
