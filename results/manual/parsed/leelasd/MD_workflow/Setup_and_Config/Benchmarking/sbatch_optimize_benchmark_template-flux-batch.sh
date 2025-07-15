#!/bin/bash
#FLUX: --job-name=joyous-carrot-1721
#FLUX: -N=8
#FLUX: -t=14400
#FLUX: --urgency=16

ntpn=32
jobname=optimize_bench
module load namd-xl-pami/2.9
if [ -f ../master_config_file ];then
. ../master_config_file
else 
 echo -e "\n Can't find "master_config_file"!\n"
 exit
fi
date=$(date +%F);
date2=$(date +%F-%H.%M);
scontrol show job $SLURM_JOBID >>JobLog/$date2$jobname_prod.qstat.txt;
echo $SLURM_JOBID >>JobLog/current_job_id.txt
basename="$date2.$jobname" 
srun  --ntasks-per-node=$ntpn  namd2 bench_opt.conf >OutputText/$basename.out 2>Errors/$basename.err;
timing=$(../../Scripts/Tools/timing_data_miner OutputText/$basename.out);
echo $basename  $jobhours "hours runtime " $timing  >>TimingData/timing_data_log.txt;
rm FFTW*
rm *.restart* 
rm *.old 
rm *.colvars* 
rm *.BAK
rm *.dcd 
rm *.xst
mv slur* Errors/
