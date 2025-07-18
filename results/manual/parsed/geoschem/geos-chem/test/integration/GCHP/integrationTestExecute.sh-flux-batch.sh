#!/bin/bash
#FLUX: --job-name=wobbly-eagle-9878
#FLUX: -n=24
#FLUX: --queue=REQUESTED_PARTITION
#FLUX: -t=300
#FLUX: --urgency=16

itRoot=$(cd ..; pwd)
. "${itRoot}/scripts/commonFunctionsForTests.sh"
binDir="${itRoot}/${BIN_DIR}"
envDir="${itRoot}/${ENV_DIR}"
codeDir="${itRoot}/CodeDir"
logsDir="${itRoot}/${LOGS_DIR}"
rundirsDir="${itRoot}/${RUNDIRS_DIR}"
site=$(get_site_name)
. ~/.bashrc > /dev/null 2>&1
[[ "X${site}" == "XCANNON" ]] && . ${envDir}/gchp.env > /dev/null 2>&1
head_gchp=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}" log --oneline --no-decorate -1)
head_gc=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
          git -C "${codeDir}/src/GCHP_GridComp/GEOSChem_GridComp/geos-chem" \
          log --oneline --no-decorate -1)
head_hco=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}/src/GCHP_GridComp/HEMCO_GridComp/HEMCO" \
           log --oneline --no-decorate -1)
if [[ "X${site}" == "XCANNON" && "X${SLURM_JOBID}" != "X" ]]; then
    #----------------------------------
    # SLURM settings (Harvard Cannon)
    #----------------------------------
    # Set OMP_NUM_THREADS to the same # of cores requested with #SBATCH -c
    export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
elif [[ "X${site}" == "XCOMPUTE1" && "X${LSB_JOBID}" != "X" ]]; then
    #---------------------------------
    # LSF settings (WashU Compute1)
    #---------------------------------
    # Set OMP_NUM_THREADS to the same # of cores requested with #BSUB -n
    export OMP_NUM_THREADS=${LSB_DJOB_NUMPROC}
    # Unlimit resources to prevent OS killing GCHP due to resource usage/
    # Alternatively you can put this in your environment file.
    ulimit -c 0                  # coredumpsize
    ulimit -l unlimited          # memorylocked
    ulimit -u 50000              # maxproc
    ulimit -v unlimited          # vmemoryuse
    ulimit -s unlimited          # stacksize
else
    #---------------------------------
    # Interactive settings
    #---------------------------------
    echo ""
    echo "Execution tests running..."
    # For AWS, set $OMP_NUM_THREADS to the available cores
    kernel=$(uname -r)
    [[ "X${kernel}" == "Xaws" ]] && export OMP_NUM_THREADS=$(nproc)
fi
[[ "x${OMP_NUM_THREADS}" == "x" ]] && export OMP_NUM_THREADS=6
[[ "x${OMP_STACKSIZE}" == "x" ]] && export OMP_STACKSIZE=500m
numTests=$(count_rundirs "${rundirsDir}")
results="${logsDir}/results.execute.log"
rm -f "${results}"
print_to_log "${SEP_MAJOR}"                               "${results}"
print_to_log "GCHP: Execution Test Results"               "${results}"
print_to_log ""                                           "${results}"
print_to_log "GCHP      #${head_gchp}"                    "${results}"
print_to_log "GEOS-Chem #${head_gc}"                      "${results}"
print_to_log "HEMCO     #${head_hco}"                     "${results}"
print_to_log ""                                           "${results}"
print_to_log "Number of execution tests: ${numTests}"     "${results}"
print_to_log ""                                           "${results}"
if [[ "X${SLURM_JOBID}" != "X" ]]; then
    print_to_log "Submitted as SLURM job: ${SLURM_JOBID}" "${results}"
elif  [[ "X${LSB_JOBID}" == "XCOMPUTE1" ]]; then
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
        exeFile=$(exe_name "gchp" "${runDir}")
        # Test if the executable exists
        if [[ -f "${binDir}/${exeFile}" ]]; then
            #----------------------------------------------------------------
            # If the executable file exists, we can do the test
            #----------------------------------------------------------------
            # Change to the run directory
            cd "${runAbsPath}"
            # Copy the executable file here
            cp "${binDir}/${exeFile}" .
            # Update to make sure the run directory is executable
            # on Compute1.  We will later replace this test with
            # a test on the site name instead of on the scheduler.
            # TODO: Test on name rather than scheduler
            if [[ "X${site}" == "XCOMPUTE1" ]]; then
		chmod 755 -R "${runAbsPath}"
            fi
            # Remove any leftover files in the run dir
            ./cleanRunDir.sh --no-interactive >> "${log}" 2>&1
            # Link to the environment file
            ./setEnvironmentLink.sh "${envDir}/gchp.env"
            # Update config files, set links, load environment, sanity checks
            . setCommonRunSettings.sh >> "${log}" 2>&1
            . setRestartLink.sh       >> "${log}" 2>&1
            . gchp.env                >> "${log}" 2>&1
            . checkRunSettings.sh     >> "${log}" 2>&1
            # For safety's sake, remove restarts that weren't renamed
            for rst in Restarts; do
		if [[ "${rst}" =~ "gcchem_internal_checkpoint" ]]; then
		    rm -f "${rst}"
		fi
            done
            # Run GCHP and evenly distribute tasks across nodes
            if [[ "X${site}" == "XCANNON" && "X${SLURM_JOBID}" != "X" ]]; then
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
		    planeCt=$(( ${planeCt} + 1 ))
		fi
		# Execute GCHP with srun
		srun -n ${coreCt} -N ${SLURM_NNODES} -m plane=${planeCt} \
		     --mpi=pmix ./${exeFile} >> "${log}" 2>&1
            elif [[ "X${scheduler}" == "xLSF" && "X${LSB_JOBID}" != "X" ]]; then
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
		# The run passed ...
                let passed++
                print_to_log "${passMsg}" "${results}"
		# ... so also rename the end-of-run restart file
		new_start_str=$(sed 's/ /_/g' cap_restart)
		N=$(grep "CS_RES=" setCommonRunSettings.sh | cut -c 8- | xargs )
		mv Restarts/gcchem_internal_checkpoint \
		   Restarts/GEOSChem.Restart.${new_start_str:0:13}z.c${N}.nc4
            else
		# The run failed
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
if [[ "X${passed}" == "X${numTests}" ]]; then
    print_to_log ""                                         ${results}
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"    ${results}
    print_to_log "%%%  All execution tests passed!  %%%"    ${results}
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"    ${results}
    # Print success (if interactive)
    if [[ "X${SLURM_JOBID}" == "X" && "X${LSB_JOBID}" == "X" ]]; then
        echo ""
        echo "Execution tests finished!"
    fi
else
    #--------------------------
    # Unsuccessful execution
    #--------------------------
    if [[ "X${SLURM_JOBID}" == "X" && "X${LSB_JOBID}" == "X" ]]; then
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
