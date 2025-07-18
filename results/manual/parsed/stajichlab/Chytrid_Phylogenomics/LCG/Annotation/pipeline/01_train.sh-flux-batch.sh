#!/bin/bash
#FLUX: --job-name=TrainFun
#FLUX: -n=16
#FLUX: --queue=intel
#FLUX: -t=260100
#FLUX: --urgency=16

export SINGULARITY_BINDPATH='/bigdata,/bigdata/operations/pkgadmin/opt/linux:/opt/linux'
export AUGUSTUS_CONFIG_PATH='$(realpath lib/augustus/3.3/config)'
export FUNANNOTATE_DB='/bigdata/stajichlab/shared/lib/funannotate_db'
export SINGULARITYENV_PASACONF='/rhome/jstajich/pasa.config.txt'

PROGNAME=$(basename $0)
echo "PROGRAM is $PROGNAME"
module load funannotate/1.7.3_sing
MEM=64G
export SINGULARITY_BINDPATH=/bigdata,/bigdata/operations/pkgadmin/opt/linux:/opt/linux
export AUGUSTUS_CONFIG_PATH=$(realpath lib/augustus/3.3/config)
export FUNANNOTATE_DB=/bigdata/stajichlab/shared/lib/funannotate_db
export SINGULARITYENV_PASACONF=/rhome/jstajich/pasa.config.txt
if [[ -z ${SLURM_CPUS_ON_NODE} ]]; then
    CPUS=1
else
    CPUS=${SLURM_CPUS_ON_NODE}
fi
N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
    N=$1
    if [ -z $N ]; then
        echo "need to provide a number by --array or cmdline"
        exit
    fi
fi
ODIR=annotate
INDIR=genomes
RNAFOLDER=lib/RNASeq
SAMPLEFILE=samples.csv
IFS=,
tail -n +2 $SAMPLEFILE | sed -n ${N}p | while read SPECIES STRAIN PHYLUM BIOSAMPLE BIOPROJECT SRA LOCUSTAG WGS
do
    echo "SPECIES is $SPECIES"
    SPECIESNOSPACE=$(echo -n "$SPECIES" | perl -p -e 's/\s+/_/g')
    if [[ ! -d $RNAFOLDER/$SPECIESNOSPACE || ! -f $RNAFOLDER/$SPECIESNOSPACE/Forward.fq.gz ]]; then
	     echo "For training step Need RNASeq files in folder  $RNAFOLDER/$SPECIESNOSPACE as  $RNAFOLDER/$SPECIESNOSPACE/Forward.fq.gz and  $RNASEQ/$SPECIESNOSPACE/Reverse.fq.gz"
	     exit
    fi
    BASE=$(echo -n "$SPECIES $STRAIN" | perl -p -e 's/\s+/_/g')
    echo "sample is $BASE"
    MASKED=$(realpath $INDIR/$BASE.masked.fasta)
    if [ ! -f $MASKED ]; then
	     echo "Cannot find $BASE.masked.fasta in $INDIR - may not have been run yet"
       exit
    fi
    echo $ODIR/$BASE/training
    funannotate train -i $MASKED -o $ODIR/$BASE \
   	--jaccard_clip --species "$SPECIES" --isolate $STRAIN \
  	--cpus $CPUS --memory $MEM --pasa_db mysql \
  	--left $RNAFOLDER/$SPECIESNOSPACE/Forward.fq.gz --right $RNAFOLDER/$SPECIESNOSPACE/Reverse.fq.gz
done
