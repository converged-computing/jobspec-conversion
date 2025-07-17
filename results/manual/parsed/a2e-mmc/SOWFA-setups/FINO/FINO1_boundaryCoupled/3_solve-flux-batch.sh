#!/bin/bash
#FLUX: --job-name=rBdCoupling_fino
#FLUX: -n=144
#FLUX: -t=864000
#FLUX: --urgency=16

source $HOME/.bash_profile
cores=$SLURM_NTASKS
echo "Working directory is" $SLURM_SUBMIT_DIR
echo "Job name is" $SLURM_JOB_NAME
echo "Submit time is" $(squeue -u $USER -o '%30j %20V' | grep -e $SLURM_JOB_NAME | awk '{print $2}')
echo "Starting OpenFOAM job at: " $(date)
echo "using" $cores "core(s)"
OpenFOAM-6-gcc-dev 	            # OpenFOAM/SOWFA version. OpenFOAM-6-{gcc,intel}-{central,dev}
startTime=0                     # Start or map time (DO NOT change for restarted runs)
writeIntervalBeforeAvg=1800
endTimeBeforeAvg=10800
startTimeAvg=$endTimeBeforeAvg
writeIntervalAvg=3600
endTimeAvg=25200
solver=superDeliciousVanilla
interp=linearupwind                 # midpoint, linearupwind. divSchemes midpoint needed for gravity waves
cp system/sampling/vmasts_1kmGrid.bak           system/sampling/vmasts_1kmGrid
cp system/sampling/vmasts_small3x3Grid.bak      system/sampling/vmasts_small3x3Grid
cp system/sampling/slicesFINO1_correlation.bak  system/sampling/slicesFINO1_correlation
if [ ! -f foam1preprocess.log ];                  then echo "Job killed (1)"; scancel $SLURM_JOBID; fi
if [ ! -f system/controlDict.$solver ];           then echo "Job killed (2)"; scancel $SLURM_JOBID; fi
if [ ! -f setUp ];                                then echo "Job killed (3)"; scancel $SLURM_JOBID; fi
lastBdData=$(ls $(ls -d constant/boundaryData/* | head -1) | tail -2 | head -1)
cp system/controlDict.$solver                          system/controlDict
cp system/fvSchemes.flow.$interp                       system/fvSchemes
latestTime=$(foamListTimes -processor -latestTime -withZero -noFunctionObjects | tail -1)
if [ $latestTime -lt $endTimeBeforeAvg ]; then
    foamDictionary -entry "temporalAverages.enabled" -set "false" system/sampling/temporalAverages
    foamDictionary -entry "startTime" -set $latestTime -disableFunctionEntries system/controlDict
    foamDictionary -entry "endTime" -set $endTimeBeforeAvg -disableFunctionEntries system/controlDict
    foamDictionary -entry "writeInterval" -set $writeIntervalBeforeAvg -disableFunctionEntries system/controlDict
    srun -n $cores --cpu_bind=cores $solver -parallel > log.3.$solver.startAt$latestTime 2>&1
fi
continueTime=$(( $latestTime > $endTimeBeforeAvg ? $latestTime : $startTimeAvg ))
foamDictionary -entry "temporalAverages.timeStart" -set $startTimeAvg system/sampling/temporalAverages
foamDictionary -entry "temporalAverages.enabled"   -set "true" system/sampling/temporalAverages
foamDictionary -entry "startTime" -set $continueTime -disableFunctionEntries system/controlDict
foamDictionary -entry "endTime" -set $endTimeAvg -disableFunctionEntries system/controlDict 
foamDictionary -entry "writeInterval" -set $writeIntervalAvg -disableFunctionEntries system/controlDict
srun -n $cores --cpu_bind=cores $solver -parallel > log.3.$solver.startAt$continueTime 2>&1
echo "Ending OpenFOAM job at: " $(date)
mv foam3run_${SLURM_JOBID}.log foam3run_startAt$continueTime
