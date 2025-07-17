#!/bin/bash
#FLUX: --job-name=game_of_life
#FLUX: -n=128
#FLUX: --queue=thin_course
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load 2023
module load MPICH/4.1.2-GCC-12.3.0
total_values=(1 2 4 8 16 32 64 128)
for total in "${total_values[@]}"; do
    echo "Testing for $total processes/threads"
    # Loop over possible combinations
    for p in $(seq 1 $((total))); do
        t=$((total / p))
        # Ensure the product of processes and threads equals the total
        if [ $((p * t)) -eq $total ]; then
            echo "Running with $p processes / $t threads per process"
            export OMP_NUM_THREADS=$t
            time mpirun -np $p --bind-to none ./game_of_life -omp $t
            echo "-----------DONE--------------"
        fi
    done
done
