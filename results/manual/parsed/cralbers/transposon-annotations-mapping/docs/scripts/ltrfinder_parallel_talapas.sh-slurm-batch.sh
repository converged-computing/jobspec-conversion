#!/bin/bash
#FLUX: --job-name=kimltrfindp
#FLUX: --queue=short
#FLUX: -t=82800
#FLUX: --urgency=16

module load easybuild
module load GCC/6.3.0-2.27  OpenMPI/2.0.2
module load icc/2017.1.132-GCC-6.3.0-2.27
module load impi/2017.1.132
module load RepeatMasker/4.0.7
module load BLAT/3.5
module load BLAST/2.2.26-Linux_x86_64
module load BioPerl/1.7.1-Perl-5.24.1
cd /projects/libudalab/calbers/kim_ltrfinder_parallel/LTR_FINDER_parallel-master
perl LTR_FINDER_parallel -harvest_out -seq sequence.fasta > kim_ltrfinder_parallel.out
