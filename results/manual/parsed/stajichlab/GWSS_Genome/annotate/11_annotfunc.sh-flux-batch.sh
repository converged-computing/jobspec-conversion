#!/bin/bash
#FLUX: --job-name=gwss_predict_fun
#FLUX: -n=16
#FLUX: --queue=intel,batch,stajichlab
#FLUX: --urgency=16

export FUNANNOTATE_DB='/bigdata/stajichlab/shared/lib/funannotate_db'

module load funannotate
source activate funannotate-1.8
module load phobius
module list
export FUNANNOTATE_DB=/bigdata/stajichlab/shared/lib/funannotate_db
CPUS=$SLURM_CPUS_ON_NODE
OUTDIR=annotate
INDIR=genomes
SAMPFILE=genomes/samples.csv
BUSCO=hemiptera_odb10
if [ -z $CPUS ]; then
 CPUS=1
fi
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
IFS=,
tail -n +2 $SAMPFILE | sed -n ${N}p | while read SPECIES STRAIN BIOSAMPLE BIOPROJECT SRA LOCUSTAG
do
    BASE=$(echo -n "$SPECIES.$STRAIN" | perl -p -e 's/\s+/_/g')
    STRAIN_NOSPACE=$(echo -n "$STRAIN" | perl -p -e 's/\s+/_/g')
    echo "$BASE"
    MASKED=$(realpath $INDIR/$BASE.masked.fasta)
    if [ ! -f $MASKED ]; then
      echo "Cannot find $BASE.masked.fasta in $INDIR - may not have been run yet"
      exit
    fi
    TEMPLATE=$(realpath lib/sbt/GWSS.sbt)
    ANTISMASHRESULT=$OUTDIR/$name/annotate_misc/antiSMASH.results.gbk
    echo "$name $species"
    if [[ ! -f $ANTISMASHRESULT && -d $OUTDIR/$name/antismash_local ]]; then
		    ANTISMASH=$OUTDIR/$name/antismash_local/${SPECIES}_$name.gbk
		    if [ ! -f $ANTISMASH ]; then
          echo "CANNOT FIND $ANTISMASH in $OUTDIR/$name/antismash_local"
	      else
          rsync -a $ANTISMASH $ANTISMASHRESULT
        fi
    fi
	# need to add detect for antismash and then add that
    funannotate annotate --sbt $TEMPLATE --busco_db $BUSCO -i $OUTDIR/$BASE --species "$SPECIES" --strain "$STRAIN" --cpus $CPUS $MOREFEATURE $EXTRAANNOT
done
