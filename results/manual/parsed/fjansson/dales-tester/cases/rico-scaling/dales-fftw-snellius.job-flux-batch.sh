#!/bin/bash
#FLUX: --job-name=creamy-eagle-7187
#FLUX: --queue=rome
#FLUX: -t=28800
#FLUX: --urgency=16

module load 2022
module load foss/2022a
module load netCDF-Fortran/4.6.0-gompi-2022a
module load CMake/3.23.1-GCCcore-11.3.0
module load Hypre/2.25.0-foss-2022a # optional
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
DALES=`pwd`/../../build-$TAG-$SYST/src/dales4*
CASE=`pwd`
WORK=$SCRATCH/dales-tester/rico-$TAG-$SYST-$OPT-$NX-$NY/$ID
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
