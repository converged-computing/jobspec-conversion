#!/bin/bash
#SBATCH --job-name=genCPseries
#SBATCH --output=genCPseries.out
#SBATCH --error=genCPseries.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=15:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

module load python/2.7.13
source $py2env/bin/activate
map_cpfluors="CPfluor/$1"
output_dir="CPseries/$1"
cpseq_file="/scratch/groups/herschla/roy-test/20210218_30mM_Mg_Lib4_run1_data/seqData/split-tile/temp/"
mkdir -p $output_dir
logfile="$output_dir/log"
errfile="$output_dir/err"
python $rnamap_scripst/array_fitting_tools/bin/generateCPseries.py -fs $cpseq_file -bs $map_cpfluors -od $output_dir -n 18  1> $logfile 2> $errfile
