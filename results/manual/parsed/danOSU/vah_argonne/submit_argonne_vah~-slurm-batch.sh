#!/bin/bash
#SBATCH --job-name=Pb_Pb_2760_MAP_VAH
#SBATCH --account=unedf_optimization
#SBATCH --mail-user=liyanage.5@osu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=bdws
#SBATCH --constraint=ntasks-per-node=5

module reset
module load singularity
printf "Start time: "; /bin/date
printf "Job is running on node: "; /bin/hostname
printf "Job running as user: "; /usr/bin/id
printf "Job is running in directory: "; pwd
inputdir="/home/ac.liyanage/vah_run_events/$1/" #where the tables for iS3D, smash... are located. design_pts should be a folder inside!
echo "inputdir = "
echo $inputdir
SCRATCH="/lcrc/globalscratch/dan"
echo "scratch = "
echo ${SCRATCH}
job=$SLURM_JOB_ID
echo "job : "
echo $job
mkdir $SCRATCH/$job
n_cores=15
let max_cores=$n_cores-1
for j in $(seq 0 $max_cores)
do
 singularity exec -B $SCRATCH:/scr ~/jetscape_vah sh event.sh $j $inputdir $job &
done
wait
echo "All events have finished. Goodbye!"
