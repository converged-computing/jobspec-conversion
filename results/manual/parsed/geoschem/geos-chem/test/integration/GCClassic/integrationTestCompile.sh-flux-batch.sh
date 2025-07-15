#!/bin/bash
#FLUX: --job-name=lovable-chip-2691
#FLUX: --urgency=16

quick="${1}"
itRoot=$(cd ..; pwd)
. "${itRoot}/scripts/commonFunctionsForTests.sh"
binDir="${itRoot}/${BIN_DIR}"
buildDir="${itRoot}/${BUILD_DIR}"
envDir="${itRoot}/${ENV_DIR}"
codeDir="${itRoot}/CodeDir"
logsDir="${itRoot}/${LOGS_DIR}"
scriptsDir="${itRoot}/${SCRIPTS_DIR}"
site=$(get_site_name)
. ~/.bashrc > /dev/null 2>&1
[[ "X${site}" == "XCANNON" ]] && . ${envDir}/gcclassic.env > /dev/null 2>&1
baseOptions="-DCMAKE_BUILD_TYPE=Debug -DRUNDIR='' -DINSTALLCOPY=${binDir}"
head_gcc=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}" log --oneline --no-decorate -1)
head_gc=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
          git -C "${codeDir}/src/GEOS-Chem" log --oneline --no-decorate -1)
head_hco=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}/src/HEMCO" log --oneline --no-decorate -1)
if [[ "X${site}" == "XCANNON" && "X${SLURM_JOBID}" != "X" ]]; then
    #----------------------------------
    # SLURM settings (Harvard Cannon)
    #----------------------------------
    # Set OMP_NUM_THREADS to the same # of cores requested with #SBATCH -c
    export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
elif [[ "X${site}" == "XCOMPUTE1" && "X${LSB_JOBID}" != "X" ]]; then
    #----------------------------------
    # LSF settings (WashU Compute1)
    #----------------------------------
    # Set OMP_NUM_THREADS to the same # of cores requested with #BSUB -n
    export OMP_NUM_THREADS=${LSB_DJOB_NUMPROC}
else
    #----------------------------------
    # Interactive settings
    #----------------------------------
    # For AWS, set $OMP_NUM_THREADS to the available cores
    kernel=$(uname -r)
    [[ "X${kernel}" == "Xaws" ]] && export OMP_NUM_THREADS=$(nproc)
fi
[[ "X${OMP_NUM_THREADS}" == "X" ]] && export OMP_NUM_THREADS=6
[[ "X${OMP_STACKSIZE}" == "X" ]] && export OMP_STACKSIZE=500m
if [[ "X${quick}" == "XYES" ]]; then
    EXE_LIST=("default" "carbon")
else
    EXE_LIST=("${EXE_GCC_BUILD_LIST[@]}")
fi
numTests=${#EXE_LIST[@]}
results="${logsDir}/results.compile.log"
rm -f ${results}
print_to_log "${SEP_MAJOR}"                                "${results}"
print_to_log "GEOS-Chem Classic: Compilation Test Results" "${results}"
print_to_log ""                                            "${results}"
print_to_log "GCClassic #${head_gcc}"                      "${results}"
print_to_log "GEOS-Chem #${head_gc}"                       "${results}"
print_to_log "HEMCO     #${head_hco}"                      "${results}"
print_to_log ""                                            "${results}"
print_to_log "Using ${OMP_NUM_THREADS} OpenMP threads"     "${results}"
print_to_log "Number of compilation tests: ${numTests}"    "${results}"
print_to_log ""                                            "${results}"
if [[ "X${SLURM_JOBID}" != "X" ]]; then
    print_to_log "Submitted as SLURM job: ${SLURM_JOBID}"  "${results}"
elif  [[ "X${LSB_JOBID}" != "X" ]]; then
    print_to_log "Submitted as LSF job: ${LSB_JOBID}"      "${results}"
else
    print_to_log "Submitted as interactive job"            "${results}"
fi
print_to_log "${SEP_MAJOR}"                                "${results}"
print_to_log " "                   "${results}"
print_to_log "Compiliation tests:" "${results}"
print_to_log "${SEP_MINOR}"        "${results}"
cd "${itRoot}"
let passed=0
let failed=0
let remain=${numTests}
for dir in ${EXE_LIST[@]}; do
    # Define build directory
    thisBuildDir="${buildDir}/${dir}"
    # Define log file
    log="${logsDir}/compile.${dir}.log"
    rm -f "${log}"
    # Configure and build GEOS-Chem Classic source code
    # and increment pass/fail/remain counters
    build_model "gcclassic"      "${itRoot}" "${thisBuildDir}" \
                "${baseOptions}" "${log}"    "${results}"
    if [[ $? -eq 0 ]]; then
        let passed++
    else
        let failed++
    fi
    let remain--
done
print_to_log " "                                           "${results}"
print_to_log "Summary of compilation test results:"        "${results}"
print_to_log "${SEP_MINOR}"                                "${results}"
print_to_log "Complilation tests passed:        ${passed}" "${results}"
print_to_log "Complilation tests failed:        ${failed}" "${results}"
print_to_log "Complilation tests not completed: ${remain}" "${results}"
if [[ "X${passed}" == "X${numTests}" ]]; then
    #--------------------------
    # Successful compilation
    #--------------------------
    print_to_log ""                                        "${results}"
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" "${results}"
    print_to_log "%%%  All compilation tests passed!  %%%" "${results}"
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" "${results}"
    # Start the interactive execution test script upon successful finish
    if [[ "X${SLURM_JOBID}" == "X" && "x${LSB_JOBID}" == "X" ]]; then
        echo ""
        echo "Compilation tests finished!"
        ${scriptsDir}/integrationTestExecute.sh &
    fi
else
    #---------------------------
    # Unsuccessful compilation
    #---------------------------
    if [[ "X${SLURM_JOBID}" == "X" && "x${LSB_JOBID}" == "X" ]]; then
       echo ""
       echo "Compilation tests failed!  Exiting..."
    fi
fi
unset baseOptions
unset binDir
unset buildDir
unset codeDir
unset failed
unset dir
unset envDir
unset head_gcc
unset head_gc
unset head_hco
unset itRoot
unset kernel
unset log
unset logsDir
unset numTests
unset passed
unset remain
unset results
unset scriptsDir
unset scheduler
unset FILL
unset SEP_MAJOR
unset SEP_MINOR
unset CMP_PASS_STR
unset CMP_FAIL_STR
unset EXE_PASS_STR
unset EXE_FAIL_STR
