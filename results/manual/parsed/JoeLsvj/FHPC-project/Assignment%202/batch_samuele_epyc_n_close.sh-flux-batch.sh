#!/bin/bash
#FLUX: --job-name=sam_job
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='close'
export LD_LIBRARY_PATH='/u/dssc/slippo00/PROJECT_sl_and_gv/Foundations_of_HPC_2022/Assignment/exercise2/blis/lib:$LD_LIBRARY_PATH'

module load mkl/latest
module load openBLAS/0.3.23-omp
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export LD_LIBRARY_PATH=/u/dssc/slippo00/PROJECT_sl_and_gv/Foundations_of_HPC_2022/Assignment/exercise2/blis/lib:$LD_LIBRARY_PATH
current_type=EPYC
current_policy=close
size=10000
for FILE in sgemm_blis_opt.x dgemm_blis_opt.x; do
        # Define your matrix multiplication code's executable path
        matrix_multiply_executable="./${FILE}"
        # Create a directory for storing the CSV results
        results_dir="csv_results_scalability_${current_type}"
        mkdir -p "$results_dir"
        # Define the CSV file path to store the summary results
        summary_csv="${results_dir}/${matrix_multiply_executable}_${current_type}_${size}_${current_policy}_summary.csv"
        # Define the CSV file path to store the detailed results
        detailed_csv="${results_dir}/${matrix_multiply_executable}_${current_type}_${size}_${current_policy}_detailed.csv"
        # Define the number of iterations for each size
        num_iterations=5
        # Initialize the summary CSV file with header
        echo "Number of cores,Size,Elapsed Time (s),GFLOPS" > "$summary_csv"
        # Initialize the detailed CSV file with header
        echo "Number of cores,Size,Iteration,Elapsed Time (s),GFLOPS" > "$detailed_csv"
        for num in 1 2 4 16 32 48 64 80 96 112 128; do
            export OMP_NUM_THREADS=$num
            export BLIS_NUM_THREADS=$num
            total_time=0
            total_gflops=0
            for ((iteration = 1; iteration <= num_iterations; iteration++)); do
                # Run your matrix multiplication code for the current size
                output=$($matrix_multiply_executable $size $size $size)
                # Extract time and GFLOPS from the output using grep and awk
                # Extract time and GFLOPS from the output using grep and awk
                time=$(echo "$output" | grep -oP 'Elapsed time \K[0-9.]+')
                gflops=$(echo "$output" | grep -oP '[0-9.]+ GFLOPS' | awk '{print $1}')
                total_time=$(echo "$total_time + $time" | bc -l)
                total_gflops=$(echo "$total_gflops + $gflops" | bc -l)
                # Append the detailed results to the detailed CSV file
                echo "$num,$size,$iteration,$time,$gflops" >> "$detailed_csv"
            done
            # Calculate the average time and GFLOPS
            avg_time=$(echo "scale=5; $total_time / $num_iterations" | bc)
            avg_gflops=$(echo "scale=5; $total_gflops / $num_iterations" | bc)
            # Append the summary results to the summary CSV file
            echo "$num,$size,$avg_time,$avg_gflops" >> "$summary_csv"
        done
done
