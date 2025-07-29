#!/bin/bash
#FLUX: --job-name=repeatmasker
#FLUX: -c=24
#FLUX: -t=3600
#FLUX: --urgency=16

module load GCC/9.3.0  OpenMPI/4.0.3  RepeatMasker/4.1.2-p1-HMMER
<<README
    RepeatMasker homepage: http://www.repeatmasker.org
README
[ -f upstream5000.fa.gz ] || cp /scratch/data/bio/GCATemplates/data/test/upstream5000.fa.gz ./
input_fasta='upstream5000.fa.gz'
species='Arabidopsis thaliana'
threads=$SLURM_CPUS_PER_TASK
masking='-xsmall'       # -xsmall returns repetitive regions in lowercase (rest capitals) rather than masked
                        # -small returns complete .masked sequence in lower case
                        # -x returns repetitive regions masked with Xs rather than Ns (default Ns)
RepeatMasker -s -species "$species" -pa $threads -e hmmer $masking $input_fasta
<<CITATIONS
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html
    - RepeatMasker: Smit, AFA, Hubley, R & Green, P. RepeatMasker Open-4.0.
                    2013-2015 <http://www.repeatmasker.org>.
CITATIONS
