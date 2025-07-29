#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$1" != "" ]; then
    echo "clustered waveform file provided: ${1}"		
    wfClusterFile=$1
    srun -c 1 -t 10 -p priority --mem=1G ~/scripts/R-3.4.1/activeClusterPairs.R "$wfClusterFile" 
else
    echo "Error: Need to provide input file: revised clustered waveforms e.g. wf.metrics.clustered.revised.csv"
fi
