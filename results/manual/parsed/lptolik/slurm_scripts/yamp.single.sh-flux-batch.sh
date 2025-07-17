#!/bin/bash
#FLUX: --job-name=YAMP
#FLUX: --queue=compute
#FLUX: -t=172800
#FLUX: --urgency=16

if test "$#" -ne 4; then
    echo "Script requires 4 parameters:"
    echo "Read1, Read2, sample name and output directory"
    echo "In that exact order"
    exit 2
fi
module load singularity
R1=$1
R2=$2
pref=$3
odir=$4
echo "Reads:"
echo "$R1"
echo "$R2"
echo "Output directory:"
echo "$odir"
echo "Sample name: $pref"
SING_WD=./work/singularity
SING_IMG=$SING_WD/alesssia-yampdocker.img
if [ -f "$SING_IMG" ]; then
    echo "$SING_IMG exist"
else 
    echo "$SING_IMG does not exist"
    mkdir -p $SING_WD
    cp /work/GoryaninU/Software/YAMP/alesssia-yampdocker.img $SING_IMG
fi
/work/GoryaninU/Software/nextflow run YAMP.nf --reads1 $R1 --reads2 $R2 --prefix $pref --outdir $odir --mode complete -with-singularity docker://alesssia/yampdocker
