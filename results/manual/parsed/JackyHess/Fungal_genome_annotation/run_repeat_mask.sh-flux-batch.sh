#!/bin/bash
#FLUX: --job-name=fat-pastry-7075
#FLUX: -c=10
#FLUX: -t=240000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$JAMG_PATH/3rd_party/transdecoder/util/lib64/'

module load emboss
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JAMG_PATH/3rd_party/transdecoder/util/lib64/
$JAMG_PATH/bin/prepare_domain_exon_annotation.pl -verbose -genome $GENOME_PATH -repthreads $LOCAL_CPUS -engine local -mpi $LOCAL_CPUS -transposon_db /usit/abel/u1/jacqueh/Software/jamg/databases/hhblits/transposons -uniprot_db /usit/abel/u1/jacqueh/Software/jamg/databases/hhblits/uniprot20_2013_03
$JAMG_PATH/3rd_party/bin/maskFastaFromBed -soft -fi $GENOME_PATH -fo $GENOME_PATH.softmasked -bed *.out.gff
