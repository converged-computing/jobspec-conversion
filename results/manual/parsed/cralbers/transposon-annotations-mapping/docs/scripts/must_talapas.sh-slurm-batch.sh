#!/bin/bash
#SBATCH --job-name=kimmust
#SBATCH --account=libudalab
#SBATCH --output=kimmust.out
#SBATCH --error=kimmust.err
#SBATCH --mail-user=calbers@uoregon.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=13-23:00:00
#SBATCH --constraint=ntasks-per-node=20

module load easybuild
module load GCC/6.3.0-2.27  OpenMPI/2.0.2
module load icc/2017.1.132-GCC-6.3.0-2.27
module load impi/2017.1.132
module load RepeatMasker/4.0.7
module load BLAT/3.5
module load BLAST/2.2.26-Linux_x86_64
module load BioPerl/1.7.1-Perl-5.24.1
cd /home/calbers/libudalab/kim_must/MUST.r2-4-002.Release
./MUST_Pipe.pl sequence.fasta output.dat temp
