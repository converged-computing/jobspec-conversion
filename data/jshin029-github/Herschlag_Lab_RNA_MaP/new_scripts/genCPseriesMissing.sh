#!/bin/bash 
#
# bash script to call quantifyTilesDownstream.py using SLURM scheduler on Sherlock
#
# Usage: quantify_images.sbatch image_dir seq_dir roff_dir fluor_dir gv_path
#
#all commands that start with SBATCH contain commands that are just used by SLURM for scheduling  
#################
#set a job name  
#SBATCH --job-name=genCPseries
#################  
#a file for job output, you can check job progress
#SBATCH --output=genCPseries.out
#################
# a file for errors from the job
#SBATCH --error=genCPseries.err
#################
#time you think you need; default is one hour
#in minutes in this case, hh:mm:ss
#SBATCH --time=15:00:00
#################
#quality of service; think of it as job priority
#SBATCH --partition=biochem,owners,normal
#SBATCH --qos=normal
#################
#number of nodes you are requesting
#SBATCH --nodes=1
#################
#tasks to run per node; a "task" is usually mapped to a MPI processes.
# for local parallelism (OpenMP or threads), use "--ntasks-per-node=1 --cpus-per-task=16" instead
# Sherlock nodes have 16 cpus. For some reason, you can request more than that on 'owners' partition, but not on others. 
# It can't give you more obviously, but it's interesting that it lets you ask on one partion but not another.
# Note: On Sherlock2, most of the nodes we have access to have 20 cores. 
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=18
#################


module load python/2.7.13
source $py2env/bin/activate

## Usage: sbatch genCPseries.sh [experiment folder name]
## e.g.: sbatch genCPseries.sh 13_0p91_equilibrium_green

# Define paths
map_cpfluors="CPfluor/$1"
output_dir="CPseries/$1"
cpseq_file="/scratch/groups/herschla/roy-test/20210218_30mM_Mg_Lib4_run1_data/seqData/split-tile/temp/"

mkdir -p $output_dir

logfile="$output_dir/log"
errfile="$output_dir/err"

#python $KdScripts/processData.py -od $output_dir -mf $map_cpfluors -cf $cpseq_file 1> $logfile 2> $errfile
python $rnamap_scripst/array_fitting_tools/bin/generateCPseries.py -fs $cpseq_file -bs $map_cpfluors -od $output_dir -n 18  1> $logfile 2> $errfile

