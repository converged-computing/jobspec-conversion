#!/bin/bash
#FLUX: --job-name=boopy-poo-0114
#FLUX: --priority=16

set -e -x
source ${SLURM_SUBMIT_DIR:-$(pwd)}/../UPSCb-common/src/bash/functions.sh
MEM=40G
PROC=20
BOWTIE=
TRIM=0
READSET=0
LONGREADS=
USAGETXT=\
"
	Usage: runTrinity.sh [options] <out dir> <left fq(s)> <right fq(s)> [single fq(s)]
	Options:
                -b do not run bowtie as part of Chrysalis. The only reason to do that
                   is if the inchworm file is larger than 4Gbp. bowtie cannot index
                   files larger than 4Gbp. It is also extremely slow (samtools sort 
                   step is mono-CPU)
		-l long reads (pac bio or other) as a fasta file
                -m mem requirement (default 40G) (rule of thumb 1.5G/1M read pairs)
		        -p number of threads to use (default 16)
		        -r normalise by read set
		        -s strand specific RNAseq read orientation if paired: RF or FR, if single F or R 
		               dUTP method=RF
		        -t trimmomatic options, none by default (hardcoded otherwise)
        Note:
             Several fastq files can be provided as argument; separated by commas
             The 4th argument (the single fq(s)) is optional and can be left empty
"
while getopts b:l:m:p:rs:t option
do
        case "$option" in
	    b) BOWTIE="--no_bowtie";;
	    l) LONGREADS="$OPTARG";;
	    m) MEM=$OPTARG;;
	    p) PROC=$OPTARG;;
	    r) READSET=1;;
	    s) SPEC="--SS_lib_type $OPTARG";;
	    t) TRIM=1;;
		\?) ## unknown flag
		usage;;
        esac
done
shift `expr $OPTIND - 1`
if [ $# -lt 3 ] || [ $# -gt 4 ]; then
    abort "This function needs 3 or 4 arguments"
fi
if [ ! -d $1 ]; then
    abort "The first argument (output dir) needs to be an existing directory"
fi
echo "Checking the forward (left) fastq file(s). If this fails, file(s) may be missing."
echo $2 | xargs -d, -P $PROC -I {} bash -c 'if [ ! -f $(readlink $0) ]; then exit 1; fi' {}
echo "Checking the reverse (right) fastq file(s). If this fails, file(s) may be missing."
echo $3 | xargs -d, -P $PROC -I {} bash -c 'if [ ! -f $(readlink $0) ]; then exit 1; fi' {}
if [ $2 -ne $(echo $3 | tr '_2.fq.gz' '_1.fq.gz') ]; then
  abort "The forward and reverse files are not sorted in the same way"
fi
if [ ! -z $4 ]; then
    echo "Checking the singleton fastq file(s). If this fails, file(s) may be missing."
    echo $4 | xargs -d, -P $PROC -I {} bash -c 'if [ ! -f $0 ]; then exit 1; fi' {}
fi
SGL=
if [ ! -z $4 ]; then
    echo Adding single files
    #SGL="--single `echo $4 | tr ',' ' '`"
    SGL="--single $4"
fi
if [ ! -z $LONGREADS ]; then
	if [ ! -f $LONGREADS ]; then
		abort "-l should point to an existing fasta file"
	else
		LONGREADS="--long_reads $LONGREADS"
	fi	
fi
if [ $(echo $2 | grep -o "," | wc -l) -gt 50 ] || [ $READSET -eq 1 ] ; then
    NORM="--normalize_by_read_set"
fi
echo Assembling
if [ $TRIM -eq 1 ]; then
    Trinity  $BOWTIE --seqType fq --max_memory $MEM $LONGREADS \
    --left $2 --right $3 $SGL --output $1 --CPU $PROC $NORM $SPEC \
    --trimmomatic --quality_trimming_params "ILLUMINACLIP:/sw/apps/bioinfo/trimmomatic/0.36/rackham/adapters/TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:4:5 MINLEN:25"
else
    Trinity  $BOWTIE --seqType fq --max_memory $MEM $LONGREADS \
    --left $2 --right $3 $SGL --output $1 --CPU $PROC $NORM $SPEC
fi
echo Done
