#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=edu5
#FLUX: -t=300
#FLUX: --urgency=16

if [ "$#" -eq 2 ]; then
    srun ./bin/gpu_transpose "$1" "$2"
    exit 1
elif [ "$#" -eq 3 ]; then 
    if [[ "$3" == "--valgrind" ]]; then
        srun valgrind --tool=cachegrind ./bin/gpu_transpose "$1" "$2" "$3"
        exit 1
    else 
        srun ./bin/gpu_transpose "$1" "$2" "$3"
        exit 1
    fi
elif [ "$#" -eq 4 ]; then 
    srun valgrind --tool=cachegrind ./bin/gpu_transpose "$1" "$2" "$3" "$4"
    exit 1
else 
    echo "Usage: $0 arg1 arg2 arg3 [--valgrind] or $0 arg1 arg2 [--valgrind] "
    exit 1
fi
