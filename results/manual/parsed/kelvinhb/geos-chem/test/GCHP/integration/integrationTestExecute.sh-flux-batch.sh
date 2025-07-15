#!/bin/bash
#FLUX: --job-name=salted-hippo-7824
#FLUX: --priority=16

itRoot=$(cd ..; pwd)
. "${itRoot}/scripts/commonFunctionsForTests.sh"
binDir="${itRoot}/${BIN_DIR}"
envDir="${itRoot}/${ENV_DIR}"
codeDir="${itRoot}/CodeDir"
logsDir="${itRoot}/${LOGS_DIR}"
rundirsDir="${itRoot}/${RUNDIRS_DIR}"
. ~/.bashrc          > /dev/null 2>&1
. ${envDir}/gchp.env > /dev/null 2>&1
head_gchp=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}" log --oneline --no-decorate -1)
head_gc=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
          git -C "${codeDir}/src/GCHP_GridComp/GEOSChem_GridComp/geos-chem" \
          log --oneline --no-decorate -1)
head_hco=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}/src/GCHP_GridComp/HEMCO_GridComp/HEMCO" \
           log --oneline --no-decorate -1)
scheduler="none"
[[ "x${SLURM_JOBID}" != "x" ]] && scheduler="SLURM"
[[ "x${LSB_JOBID}"   != "x" ]] && scheduler="LSF"
if [[ "x${scheduler}" == "xSLURM" ]]; then
    #---------------------------------
    # Run via SLURM (Harvard Cannon)
    #---------------------------------
    # Cannon-specific setting to get around connection issues at high # cores
    export OMPI_MCL_btl=openib
elif [[ "x${scheduler}" == "xLSF" ]]; then
    #---------------------------------
    # Run via LSF (WashU Compute1)
    #---------------------------------
    # Unlimit resources to prevent OS killing GCHP due to resource usage/
    # Alternatively you can put this in your environment file.
    ulimit -c 0                  # coredumpsize
    ulimit -l unlimited          # memorylocked
    ulimit -u 50000              # maxproc
    ulimit -v unlimited          # vmemoryuse
    ulimit -s unlimited          # stacksize
else
    #---------------------------------
    # Run interactively
    #---------------------------------
    # For AWS, set $OMP_NUM_THREADS to the available cores
    kernel=$(uname -r)
    [[ "x${kernel}" == "xaws" ]] && export OMP_NUM_THREADS=$(nproc)
fi
[[ "x${OMP_NUM_THREADS}" == "x" ]] && export OMP_NUM_THREADS=6
[[ "x${OMP_STACKSIZE}" == "x" ]] && export OMP_STACKSIZE=500m
numTests=$(count_rundirs "${rundirsDir}")
results="${logsDir}/results.execute.log"
rm -f "${results}"
print_to_log "${SEP_MAJOR}"                               "${results}"
print_to_log "GCHP: Execution Test Results"               "${results}"
print_to_log ""                                           "${results}"
print_to_log "GCClassic #${head_gchp}"                    "${results}"
print_to_log "GEOS-Chem #${head_gc}"                      "${results}"
print_to_log "HEMCO     #${head_hco}"                     "${results}"
print_to_log ""                                           "${results}"
print_to_log "Number of execution tests: ${numTests}"     "${results}"
print_to_log ""                                           "${results}"
if [[ "x${scheduler}" == "xSLURM" ]]; then
    print_to_log "Submitted as SLURM job: ${SLURM_JOBID}" "${results}"
elif  [[ "x${scheduler}" == "xLSF" ]]; then
    print_to_log "Submitted as LSF job: ${LSB_JOBID}"     "${results}"
else
    print_to_log "Submitted as interactive job"           "${results}"
fi
print_to_log "${SEP_MAJOR}"                               "${results}"
print_to_log " "                 "${results}"
print_to_log "Execution tests:"  "${results}"
print_to_log "${SEP_MINOR}"      "${results}"
let passed=0
let failed=0
let remain=${numTests}
cd "${rundirsDir}"
for runDir in *; do
    # Expand rundir to absolute path
    runAbsPath="${rundirsDir}/${runDir}"
    # Do the following if for only valid GCHP run dirs
    expr=$(is_gchp_rundir "${runAbsPath}")
    if [[ "x${expr}" == "xTRUE" ]]; then
        # Define log file
        log="${logsDir}/execute.${runDir}.log"
        rm -f "${log}"
        # Messages for execution pass & fail
        passMsg="$runDir${FILL:${#runDir}}.....${EXE_PASS_STR}"
        failMsg="$runDir${FILL:${#runDir}}.....${EXE_FAIL_STR}"
        # Get the executable file corresponding to this run directory
        exeFile=$(exe_name "gchp" "${runAbsPath}")
        # Test if the executable exists
        if [[ -f "${binDir}/${exeFile}" ]]; then
	    #----------------------------------------------------------------
	    # If the executable file exists, we can do the test
            #----------------------------------------------------------------
	    # Change to the run directory
	    cd "${runAbsPath}"
	    # Copy the executable file here
	    cp "${binDir}/${exeFile}" .
	    # Remove any leftover files in the run dir
	    ./cleanRunDir.sh --no-interactive >> "${log}" 2>&1
	    # Link to the environment file
	    ./setEnvironmentLink.sh "${envDir}/gchp.env"
	    # Update config files, set links, load environment, sanity checks
	    . setCommonRunSettings.sh >> "${log}" 2>&1
	    . setRestartLink.sh       >> "${log}" 2>&1
	    . gchp.env                >> "${log}" 2>&1
	    . checkRunSettings.sh     >> "${log}" 2>&1
	    # Run GCHP and evenly distribute tasks across nodes
	    if [[ "x${scheduler}" == "xSLURM" ]]; then
		#---------------------------------------------
		# Executing GCHP on SLURM (Harvard Cannon)
		#---------------------------------------------
		# Compute parameters for srun
		# See the gchp.run script in the folder:
		#  runScriptSamples/operational_examples/harvard_cannon
		NX=$(grep NX GCHP.rc | awk '{print $2}')
		NY=$(grep NY GCHP.rc | awk '{print $2}')
		coreCt=$(( ${NX} * ${NY} ))
		planeCt=$(( ${coreCt} / ${SLURM_NNODES} ))
		if [[ $(( ${coreCt} % ${SLURM_NNODES} )) > 0 ]]; then
		    ${planeCt}=$(( ${planeCt} + 1 ))
		fi
		# Execute GCHP with srun
		srun -n ${coreCt} -N ${SLURM_NNODES} -m plane=${planeCt} \
		    --mpi=pmix ./${exeFile} >> "${log}" 2>&1
	    elif [[ "x${scheduler}" == "xLSF" ]]; then
		#---------------------------------------------
		# Executing GCHP on LSF (WashU Compute1)
		#---------------------------------------------
		mpiexec -n 24 ./${exeFile} > "${log}" 2>&1
	    else
		#---------------------------------------------
		# Executing GCHP interactively
		#---------------------------------------------
		mpirun -n 24 ./${exeFile} >> "${log}" 2>&1
	    fi
	    # Update pass/failed counts and write to results.log
	    if [[ $? -eq 0 ]]; then
                let passed++
                print_to_log "${passMsg}" "${results}"
            else
                let failed++
                print_to_log "${failMsg}" "${results}"
            fi
            # Change to root directory for next iteration
            cd "${rundirsDir}"
        else
            #----------------------------------------------------------------
            # If the executable is missing, update the "fail" counter
            # and write the "failed" message to the results log file.
            #----------------------------------------------------------------
            let failed++
            print_to_log "${failMsg}" "${results}"
        fi
        # Decrement the count of remaining tests
	let remain--
    fi
done
print_to_log " "                                            ${results}
print_to_log "Summary of test results:"                     ${results}
print_to_log "${SEP_MINOR}"                                 ${results}
print_to_log "Execution tests passed: ${passed}"            ${results}
print_to_log "Execution tests failed: ${failed}"            ${results}
print_to_log "Execution tests not yet completed: ${remain}" ${results}
if [[ "x${passed}" == "x${numTests}" ]]; then
    print_to_log ""                                         ${results}
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"    ${results}
    print_to_log "%%%  All execution tests passed!  %%%"    ${results}
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"    ${results}
    # Print success (if interactive)
    if [[ "x${SLURM_JOBID}" == "x" && "x${LSB_JOBID}" == "x" ]]; then
        echo ""
        echo "Execution tests finished!"
    fi
else
    #--------------------------
    # Unsuccessful execution
    #--------------------------
    if [[ "x${SLURM_JOBID}" == "x" && "x${LSB_JOBID}" == "x" ]]; then
        echo ""
        echo "Execution tests failed!  Exiting ..."
    fi
fi
unset absRunPath
unset binDir
unset codeDir
unset envDir
unset coreCt
unset exeFile
unset failed
unset failmsg
unset head_gchp
unset head_gc
unset head_hco
unset itRoot
unset log
unset logsDir
unset numTests
unset NX
unset NY
unset passed
unset passMsg
unset planeCt
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
