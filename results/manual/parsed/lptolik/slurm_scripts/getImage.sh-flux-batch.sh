#!/bin/bash
#FLUX: --job-name=singIm
#FLUX: --queue=short
#FLUX: --urgency=16

datdir=$1
echo $datdir
wd=$PWD
tempdir=$(mktemp -d /flash/GoryaninU/lptolik/makeTSV.XXXXXX)
echo $tempdir
cd $tempdir
module load singularity
singularity pull  --name alesssia-yampdocker.img docker://alesssia/yampdocker
ssh deigo "mkdir -p $datdir/work/singularity/"
scp "alesssia-yampdocker.img" deigo:"$datdir/work/singularity/"
cd $wd
rm -r $tempdir
mkdir -p ./work/singularity/
cp alesssia-yampdocker.img ./work/singularity/alesssia-yampdocker.img
