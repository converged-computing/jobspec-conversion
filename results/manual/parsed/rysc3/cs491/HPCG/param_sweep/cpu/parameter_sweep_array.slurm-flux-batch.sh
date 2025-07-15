#!/bin/bash
#FLUX: --job-name=HPCG_cpu
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=general
#FLUX: --priority=16

export OMP_PROC_BIND='TRUE'
export OMP_PLACES='cores'
export OMP_NUM_THREADS='32'

module load intel/20.0.4 hpcg 
export OMP_PROC_BIND=TRUE
export OMP_PLACES=cores
export OMP_NUM_THREADS=32
RESULTS_FILE=$SLURM_SUBMIT_DIR/HPCG_results.csv
PARAMS_FILE=$SLURM_SUBMIT_DIR/HPCG_params.csv
TEMPLATE_FILE=$SLURM_SUBMIT_DIR/HPCG_template.dat
if test -f $PARAMS_FILE; then
    echo Using parameter file $PARAMS_FILE
else
    echo Error $PARAMS_FILE not found
    exit 1
fi
if test -f $TEMPLATE_FILE; then
    echo Using template file $TEMPLATE_FILE
else
    echo Error $TEMPLATE_FILE not found
    exit 2
fi
PARAMS=$(head -n $SLURM_ARRAY_TASK_ID $PARAMS_FILE | tail -n 1)
echo Read param line $SLURM_ARRAY_TASK_ID: $PARAMS
NX_VAL=$(echo $PARAMS | awk -F"," '{print $1}') # awk: Aho, Weinberger, and Kernighan
echo Read param NX: $NX_VAL
NY_VAL=$(echo $PARAMS | awk -F"," '{print $2}') # awk: Aho, Weinberger, and Kernighan
echo Read param NY: $NY_VAL
NZ_VAL=$(echo $PARAMS | awk -F"," '{print $3}') # awk: Aho, Weinberger, and Kernighan
echo Read param NZ: $NZ_VAL
TIME_VAL=$(echo $PARAMS | awk -F"," '{print $4}') # awk: Aho, Weinberger, and Kernighan
echo Read param TIME: $TIME_VAL
SCRATCH_DIR=/carc/scratch/users/$USER
TMP_DIR=$(mktemp --directory -p $SCRATCH_DIR)
echo Temp directory: $TMP_DIR
TMP_WORKING_DIR=$TMP_DIR/$SLURM_ARRAY_TASK_ID
mkdir -p $TMP_WORKING_DIR
echo Created temporary working directory: $TMP_WORKING_DIR
cd $TMP_WORKING_DIR
echo Now running in $PWD
echo Running xhpcg in $TMP_WORKING_DIR...
srun --mpi=pmi2 xhpcg $NX_VAL $NY_VAL $NZ_VAL $TIME_VAL
echo xhpcg finished
running_file=$(find "$temp_dir" -name "hpcg*.out" -type f)
echo -e "\n\n\n"
echo "-- Benchmark Running --"
echo -e "\n\n\n"
cat $running_file
echo -e "\n\n\n"
echo "-- Benchmark Complete --"
echo -e "\n\n\n"
output_file=$(find . -name "HPCG-Benchmark_*.txt" -type f)
echo -e "\n\n\n"
echo "-- HPCG Results --"
echo -e "\n\n\n"
cat $output_file
echo -e "\n\n\n"
echo "-- HPCG Results End --"
echo -e "\n\n\n"
FINAL_SUMMARY_LINE=$(grep "Final Summary::HPCG result is" $output_file)
echo "Final Summary:"
echo "$FINAL_SUMMARY_LINE"
GFLOPS=$(echo "$FINAL_SUMMARY_LINE" | awk -F"=" '{print $NF}')
echo "Results Gflops: $GFLOPS"
echo Writing input parameters and gflops to $RESULTS_FILE
echo $NX_VAL, $NY_VAL, $NZ_VAL, $TIME_VAL, $GFLOPS >> $RESULTS_FILE
