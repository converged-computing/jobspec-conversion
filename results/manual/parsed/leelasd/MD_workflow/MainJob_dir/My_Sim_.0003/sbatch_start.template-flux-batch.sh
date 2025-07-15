#!/bin/bash
#FLUX: --job-name=rainbow-train-0570
#FLUX: -N=2
#FLUX: -t=86400
#FLUX: --urgency=16

ntpn=8         # number of tasks per node: 
ppn=8         # processors per node:       <- not needed for pami version. 
module load namd-xl-pami-smp/2.9  # module file:
source ../../Scripts/common_functions.sh
read_master_config_file . 
jobname=$jobname_opt
ls slurm-* > .old_slurm_file
check_for_pausejob_flag
check_disk_quota
echo $runs > .total_runs.txt
echo $runs > .countdown.txt
echo $SLURM_JOBID >.current_job_id.txt
scontrol show job $SLURM_JOBID >>JobLog/$date2$jobname.optimization.txt;  # log job details
create_job_check_timestamps_1
basename="$date2.$jobname_opt";      # create timestamped basename for optimization
echo -e "O:Running" >.job_status
srun  --ntasks-per-node $ntpn  namd2 +ppn $ppn $optimize_script >OutputText/$basename.out 2>Errors/$basename.err;
echo -e "O:CleaningUp" >.job_status
create_job_check_timestamp_2
check_job_fail
job_log_timings
redirect_optimization_output
optimization_cleanup
check_for_pausejob_flag
echo -e "O:SubmittedProduction" >.job_status 
sbatch $sbatch_prod
