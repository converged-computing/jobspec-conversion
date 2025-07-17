#!/bin/bash
#FLUX: --job-name=peachy-lettuce-7961
#FLUX: -c=24
#FLUX: --queue=REQUESTED_PARTITION
#FLUX: -t=360
#FLUX: --urgency=16

ptRoot=$(cd ..; pwd)
. "${ptRoot}/scripts/commonFunctionsForTests.sh"
binDir="${ptRoot}/${BIN_DIR}"
envDir="${ptRoot}/${ENV_DIR}"
codeDir="${ptRoot}/CodeDir"
logsDir="${ptRoot}/${LOGS_DIR}"
rundirsDir="${ptRoot}/${RUNDIRS_DIR}"
. ~/.bashrc               > /dev/null 2>&1
. ${envDir}/gcclassic.env > /dev/null 2>&1
head_gcc=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}" log --oneline --no-decorate -1)
head_gc=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
          git -C "${codeDir}/src/GEOS-Chem" log --oneline --no-decorate -1)
head_hco=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}/src/HEMCO" log --oneline --no-decorate -1)
scheduler="none"
[[ "x${SLURM_JOBID}" != "x" ]] && scheduler="SLURM"
[[ "x${LSB_JOBID}"   != "x" ]] && scheduler="LSF"
if [[ "x${scheduler}" == "xSLURM" ]]; then
    # SLURM
    export allThreads=${SLURM_CPUS_PER_TASK}
elif [[ "x${scheduler}" == "xLSF" ]]; then
    # LSF
    export allThreads=${LSB_DJOB_NUMPROC}
else
    # Interactive
    echo ""
    echo "Parallelization tests running..."
    allThreads=8
    # For AWS, set $OMP_NUM_THREADS to the available cores
    kernel=$(uname -r)
    [[ "x${kernel}" == "xaws" ]] && export allThreads=$(nproc)
fi
fewerThreads=$(( ${allThreads} / 2 ))
[[ $(( ${fewerThreads} % 2 )) -eq 0 ]] && let fewerThreads+=1
[[ "x${OMP_STACKSIZE}" == "x" ]] && export OMP_STACKSIZE=500m
numTests=$(count_rundirs "${rundirsDir}")
results="${logsDir}/results.parallel.log"
rm -f "${results}"
print_to_log "${SEP_MAJOR}"                                     "${results}"
print_to_log "GEOS-Chem Classic: Parallelization Test Results"  "${results}"
print_to_log ""                                                 "${results}"
print_to_log "GCClassic #${head_gcc}"                           "${results}"
print_to_log "GEOS-Chem #${head_gc}"                            "${results}"
print_to_log "HEMCO     #${head_hco}"                           "${results}"
print_to_log ""                                                 "${results}"
print_to_log "1st run uses ${allThreads} OpenMP threads"        "${results}"
print_to_log "2nd run uses ${fewerThreads} OpenMP threads"      "${results}"
print_to_log "Number of parallelization tests: ${numTests}"     "${results}"
print_to_log ""                                                 "${results}"
if [[ "x${scheduler}" == "xSLURM" ]]; then
    print_to_log "Submitted as SLURM job: ${SLURM_JOBID}"       "${results}"
elif  [[ "x${scheduler}" == "xLSF" ]]; then
    print_to_log "Submitted as LSF job: ${LSB_JOBID}"           "${results}"
else
    print_to_log "Submitted as interactive job"                 "${results}"
fi
print_to_log "${SEP_MAJOR}"                                     "${results}"
print_to_log " "                       "${results}"
print_to_log "Parallelization tests:"  "${results}"
print_to_log "${SEP_MINOR}"            "${results}"
let passed=0
let failed=0
let remain=${numTests}
cd "${rundirsDir}"
for runDir in *; do
    # Expand to absolute path
    runAbsPath="${rundirsDir}/${runDir}"
    # Do the following if for only valid GEOS-Chem run dirs
    expr=$(is_valid_rundir "${runAbsPath}")
    if [[ "x${expr}" == "xTRUE" ]]; then
        # Define log file
        log="${logsDir}/parallel.${runDir}.log"
        rm -f "${log}"
        # Messages for execution pass & fail
        passMsg="$runDir${FILL:${#runDir}}.....${EXE_PASS_STR}"
        failMsg="$runDir${FILL:${#runDir}}.....${EXE_FAIL_STR}"
        # Get the executable file corresponding to this run directory
        exeFile=$(exe_name "gcclassic" "${runAbsPath}")
        # Test if the executable exists
        if [[ -f "${binDir}/${exeFile}" ]]; then
            #----------------------------------------------------------------
            # If the executable file exists, we can do the tests
            #----------------------------------------------------------------
            # Change to this run directory
            cd "${runAbsPath}"
            # Copy the executable file here
            cp -f "${binDir}/${exeFile}" .
            # Remove any leftover files in the run dir
            ./cleanRunDir.sh --no-interactive >> "${log}" 2>&1
	    # Change time cycle flag in HEMCO_Config.rc from EFYO to CYS,
	    # to allow missing species to be set a default value.
	    sed_ie "s/EFYO/CYS/"            HEMCO_Config.rc  # GC_RESTART
	    sed_ie "s/EFY xyz 1/CYS xyz 1/" HEMCO_Config.rc  # GC_BCs
            #----------------------------------------------------------------
            # First test: Use all available threads
            #----------------------------------------------------------------
            # Run GEOS-Chem Classic
            export OMP_NUM_THREADS=${allThreads}
            echo "Now using ${OMP_NUM_THREADS}" >> "${log}" 2>&1
            if [[ "x${scheduler}" == "xSLURM" ]]; then
                srun -c ${allThreads} ./${exeFile} >> "${log}" 2>&1
            else
                ./${exeFile} >> "${log}" 2>&1
            fi
            # Rename the end-of-run restart file
            rename_end_restart_file "${allThreads}"
            # Clean the run directory
            ./cleanRunDir.sh --no-interactive >> "${log}" 2>&1
            #----------------------------------------------------------------
            # Second test: Use fewer cores
            #----------------------------------------------------------------
            # Run GEOS-Chem Classic
            export OMP_NUM_THREADS=${fewerThreads}
            echo "Now using ${OMP_NUM_THREADS}" >> "${log}" 2>&1
            if [[ "x${scheduler}" == "xSLURM" ]]; then
                srun -c ${fewerThreads} ./${exeFile} >> "${log}" 2>&1
            else
                ./${exeFile} >> "${log}" 2>&1
            fi
            # Rename the end-of-run restart file
            rename_end_restart_file "${fewerThreads}"
            #----------------------------------------------------------------
            # Score the test
            #----------------------------------------------------------------
            score_parallelization_test "${allThreads}" "${fewerThreads}"
            if [[ $? -eq 0 ]]; then
                let passed++
                print_to_log "${passMsg}" "${results}"
            else
                let failed++
                print_to_log "${failMsg}" "${results}"
            fi
            # Navigate back to the folder containing run directories
            cd "${rundirsDir}"
        else
            #----------------------------------------------------------------
            # If the executable is missing, update the "fail" counter
            # and write the "failed" message to the results log file.
            #----------------------------------------------------------------
            let failed++
            if [[ "x${results}" != "x" ]]; then
                print_to_log "${failMsg}" "${results}"
            fi
        fi
        # Decrement the count of remaining tests
        let remain--
    fi
done
print_to_log " "                                                  "${results}"
print_to_log "Summary of test results:"                           "${results}"
print_to_log "${SEP_MINOR}"                                       "${results}"
print_to_log "Parallelization tests passed: ${passed}"            "${results}"
print_to_log "Parallelization tests failed: ${failed}"            "${results}"
print_to_log "Parallelization tests not yet completed: ${remain}" "${results}"
if [[ "x${passed}" == "x${numTests}" ]]; then
    #--------------------------
    # Successful execution
    #--------------------------
    print_to_log ""                                               "${results}"
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"    "${results}"
    print_to_log "%%%  All parallelization tests passed!  %%%"    "${results}"
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"    "${results}"
    # Print success (if interactive)
    if [[ "x${SLURM_JOBID}" == "x" && "x${LSB_JOBID}" == "x" ]]; then
        echo ""
        echo "Parallelization tests finished!"
    fi
else
    #--------------------------
    # Unsuccessful execution
    #--------------------------
    if [[ "x${SLURM_JOBID}" == "x" && "x${LSB_JOBID}" == "x" ]]; then
        echo ""
        echo "Parallelization tests failed!  Exiting ..."
    fi
fi
unset binDir
unset codeDir
unset envDir
unset exeFile
unset failed
unset failmsg
unset head_gcc
unset head_gc
unset head_hco
unset log
unset logsDir
unset numTests
unset passed
unset passMsg
unset ptRoot
unset remain
unset results
unset rundirsDir
unset scheduler
unset FILL
unset LINE
unset CMP_PASS_STR
unset CMP_FAIL_STR
unset EXE_PASS_STR
unset EXE_FAIL_STR
