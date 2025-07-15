#!/bin/bash
#FLUX: --job-name=HPCG_params
#FLUX: --queue=condo
#FLUX: --urgency=16

export OMP_PROC_BIND='TRUE'
export OMP_PLACES='cores'
export OMP_NUM_THREADS='64'

module load singularity
export OMP_PROC_BIND=TRUE
export OMP_PLACES=cores
export OMP_NUM_THREADS=64
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
cp $TEMPLATE_FILE $TMP_WORKING_DIR/hpcg.dat # @ryan
sed -i "s/<NX_VAL>/$NX_VAL/g" hpcg.dat # sed: string edit
sed -i "s/<NY_VAL>/$NY_VAL/g" hpcg.dat # sed: string edit
sed -i "s/<NZ_VAL>/$NZ_VAL/g" hpcg.dat # sed: string edit
sed -i "s/<TIME_VAL>/$TIME_VAL/g" hpcg.dat # sed: string edit
echo Running xhpl in $TMP_WORKING_DIR...
srun --mpi=pmi2 xhpl
echo xhpl finished
RESULT_HEADER_AND_DATA_LINES=$(grep --after 2 Gflops HPL.out)
echo Results: $RESULT_HEADER_AND_DATA_LINES
RESULT_DATA_LINE=$(echo $RESULT_HEADER_AND_DATA_LINES | tail -n 1)
echo Results data: $RESULT_DATA_LINE
GFLOPS=$(echo $RESULT_DATA_LINE | awk -F" " '{print $NF}')
echo Results Gflops: $GFLOPS 
echo Writing input parameters and gflops to $RESULTS_FILE
echo $NX_VAL, $NY_VAL, $NZ_VAL, $TIME_VAL, $GFLOPS >> $RESULTS_FILE
rm -r $TMP_DIR
echo Deleted $TMP_DIR
