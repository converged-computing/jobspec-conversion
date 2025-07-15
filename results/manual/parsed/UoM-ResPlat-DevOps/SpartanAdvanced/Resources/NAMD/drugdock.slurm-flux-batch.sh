#!/bin/bash
#FLUX: --job-name=red-carrot-3187
#FLUX: -N=2
#FLUX: -t=86400
#FLUX: --urgency=16

jobname="_A2_aspirin_short_example_01_"
date=$(date +%F);
date2=$(date +%F-%H.%M);
set CONV_RSH = ssh
module purge
module load spartan_2019
module load foss/2019b
module load namd/2.13-mpi
srun namd2  aspirin_opt_short.conf >OutputText/opt.$jobname.$date2.out 2>Errors/opt.$jobname.$date2.err;
mv *.dcd OutputFiles/
cp *.coor *.vel *.xsc *.xst RestartFiles/
mv generic_optimization.restart.coor generic_restartfile.restart.coor
mv generic_optimization.restart.vel  generic_restartfile.restart.vel
mv generic_optimization.restart.xsc  generic_restartfile.restart.xsc
for loop in {1..5} 
do 
basename="$date2$jobname$loop" 
srun namd2 aspirin_rs_short.conf >OutputText/$basename.out 2>Errors/$basename.err;
cp generic_restartfile.dcd   OutputFiles/$basename.dcd;
cp generic_restartfile.coor  RestartFiles/$basename.restart.coor;
cp generic_restartfile.vel   RestartFiles/$basename.restart.vel;
cp generic_restartfile.xsc   RestartFiles/$basename.restart.xsc;
cp generic_restartfile.xst   RestartFiles/$basename.xst;
done
mv FFTW* OutputText/;
rm *.BAK *.old *.coor *.vel *.xsc *.xst; 
mv *.e* JobLog/;
mv *.o* JobLog/;
