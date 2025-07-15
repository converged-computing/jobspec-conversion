#!/bin/bash
#FLUX: --job-name=ornery-kerfuffle-1573
#FLUX: -N=64
#FLUX: -t=345600
#FLUX: --urgency=16

jobname="_A2_aspirin_ion_256_run1_"
date=$(date +%F);
date2=$(date +%F-%H.%M);
qstat -f $SLURM_JOBID >JobLog/$date2$jobname.qstat.txt;
mpirun -mode VN -np 256 -exe /usr/local/namd/2.7-xl-dcmf/bin/namd2  -args aspirin_opt.conf >OutputText/opt.$jobname.$date.out 2>Errors/opt.$jobname.$date.err;
mv *.dcd OutputFiles/
cp *.coor *.vel *.xsc *.xst RestartFiles/
mv generic_optimization.restart.coor generic_restartfile.restart.coor
mv generic_optimization.restart.vel  generic_restartfile.restart.vel
mv generic_optimization.restart.xsc  generic_restartfile.restart.xsc
for loop in {1..4} 
do 
basename="$date$jobname$loop" 
mpirun -mode VN -np 256 -exe /usr/local/namd/2.7-xl-dcmf/bin/namd2 -args aspirin_rs.conf >OutputText/$basename.out 2>Errors/$basename.err;
cp generic_restartfile.dcd   OutputFiles/$basename.dcd;
cp generic_restartfile.coor  RestartFiles/$basename.restart.coor;
cp generic_restartfile.vel   RestartFiles/$basename.restart.vel;
cp generic_restartfile.xsc   RestartFiles/$basename.restart.xsc;
cp generic_restartfile.xst   RestartFiles/$basename.xst;
done
sbatch sbatch_aspirin_continue
