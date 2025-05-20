#!/bin/bash

# Flux directives
#flux: -N 2
#flux: --tasks-per-node=8
#flux: -n 16
#flux: -t 24h
#flux: -o flux.job.%J.out
#flux: -e flux.job.%J.err

### - job basename ---------------------------------------------------------
jobname="_A2_aspirin_short_example_01_"
### ------------------------------------------------------------------------

date=$(date +%F)
date2=$(date +%F-%H.%M)

# Environment variable for NAMD (corrected from csh to bash syntax)
export CONV_RSH=ssh

echo "Loading modules at $(date)"
module purge
module load spartan_2019
module load foss/2019b
module load namd/2.13-mpi
echo "Modules loaded."

# Ensure output directories exist
# It's good practice to create them if they might not exist.
echo "Creating output directories if they do not exist..."
mkdir -p OutputText Errors OutputFiles RestartFiles JobLog
echo "Output directories checked/created."

### --------------------------------------------------------------------------
## optimize the original molecule

echo "Starting optimization step for $jobname at $(date)"
# flux run will utilize the resources allocated to the job (2 nodes, 16 tasks total)
flux run namd2 aspirin_opt_short.conf >OutputText/opt.$jobname.$date2.out 2>Errors/opt.$jobname.$date2.err
echo "Optimization step finished at $(date)"

echo "Moving optimization output files at $(date)"
# Check if dcd files exist before moving to avoid errors if NAMD fails to produce them
if ls *.dcd 1> /dev/null 2>&1; then
    mv *.dcd OutputFiles/
else
    echo "Warning: No .dcd files found to move after optimization."
fi
# Assuming .coor, .vel, .xsc, .xst are always produced or their absence is an error handled by NAMD output
cp *.coor *.vel *.xsc *.xst RestartFiles/
echo "Optimization output files moved."

## Move generic_optimmization output to generic_restart files:
echo "Renaming optimization restart files at $(date)"
mv generic_optimization.restart.coor generic_restartfile.restart.coor
mv generic_optimization.restart.vel  generic_restartfile.restart.vel
mv generic_optimization.restart.xsc  generic_restartfile.restart.xsc
echo "Optimization restart files renamed."

### start a loop ------------------------------------------------------------
### aiming for 1 ns a round

echo "Starting production loops at $(date)"
for loop in {1..5}
do
    basename="$date2$jobname$loop"
    echo "Starting loop $loop: $basename at $(date)"

    ## run namd job:
    flux run namd2 aspirin_rs_short.conf >OutputText/$basename.out 2>Errors/$basename.err

    ## rename output and move data into folders
    echo "Processing output for loop $loop ($basename) at $(date)"
    # Check if source files exist before copying
    if [ -f "generic_restartfile.dcd" ]; then
        cp generic_restartfile.dcd   OutputFiles/$basename.dcd
    else
        echo "Warning: generic_restartfile.dcd not found for loop $loop."
    fi
    cp generic_restartfile.coor  RestartFiles/$basename.restart.coor
    cp generic_restartfile.vel   RestartFiles/$basename.restart.vel
    cp generic_restartfile.xsc   RestartFiles/$basename.restart.xsc
    cp generic_restartfile.xst   RestartFiles/$basename.xst
    echo "Finished loop $loop ($basename) at $(date)"
done
echo "All production loops finished at $(date)"
### --------------------------------------------------------------------------

## cleanup
echo "Starting cleanup at $(date)"

# Move FFTW files if they exist
if ls FFTW* 1> /dev/null 2>&1; then
    mv FFTW* OutputText/
    echo "FFTW files moved to OutputText."
else
    echo "No FFTW* files found to move."
fi

# Remove intermediate and backup files from current working directory
# These were copied to RestartFiles earlier if they were final restart states
echo "Removing temporary files: *.BAK *.old *.coor *.vel *.xsc *.xst"
rm -f *.BAK *.old *.coor *.vel *.xsc *.xst

# Move main job log files to JobLog directory
# Flux output files will be named flux.job.<FLUX_JOB_ID>.out and flux.job.<FLUX_JOB_ID>.err
# The wildcards *.o* and *.e* should catch these.
echo "Moving main job log files to JobLog directory..."
if ls *.o* 1> /dev/null 2>&1; then
    mv *.o* JobLog/
else
    echo "No *.o* (output) files found to move to JobLog."
fi

if ls *.e* 1> /dev/null 2>&1; then
    mv *.e* JobLog/
else
    echo "No *.e* (error) files found to move to JobLog."
fi

echo "Cleanup finished at $(date)"
echo "Job completed."