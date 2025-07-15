#!/bin/bash
#FLUX: --job-name=strawberry-hobbit-4956
#FLUX: -t=907200
#FLUX: --urgency=16

module load canu/1.7
data_d=/pine/scr/<O>/<N>/<ONYEN/ #a single fastq file (preferably zipped) containing reads
work_d=/pine/scr/k/a/kamoser/ovale_assembly/canu_v1 #where canu will right your output
mkdir -p $work_d
canu -p <NAME> \ # name of assembly (will produce <NAME>.contigs.fasta) as final
 -d $work_d \
 -nanopore-raw $data_d/combined.all.fastq.gz \
 #-pacbio-raw $data/combined.all.fastq.gz \ # example for pacbio data. can run both options at once if you have both nanopore + pacbio data
 genomeSize=<NUMBER> \ # Example: 23.3m for P. falciparum (include the m). This is mainly used to estimate genome coverage, so does not need to be exact
 #correctedErrorRate=0.15 \ only needed for AT rich genomes
 usegrid=TRUE \ #required to submit to grid. you can run locally, but trust me you don't want to do that
 -gridOptions="--time=10-12:00:00" #Average Pf genomes take somewhere between 2-4 days, bepending on the amount and quality of reads provided. 
echo "Read through script."
~                          
