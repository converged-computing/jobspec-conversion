#!/bin/bash
#SBATCH --job-name=ray
#SBATCH --output=../log/ray-%j.out
#SBATCH --error=../log/ray-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=80000

module load ray
PREFIX=$1
DIRECTORY=$2
echo "prefix is $PREFIX"
echo "directory is $DIRECTORY"
F1=${DIRECTORY}/data/$PREFIX.R1.fastq
F2=${DIRECTORY}/data/$PREFIX.R2.fastq
echo "F1 is $F1 and F2 is $F2"
ls -la $F1
ls -la $F2
rmdir -p $DIRECTORY/results/$PREFIX.ray
/usr/lib64/openmpi/bin/mpirun Ray -k 31 -minimum-contig-length 1000 -use-minimum-seed-coverage 3 -p $F1 $F2 -o $TMPDIR/ray
cp $TMPDIR/ray/Contigs.fasta $DIRECTORY/results/$PREFIX.ray.contigs.fasta
gzip $DIRECTORY/results/$PREFIX.ray.contigs.fasta
rm -rf $TMPDIR/*
