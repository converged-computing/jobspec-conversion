# Flux batch script generated from original Slurm script

# Define job name
export FLUX_JOB_NAME="${4}"

# Define resource requests
export FLUX_NODES="${5}"
export FLUX_CORES_PER_NODE="${6}"
export FLUX_WALLTIME="4:00:00"

# Calculate total cores
total_cores=$(( ${FLUX_NODES} * ${FLUX_CORES_PER_NODE} ))

# Load modules
module load gcc
module load python

# Determine program type and command to execute
if [[ "${1}" == "cNoThread" || "${1}" == "cNoThread.c" ]]; then
    program_type="${4}_cNoThread.c"
    command="./compiled-programs/${program_type} ${2} ${3} ${total_cores} ${4} ${5} ${6}"
elif [[ "${1}" == "cPThread" || "${1}" == "cPThread.c" ]]; then
    program_type="${4}_cPThread.c"
    command="./compiled-programs/${program_type} ${2} ${3} ${total_cores} ${4} ${5} ${6}"
elif [[ "${1}" == "cOpenMP" || "${1}" == "cOpenMP.c" ]]; then
    program_type="${4}_cOpenMP.c"
    command="./compiled-programs/${program_type} ${2} ${3} ${total_cores} ${4} ${5} ${6}"
elif [[ "${1}" == "pythonNoThreads" || "${1}" == "pythonNoThreads.py" ]]; then
    program_type="pythonNoThreads.py"
    command="python \"${program_type}\" ${2} ${3} ${total_cores} ${4} ${5} ${6}"
elif [[ "${1}" == "pythonWithThreads" || "${1}" == "pythonWithThreads.py" ]]; then
    program_type="pythonWithThreads.py"
    command="python \"${program_type}\" ${2} ${3} ${total_cores} ${4} ${5} ${6}"
else
    echo "Error: Unsupported file type: ${1}. Exiting."
    exit 1
fi

# Execute the command
echo "Running command: ${command}"
${command}