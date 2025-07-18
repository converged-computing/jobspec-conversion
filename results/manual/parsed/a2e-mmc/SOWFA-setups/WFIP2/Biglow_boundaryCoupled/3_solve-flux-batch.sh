#!/bin/bash
#FLUX: --job-name=rBdCoupling_biglow
#FLUX: -n=128
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
writeIntervalBeforeAvg=5000
endTimeBeforeAvg=40000
startTimeAvg=$endTimeBeforeAvg
writeIntervalAvg=10000
endTimeAvg=60000
solver=superDeliciousVanilla
interp=linearupwind                 # midpoint, linearupwind
if [ ! -f foam1preprocess.log ];                  then echo "Job killed (1)"; scancel $SLURM_JOBID; fi
if [ ! -f system/controlDict.$solver ];           then echo "Job killed (2)"; scancel $SLURM_JOBID; fi
if [ ! -f setUp ];                                then echo "Job killed (3)"; scancel $SLURM_JOBID; fi
lastBdData=$(ls $(ls -d constant/boundaryData/* | head -1) | tail -2 | head -1)
if [ $(echo "($endTimeBeforeAvg-$startTime)%$writeIntervalBeforeAvg" | bc) -ne 0 ];   then touch "WARNING_1"; fi
if [ $(echo "($endTimeAvg-$startTimeAvg)%$writeIntervalAvg" | bc) -ne 0 ];            then touch "WARNING_2"; fi
if [ $(echo "${lastBdData%/} >= $endTimeAvg"|bc) -ne 1 ];                             then touch "WARNING_3"; fi
cp system/controlDict.$solver                          system/controlDict
cp system/fvSolution.flow                              system/fvSolution
cp system/fvSchemes.flow.$interp                       system/fvSchemes
latestTime=$(foamListTimes -processor -latestTime -withZero -noFunctionObjects | tail -1)
srun -n $cores renumberMesh -parallel -noFunctionObjects -overwrite > log.3.renumberMesh 2>&1
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
