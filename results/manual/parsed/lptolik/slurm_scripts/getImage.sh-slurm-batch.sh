#!/bin/bash
#SBATCH --job-name=singIm
#SBATCH --output=getImage_%j.out
#SBATCH --error=getImage_%j.err
#SBATCH --mail-user=lptolik@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G

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
