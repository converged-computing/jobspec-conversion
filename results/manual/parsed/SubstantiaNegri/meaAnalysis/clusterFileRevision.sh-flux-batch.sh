#!/bin/bash
#FLUX: --job-name=salted-hobbit-6799
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$1" != "" ]; then
    echo "clustered waveform file provided: ${1}"		
    wfClusterFile=$1
    srun -c 1 -t 10 -p priority --mem=4G ~/scripts/R-3.4.1/clusterFileRevision.R "$wfClusterFile" 
else
    echo "Error: Need to provide input file containing clustered waveforms e.g. wf.metrics.clustered.csv"
fi
