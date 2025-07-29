#!/bin/bash
#SBATCH --job-name=genCPseries
#SBATCH --output=genCPseries.out
#SBATCH --error=genCPseries.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=15:00:00
#SBATCH --partition=biochem,owners,normal
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

module load python/2.7.13
source /home/groups/herschla/rna_map/scripts/env/bin/activate
if [ $# -ne 3 ]
then
    echo "Incorrect number of arguments"
    exit 1
fi
im_dir=$1 # Image directory name
cpseq_dir=$2
home_dir=$3
echo "Current image directory = $im_dir"
map_cpfluors=$home_dir"/CPfluor/"$im_dir
output_dir=$home_dir"/CPseries/"$im_dir
mkdir -p $output_dir
logfile="$output_dir/log"
errfile="$output_dir/err"
python /home/groups/herschla/rna_map/scripts/array_fitting_tools/bin/generateCPseries.py -fs $cpseq_dir -bs $map_cpfluors -od $output_dir -n 18  1> $logfile 2> $errfile
