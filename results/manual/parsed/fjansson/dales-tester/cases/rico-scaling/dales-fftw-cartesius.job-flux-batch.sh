#!/bin/bash
#FLUX: --job-name=wobbly-lentil-6161
#FLUX: --urgency=16

module load 2019
module load netCDF-Fortran/4.4.4-foss-2018b
module load CMake/3.12.1-GCCcore-7.3.0
module unload OpenMPI/3.1.1-GCC-7.3.0-2.30
module load OpenMPI/3.1.4-GCC-7.3.0-2.30
module load Hypre/2.14.0-foss-2018b
module load FFTW/3.3.8-gompi-2018b
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
PROJECT=/projects/0/einf170/
CASE=`pwd`
WORK=$PROJECT/janssonf/dales-tester/rico-$TAG-$SYST-$OPT-$NX-$NY/$ID
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
