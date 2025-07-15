#!/bin/bash
#FLUX: --job-name=${SCENARIO}_${PARTITION}
#FLUX: --urgency=16

set -e
SOURCES="main.cu programs/jacobi.cu programs/cuda_functions.cu programs/scenarios.cu" 
PARTITION="$1"
shift
for SCENARIO in "$@"; do
    # Extract matrix size and GPU count from the run identifier
    WIDTH=$(echo $SCENARIO | awk -F'width' '{print $2}' | awk -F'_' '{print $1}')
    HEIGHT=$(echo $SCENARIO | awk -F'height' '{print $2}' | awk -F'_' '{print $1}')
    DEPTH=$(echo $SCENARIO | awk -F'depth' '{print $2}' | awk -F'_' '{print $1}')
    NODES=$(echo $SCENARIO | awk -F'nodes' '{print $2}' | awk -F'_' '{print $1}')
    NUM_GPUS=$(echo $SCENARIO | awk -F'gpu' '{print $2}' | awk -F'_' '{print $1}')
    ITERATIONS=$(echo $SCENARIO | awk -F'iter' '{print $2}' | awk -F'_' '{print $1}')
    COMPARE=$(echo $SCENARIO | awk -F'compare' '{print $2}' | awk -F'_' '{print $1}')
    OVERLAP=$(echo $SCENARIO | awk -F'overlap' '{print $2}' | awk -F'_' '{print $1}')
    TEST=$(echo $SCENARIO | awk -F'test' '{print $2}')
    # Define the variable values
    VAR1=$WIDTH # Width
    VAR2=$HEIGHT # Height
    VAR3=$DEPTH
    VAR4=$ITERATIONS  # Iterations
    VAR5=$NUM_GPUS    # GPUs
    VAR6=$NODES
    VAR7=$COMPARE
    VAR8=$OVERLAP
    VAR9=$TEST
    # Create a temporary Slurm script for this scenario
    TEMP_SCRIPT="slurm_script_${SCENARIO}_${PARTITION}.sh"
    cat << EOF > "${TEMP_SCRIPT}"
module purge
module load CUDA/11.7.0
module load OpenMPI/4.1.4-GCC-11.3.0
nvcc $SOURCES -o out_${SCENARIO}_${PARTITION} -I$CPATH -L$LD_LIBRARY_PATH /cluster/software/EL9/easybuild/software/OpenMPI/4.1.4-GCC-11.3.0/lib/libmpi.so -O3
mpirun -np ${NODES}  out_${SCENARIO}_${PARTITION} $VAR1 $VAR2 $VAR3 $VAR4 $VAR5 $VAR6 $VAR7 $VAR8 $VAR9
exit 0
EOF
    # Submit the temporary Slurm script as a job
    sbatch "${TEMP_SCRIPT}"
    # Remove the temporary script after submission
    rm "${TEMP_SCRIPT}"
done
