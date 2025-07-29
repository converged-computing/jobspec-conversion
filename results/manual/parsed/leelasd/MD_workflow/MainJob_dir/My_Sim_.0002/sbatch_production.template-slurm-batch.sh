#!/bin/bash
#SBATCH --account=VR0021
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

ntpn=8         # number of tasks per node: 
ppn=8          # processors per node: 
module load namd-xl-pami-smp/2.9  # module file:
source ../../Scripts/common_functions.sh
read_master_config_file . 
jobname=$jobname_prod.$round
cleanup_old_slurm_files
check_for_pausejob_flag
check_disk_quota
check_countdown_file
create_job_check_timestamps_1
create_job_log
echo -e "P:Running" >.job_status
srun  --ntasks-per-node $ntpn  namd2 +ppn $ppn $production_script >OutputText/$basename.out 2>Errors/$basename.err;
echo -e "P:CleaningUp" >.job_status
create_job_check_timestamps_2
check_job_fail
log_job_timings
redirect_output_files
countdown_timer
check_for_end_of_run
check_for_pausejob_flag
echo -e "P:Submitted">.job_status
sbatch $sbatch_prod
