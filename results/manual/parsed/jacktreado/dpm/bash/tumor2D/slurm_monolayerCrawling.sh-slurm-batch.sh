#!/bin/bash
#SBATCH --job-name=crawlingMonoProcess
#SBATCH --output=out/crawlingMonoProcess.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=04:00:00
#SBATCH --partition=scavenge

module load MATLAB
netid="$USER"
NT=$1
NCELLS=$2
n=$3
tc=$4
l1=$5
Dr=$6
gamtt=$7
tau=$8
fpattern=mono_NT"$NT"_N"$NCELLS"_n"$n"_tc"$tc"_l1"$l1"_Dr"$Dr"_gamtt"$gamtt"_tau"$tau"
simloc=/gpfs/loomis/pi/ohern/"$netid"/dpm/tumor2D/mono
floc="$simloc"/"$fpattern"
saveloc=$simloc/matfiles
mkdir -p $saveloc
savestr=$saveloc/"$fpattern".mat
MCODE="addpath ~/dpm/viz/tumor2D/; processCrawlingMonolayer($NCELLS,'$floc','$saveloc','$fpattern'); quit"
echo running in matlab
matlab -nodisplay -r "$MCODE"
echo finished running in matlab
