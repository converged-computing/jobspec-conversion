#!/bin/bash
#FLUX: --job-name=adorable-peanut-6007
#FLUX: -n=24
#FLUX: --queue=intel
#FLUX: -t=259200
#FLUX: --urgency=16

module load funannotate
module load iprscan
CPU=1
if [ ! -z $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
OUTDIR=annotate
SAMPFILE=samples.csv
N=${SLURM_ARRAY_TASK_ID}
if [ ! $N ]; then
  N=$1
  if [ ! $N ]; then
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
tail -n +2 $SAMPFILE | sed -n ${N}p | while read SPECIES STRAIN VERSION PHYLUM BIOSAMPLE BIOPROJECT LOCUSTAG
do
  BASE=$(echo -n ${SPECIES}_${STRAIN}.${VERSION} | perl -p -e 's/\s+/_/g')
  name=$BASE
  echo "$BASE"
  MASKED=$(realpath $INDIR/$BASE.masked.fasta)
  if [ ! -d $OUTDIR/$name ]; then
    echo "No annotation dir for ${name}"
    exit
  fi
  mkdir -p $OUTDIR/$name/annotate_misc
  XML=$OUTDIR/$name/annotate_misc/iprscan.xml
  IPRPATH=$(which interproscan.sh)
  if [ ! -f $XML ]; then
    funannotate iprscan -i $OUTDIR/$name -o $XML -m local -c $CPU --iprscan_path $IPRPATH
  fi
done
