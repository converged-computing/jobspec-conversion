#!/bin/bash
#FLUX: --job-name=dales
#FLUX: -n=128
#FLUX: -t=86400
#FLUX: --priority=16

module load prgenv/gnu
module load gcc/11.1.0
module load openmpi
module load cmake/3.19.5
module load netcdf4/4.7.4
module load fftw/3.3.9
ID=$SLURM_ARRAY_TASK_ID
if [ -z "$TAG" ] 
then
    echo "Set variable TAG to the DALES version to run."
    exit
fi
if [ -z "$NX" ] 
then
    echo "Set variable NX to the number of tasks in x."
    exit
fi
if [ -z "$NY" ] 
then
    echo "Set variable NY to the number of tasks in y."
    exit
fi
NTOT=$(($NX*NY))
OPT=fftw
SYST=gnu-fast
NAMOPTIONS=namoptions-1728-fftw.001
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4
CASE=`pwd`
WORK=~/dales-tester-wrk/rico-$TAG-$SYST-$OPT-$NX-$NY/$ID
mkdir -p $WORK
cd $WORK
cp $CASE/{lscale.inp.001,$NAMOPTIONS,prof.inp.001,scalar.inp.001} ./
sed -i -r "s/irandom.*=.*/irandom = $ID/" $NAMOPTIONS
sed -i -r "s/nprocx.*=.*/nprocx = $NX/;s/nprocy.*=.*/nprocy = $NY/" $NAMOPTIONS
echo ID $ID
echo SYST $SYST
echo DALES $DALES
echo CASE $CASE
echo WORK $WORK
echo hostname `hostname`
echo SLURM_NTASKS $SLURM_NTASKS
echo NTOT $NTOT
echo NX,NY $NX,$NY
srun -n $NTOT $DALES $NAMOPTIONS | tee output.txt
