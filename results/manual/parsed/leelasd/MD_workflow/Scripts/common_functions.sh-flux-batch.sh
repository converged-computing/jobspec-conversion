#!/bin/bash
#FLUX: --job-name=chunky-signal-2245
#FLUX: --priority=16

read_master_config_file() {
fpath=$1
if [ -f $fpath/master_config_file ]; 
  then
    . $fpath/master_config_file 
  else
    echo -e " "master_config_file" not found in $fpath " 
    echo -e " Exiting. " 
    exit 
fi
}
check_directory() {
dir=$1
cdir=`pwd`
y=`basename $cdir`
if [ $y != $dir ]; 
  then
    echo -e "\n You really should run this script from the /$dir directory.\n  Nothing done.\n" 
    exit
fi
}
timing_data_miner(){
fs=$(less $1 |grep "Info: TIMESTEP" | awk '{print $3}');
namdv=$(less $1 | grep "Info: NAMD" |awk '{print $2$3$4$5$6}'); 
cores=$(less $1 | grep CPUs | tail -n1 |awk '{print $4}'); 
natoms=$(less $1 | awk -F: '/STRUCTURE SUMMARY:/ && $0 != "" { getline; print $2 }');
seed=$(less $1 |grep "SEED" | awk '{print $5}');
son=$(less $1 |grep "SWITCHING ON" | awk '{print $4}');
sof=$(less $1 |grep "SWITCHING OFF" | awk '{print $4}');
pli=$(less $1 |grep "PAIRLIST DISTANCE" | awk '{print $4}');
switching="$son $sof $pli"; 
pat=$(less $1 |grep "AWAY" | awk '{print $5, $7, $9}');
lpa=$(less $1 |grep "LARGEST PATCH" | awk '{print $6}');
mpa=$(less $1 |grep "MIN ATOMS" | awk '{print $6}');
ss=$(grep "TIMING:"  $1  | tail -n3 | awk 'BEGIN{ FS="[ /]"}{t=t+$6}END{printf "\t%12.6f \n" ,(t/3)}');
ting="$cores $fs $ss $namdv $seed $natoms "; 
echo $ting |awk '{printf "%-5s\t%6.4f\t%8.3f ns/d\n", $1, $3, ((0.0864*$2)/$3) }';
timing_extra=$(echo -e "Switching:$switching \t Patches:$pat \t largest patch: $lpa \t min atoms/patch: $mpa \t seed: $seed"); 
}
check_existing_job_directories() {
if [ -f $JOB_DIR/.gitkeep ]; then
  rm $JOB_DIR/.gitkeep
fi
if [ "$(ls -A $JOB_DIR )" ]; then
 echo -e  "\n$JOB_DIR is not empty! \nSetting up new directories aborted to avoid overwriting existing data!" 
 echo -e  "\n\"./create_job_directories\" script is usually only run once before populating and starting jobs." 
 echo -e  "You can use \"./erase_all_data_cleanup_script\" to remove all job directories. (and data! -be careful!) \n" 
 echo -e  "Exiting." 
 exit 
fi
}
create_new_job_directories() {
echo -e  "Creating new job directories: \n" 
while [ $sims -gt 0 ];
 do
  if [ $sims -lt 10 ]; then
    cp -r Setup_and_Config/JobTemplate $JOB_DIR/$BaseDirName.000$sims
    echo "Creating directory: $BaseDirName.000$sims"
    echo $BaseDirName.00$sims >> $JOB_DIR/$BaseDirName.000$sims/.jobdir_id
  fi
  if [ $sims -gt 9 -a $sims -lt 100 ]; then
    cp -r Setup_and_Config/JobTemplate $JOB_DIR/$BaseDirName.00$sims
    echo "Creating directory: $BaseDirName.00$sims"
    echo $BaseDirName.0$sims >> $JOB_DIR/$BaseDirName.00$sims/.jobdir_id
  fi
  if [ $sims -gt 99 -a $sims -lt 1000 ]; then
    cp -r Setup_and_Config/JobTemplate $JOB_DIR/$BaseDirName.0$sims
    echo "Creating directory: $BaseDirName.0$sims"
    echo $BaseDirName.$sims >> $JOB_DIR/$BaseDirName.0$sims/.jobdir_id
  fi
  if [ $sims -gt 999 -a $sims -lt 10000 ]; then
    cp -r Setup_and_Config/JobTemplate $JOB_DIR/$BaseDirName.$sims
    echo "Creating directory: $BaseDirName.$sims"
    echo $BaseDirName.$sims >> $JOB_DIR/$BaseDirName.$sims/.jobdir_id
  fi
let sims=sims-1
done
echo -e "\n done creating directories!  \n"
ls $JOB_DIR/ > .dir_list.txt
echo -e "\n\n Don't forget to populate your Job directories with your sbatch and config files! \n " 
echo -e "\n\n Use ./populate_config_files.sh \n " 
}
check_directory_list() {
fpath=$1
if [ -f $fpath/.dir_list.txt ]; then
  # all ok  .dir_list.txt present.
  echo -e ""
 else
  echo -e  "\n $JOB_DIR appears empty! No .dir_list.txt file. " 
  echo -e  "\n Nothing to do here.  have you run ./create_job_directories yet? "
  echo -e  "\n or try: 'ls /$JOB_DIR/ > .dir_list.txt'  \n Exiting! " 
  exit
fi
}
create_sbatch_files() {
for z in $sbatch_start $sbatch_prod
 do
  cp $z  $z.temp
  sed -i  's/#SBATCH --nodes=X/#SBATCH --nodes='"$nodes"'/' $z.temp
  sed -i  's/#SBATCH --time=X/#SBATCH --time='"$walltime"'/' $z.temp
  sed -i  's/#SBATCH --account=X/#SBATCH --account='"$account"'/' $z.temp
  sed -i  's/ntpn=X/ntpn='"$ntpn"'/' $z.temp
  sed -i  's/ppn=X/ppn='"$ppn"'/' $z.temp
  sed -i  's/module load X/module load '"$modulefile"'/' $z.temp
done
}
populate_job_directories(){
y=$(cat ../.dir_list.txt) 
for i in $y
 do
 echo -e "\nCopying sbatch files to   \t\t/$JOB_DIR/$i "
  cp $sbatch_start.temp  ../$JOB_DIR/$i/$sbatch_start
  cp $sbatch_prod.temp   ../$JOB_DIR/$i/$sbatch_prod
  echo -e "Copying config *.conf files to  \t/$JOB_DIR/$i "
  cp $optimize_script   ../$JOB_DIR/$i/
  cp $production_script ../$JOB_DIR/$i/
  echo -e "Copying master_config_file file to  \t/$JOB_DIR/$i "
  cp master_config_file   ../$JOB_DIR/$i/
 done
}
cleanup_sbatch_files() { 
rm $sbatch_start.temp $sbatch_prod.temp
}
cleanup_old_slurm_files(){
if [ -f .old_slurm_file ]; then
 slm=$(cat .old_slurm_file | tail -n 1  )
 mv $slm JobLog/
fi
ls slurm-* > .old_slurm_file
}
check_for_pausejob_flag(){
if [ -f pausejob ]; then
 echo -e " Pausejob flag present: Perhaps last job failed? Exiting."  
 echo -e "P:Paused">.job_status
 exit
fi
}
check_disk_quota(){
diskspace=$( mydisk | grep $account | awk '{print $5}' | sed s/\%// )
if [ "$diskspace" -gt $diskspacecutoff ]; then
 echo -e " Warning: diskspace for this account is low! Check disk quotas  (mydisk)  " 
 echo -e " Clean up your files! Exiting. " 
 echo -e "P:DiskQuotaFull" >.job_status
 touch pausejob
 exit
fi
}
check_countdown_file(){
if [ -f .countdown.txt ]; then
  y=$(cat .countdown.txt )
 else
  echo -e " Countdown file not found (.countdown.txt).  Exiting." 
  echo -e "P:NoCountdownFlag" >.job_status
  touch pausejob
 exit
fi
if [ $y -lt 1 ]; then
 echo -e " Job countdown less than 1. Consecutive jobs finished! Exiting." 
 echo -e "P:Finished" >.job_status
 exit
fi
}
create_job_check_timestamps_1() {
 jfc1=$(date +%s);                    # jobfailcheck time stamp1
 date=$(date +%F);                    # date stamps
 date2=$(date +%F-%H.%M);             # date stamps
 basename="$date2.$jobname_prod.$y";  # create timestamped basename for production run
}
create_job_check_timestamps_2() {
jfc2=$(date +%s);                     # jobfailcheck time stamp2
let runtime=$jfc2-$jfc1;              # job run time.           
}
check_job_fail() {
if [ $runtime -lt $jobfailtime ];
 then
  j=$(cat .jobdir_id );
  c=$(cat .current_job_id.txt);
  date2=$(date +%F-%H.%M);
  echo -e "$j $c failed at $date2 at stage $y " >> ../../JobLog/Failed_job_list.txt
  echo -e "P:JobFinishedEarly:Crash?" >.job_status
  touch pausejob;                 # create pause flag 
  exit
fi
}
create_job_log(){
echo $SLURM_JOBID >.current_job_id.txt;
scontrol show job $SLURM_JOBID >>JobLog/$date2.$jobname_prod.$y.txt; # log job details
}
log_job_timings() {
jobhours=$(echo $runtime | awk '{printf "%.3f hours", $1/3600}');
timing=$(timing_data_miner OutputText/$basename.out); # mine timing data
echo "nodes   tpn     ppn     cores    s/step   ns/day " >>JobLog/timing_data_log.txt
echo -e "$nodes\t$ntpn\t$ppn\t$timing" >>JobLog/timing_data_log.txt
echo $basename  $jobhours              >>JobLog/timing_data_log.txt;    # log timing data
}
redirect_output_files() {
for f in generic_restartfile*
do
 case $f in
  *.dcd)  mv $f OutputFiles/$basename.dcd;;
  *.coor) cp $f RestartFiles/$basename.coor; cp $f LastRestart/;;
  *.vel)  cp $f RestartFiles/$basename.vel;  cp $f LastRestart/;;
  *.xsc)  cp $f RestartFiles/$basename.xsc;  cp $f LastRestart/;;
  *.xst)  cp $f RestartFiles/$basename.xst;;
  *.colvars.state) cp $f RestartFiles/$basename.colvars.state;;
  *.colvars.traj)  cp $f RestartFiles/$basename.colvars.traj;;
 esac
done
echo $basename.dcd >>OutputFiles/dcd_list.txt
rm *.BAK  *.old;                 # clean up files
}
redirect_optimization_output() {
for f in generic_optimization*
do
 case $f in
  *.coor)  cp $f RestartFiles/opt.$basename.coor; mv $f generic_restartfile.coor;;
  *.vel)   cp $f RestartFiles/opt.$basename.vel;  mv $f generic_restartfile.vel;;
  *.xsc)   cp $f RestartFiles/opt.$basename.xsc;  mv $f generic_restartfile.xsc;;
  *.colvars.state) mv $f RestartFiles/opt.$basename.colvars.state;;
  *.colvars.traj)  mv $f RestartFiles/opt.$basename.colvars.traj;;
  *.dcd)            mv $f OutputFiles/opt.$basename.dcd.x;;
 esac
done
}
optimization_cleanup() {
j=$(cat .jobdir_id );
c=$(cat .current_job_id.txt);
rm generic_optimization.*.BAK
if [ -f core.* ]
 then
  echo -e " $j $c core files generated. something wrong?  Moved core files to /Errors " >> ../../JobLog/Failed_job_list.txt; # log job failure
  echo -e "O:CoreDumpsPresent" >.job_status
 touch pausejob;                 # create pause flag 
 mv core.*   Errors/
fi
 echo "$j $c optimisation finished at $date2 " >> ../../JobLog/Finished_job_list.txt
}
countdown_timer(){
y=$(cat .countdown.txt )
let y=$y-1;
echo $y>.countdown.txt;
}
check_for_end_of_run(){
y=$(cat .countdown.txt )
if [ $y -lt 1 ];
then
 mv FFTW* OutputText/;
 rm *.BAK *.old *.coor *.vel *.xsc *.xst *.state *.traj;
 mv pbs_*.e* Errors/;
 mv pbs_*.o* JobLog/;
 mv slurm-*  JobLog/;
 mv core*    Errors/;
 echo -e "P:Finished" >.job_status
 cd OutputFiles
  ./create_dcd_loader_script
 cd ../
 j=$(cat .jobdir_id )
 c=$(cat .current_job_id.txt)
 date2=$(date +%F-%H.%M);
 echo -e "$j $c finished at $date2 " >> ../../JobLog/Finished_job_list.txt
 exit
fi
}
make_temp_showq_list(){
me=$( whoami ) 
showq -u "$me" > .temp_showq.txt
}
check_for_running_job(){
if [ -f .current_job_id.txt ]; then
 j=$(cat .current_job_id.txt | tail -n 1 )
 js=$(cat ../../.temp_showq.txt  |grep $j | awk '{print $3 }');
 if [ "$js" == "RUNNING" ];
 then
  echo -e " $i - appears a job is already running here!: $j" 
 fi
fi
}
check_for_zero_countdown(){
if [ -f .countdown.txt ]; then
 j=$(cat .countdown.txt )
 if [ $j -lt 1 ]; then
  echo -e "countdown timer at zero "
 else 
  echo -e ".coundown.txt  Round in $i not finished. Countdown: $j "
  echo -e "Can't reinitialize new production rounds till all job rounds finished. \n exiting." 
 exit
 fi
else
 echo -e "Can't find .countdown.txt file in $i "
 echo -e "exiting! "
 exit
fi
}
