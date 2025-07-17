#!/bin/bash
#FLUX: --job-name=blank-signal-3419
#FLUX: --queue=priority
#FLUX: -t=600
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$1" != "" ]; then
    echo "clustered waveform file provided: ${1}"		
    wfClusterFile=$1
    srun -c 1 -t 10 -p priority --mem=1G ~/scripts/R-3.4.1/activeClusterPairs.R "$wfClusterFile" 
else
    echo "Error: Need to provide input file: revised clustered waveforms e.g. wf.metrics.clustered.revised.csv"
fi
