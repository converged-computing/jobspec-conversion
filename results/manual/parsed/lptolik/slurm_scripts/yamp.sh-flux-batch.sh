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
cwdir=`pwd`
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
wd=$PWD
tempdir=$(mktemp -d /flash/GoryaninU/lptolik/YAMP.XXXXXX)
echo $tempdir
cd $tempdir
cp "$wd/nextflow.group.config" "$wd/YAMP.nf" "./"
cp -r "$wd/bin" "./tmp$pref/"
mv nextflow.group.config nextflow.config
SING_WD=./work/singularity
SING_IMG=$SING_WD/alesssia-yampdocker.img
if [ -f "$SING_IMG" ]; then
    echo "$SING_IMG exist"
else 
    echo "$SING_IMG does not exist"
    mkdir -p $SING_WD
    cp /bucket/GoryaninU/Software/YAMP/alesssia-yampdocker.img $SING_IMG
fi
module load singularity
mkdir -p "./$pref/"
/bucket/GoryaninU/Software/nextflow run YAMP.nf --reads1 $R1 --reads2 $R2 --prefix $pref --outdir "./$pref" --mode complete -with-singularity docker://alesssia/yampdocker
mkdir -p "./tmp$pref/"
datdir=`echo $wd| sed s/flash/bucket/`
ssh deigo "mkdir -p $odir/$pref"
scp "./$pref/*" deigo:"$odir/$pref"
cd $wd
rm -r $tempdir
