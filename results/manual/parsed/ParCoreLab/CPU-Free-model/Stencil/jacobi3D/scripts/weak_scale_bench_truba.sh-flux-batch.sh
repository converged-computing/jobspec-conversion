#!/bin/bash
#FLUX: --job-name=stencil-bench-weak
#FLUX: -n=8
#FLUX: -c=16
#FLUX: --queue=palamut-cuda
#FLUX: -t=86400
#FLUX: --urgency=16

. ./scripts/modules_truba.sh > /dev/null
MAX_NUM_GPUS=8
CUDA_VISIBLE_DEVICES_SETTING=("0" "0" "0,1" "0,1,2" "0,1,2,3" "0,1,2,3,4" "0,1,2,3,4,5" "0,1,2,3,4,5,6" "0,1,2,3,4,5,6,7" )
declare -A version_name_to_idx_map
version_name_to_idx_map["Baseline Copy Overlap"]=1
version_name_to_idx_map["Baseline P2P"]=2
declare -A version_name_to_idx_map_nvshmem
version_name_to_idx_map_nvshmem["NVSHMEM Baseline"]=0
version_name_to_idx_map_nvshmem["NVSHMEM Baseline Optimized"]=1
version_name_to_idx_map_nvshmem["NVSHMEM Single Stream 1TB"]=2
version_name_to_idx_map_nvshmem["NVSHMEM Single Stream 2TB"]=3
version_name_to_idx_map_nvshmem["NVSHMEM Double Stream"]=4
version_name_to_idx_map_nvshmem["NVSHMEM Single Stream Partitoned"]=5
version_name_to_idx_map_nvshmem["NVSHMEM Double Stream Partitoned"]=6
version_name_to_idx_map_nvshmem["NVSHMEM PERKS"]=13
BIN="./jacobi -s 1"
MAX_NX=${MAX_NX:-512}
MAX_NY=${MAX_NY:-512}
MAX_NZ=${MAX_NZ:-512}
STARTING_NX=${STARTING_NX:-256}
STARTING_NY=${STARTING_NY:-256}
STARTING_NZ=${STARTING_NZ:-256}
NUM_ITER=${NUM_ITER:-100000}
NUM_RUNS=${NUM_RUNS:-5}
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done
for (( NX = ${STARTING_NX}; NX <= ${MAX_NX}; NX*=2 )); do
    for version_name in "${!version_name_to_idx_map[@]}"; do
        echo "Running ${version_name}"; echo ""
        NY=${NX}
        NZ=${NX}
        version_idx=${version_name_to_idx_map[$version_name]}
        for (( NUM_GPUS=1; NUM_GPUS <= ${MAX_NUM_GPUS}; NUM_GPUS*=2 )); do
            export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES_SETTING[${NUM_GPUS}]}
            echo "Num GPUS: ${NUM_GPUS}"
            echo "${NUM_ITER} iterations on grid ${NX}x${NY}x${NZ}"
            for (( i=1; i <= ${NUM_RUNS}; i++ )); do
                execution_time=$(${BIN} -v ${version_idx} -nx ${NX} -ny ${NY} -nz  ${NZ} -niter ${NUM_ITER})
                echo "${execution_time} on run ${i}"
            done
            printf "\n"
            NY=$((2*NY))
        done
        echo "-------------------------------------"
    done
    for version_name in "${!version_name_to_idx_map_nvshmem[@]}"; do
        echo "Running ${version_name}"; echo ""
        NY=${NX}
        NZ=${NX}
        version_idx=${version_name_to_idx_map_nvshmem[$version_name]}
        for (( NP=1; NP <= ${MAX_NUM_GPUS}; NP*=2 )); do
            echo "Num GPUS: ${NP}"
            echo "${NUM_ITER} iterations on grid ${NX}x${NY}x${NZ}"
            for (( i=1; i <= ${NUM_RUNS}; i++ )); do
                execution_time=$(mpirun -np ${NP} ./jacobi -s 1 -v ${version_idx} -nx ${NX} -ny ${NY} -nz  ${NZ} -niter ${NUM_ITER})
                echo "${execution_time} on run ${i}"
            done
            printf "\n"
            NY=$((2*NY))
        done
        echo "-------------------------------------"
    done
    echo "-------------------------------------"
    echo "-------------------------------------"
done
