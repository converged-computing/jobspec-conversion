#!/bin/bash
#FLUX: --job-name=paralleleMD
#FLUX: -c=12
#FLUX: --queue=True
#FLUX: --urgency=16

module load fftw2/intel/float/2.1.5  #Not sure about that one  
module load cuda/10.2                   
module load gromacs/2019/gmx     #I don't see gmx_mpi? 
rootdir=$PWD
j=0
for sim  in *prod ; do 
gpu=-1
while [[ $gpu = -1 ]] ;
do
if $( nvidia-smi | grep 0 | grep gmx) ; 
then if $( nvidia-smi | grep 1 | grep gmx); 
then if $( nvidia-smi | grep 2 | grep gmx);
then if $( nvidia-smi | grep 3 | grep gmx);
then sleep 1000 ;
else gpu=3 ; fi ;
else gpu=2 ; fi ;
else gpu=1 ; fi ;  
else gpu=0 ; fi ;
done
echo $sim
cp runme.bsh $sim 
cd $sim ;
echo $PWD
bash runme.bsh $j > output$sim.log 2> output$sim.stdout &
echo Simulation  $sim submitted on gpu id $j ;
j=$((j+1)) ; 
sleep 3 ; 
cd $rootdir;
done 
