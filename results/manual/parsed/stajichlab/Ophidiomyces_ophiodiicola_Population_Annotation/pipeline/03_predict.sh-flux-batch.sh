#!/bin/bash
#FLUX: --job-name=crunchy-snack-5393
#FLUX: -n=24
#FLUX: --queue=intel,batch
#FLUX: -t=259200
#FLUX: --urgency=16

export FUNANNOTATE_DB='/bigdata/stajichlab/shared/lib/funannotate_db'

module unload miniconda2 miniconda3 anaconda3
module unload perl
module unload python
module load funannotate
module load workspace/scratch
which funannotate
diamond version
CPU=1
if [ $SLURM_CPUS_ON_NODE ]; then
    CPU=$SLURM_CPUS_ON_NODE
fi
BUSCO=ascomycota_odb10
INDIR=$(realpath genomes)
OUTDIR=$(realpath annotate)
PREDS=$(realpath prediction_support)
mkdir -p $OUTDIR
SAMPFILE=samples.csv
INFORMANT=$(realpath lib/informant_proteins.aa)
N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
    N=$1
    if [ -z $N ]; then
        echo "need to provide a number by --array or cmdline"
        exit
    fi
fi
MAX=`wc -l $SAMPFILE | awk '{print $1}'`
if [ $N -gt $MAX ]; then
    echo "$N is too big, only $MAX lines in $SAMPFILE"
    exit
fi
SEED_SPECIES=ophidiomyces_ophiodiicola
AUGSPECIES=ophidiomyces_ophiodiicola
export FUNANNOTATE_DB=/bigdata/stajichlab/shared/lib/funannotate_db
IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read SPECIES STRAIN VERSION PHYLUM BIOSAMPLE BIOPROJECT LOCUSTAG
do
    SEQCENTER=UCR
    BASE=$(echo -n ${SPECIES}_${STRAIN}.${VERSION} | perl -p -e 's/\s+/_/g')
    BASE=$(echo -n ${STRAIN} | perl -p -e 's/\s+/_/g; s/NWHC_//; s/(CBS|UAMH)_/$1-/')
    echo "sample is $BASE"
    MASKED=$(realpath $INDIR/$BASE.masked.fasta)
    echo "Masked asm file is $MASKED"
    augname=$(echo -n ${SPECIES} | perl -p -e '$_=lc($_)')
    if [ -d $AUGUSTUS_CONFIG_PATH/species/$augname ]; then
	    SEED_SPECIES=$augname
    fi
    echo "SEED species is $SEED_SPECIES"
    if [ ! -f $MASKED ]; then
      echo "Cannot find $BASE.masked.fasta in $INDIR - may not have been run yet"
      exit
    fi
    echo "using seed species $SEED_SPECIES with busco; base is $BASE strain is $STRAIN"
	funannotate predict --cpus $CPU --keep_no_stops --SeqCenter $SEQCENTER --busco_db $BUSCO \
	--strain "$STRAIN" --min_training_models 100 \
	-i $MASKED --name $LOCUSTAG --augustus_species $AUGSPECIES \
	-s "$SPECIES"  -o $OUTDIR/$BASE --busco_seed_species $SEED_SPECIES --tmpdir $SCRATCH \
	--ploidy 1
	#--AUGUSTUS_CONFIG_PATH $AUGUSTUS_CONFIG_PATH \
	#--AUGUSTUS_CONFIG_PATH $AUGUSTUS_CONFIG_PATH \
done
