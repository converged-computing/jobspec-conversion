#!/bin/bash
#FLUX: --job-name=faux-cinnamonbun-3178
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate obss
start=`date +%s`
transformation=$1
lambdastring="$2"
engine=ENGINE
repeats=N_REPEATS 
outputs_dir=OUTPUTS_DIR
echo "$lambdastring"
INPUT_FILE_STREAM=" " read -ra lambdas <<< "$lambdastring"
id=$SLURM_ARRAY_TASK_ID
lambda=${lambdas[$id]}
for stage in "unbound" "bound"
do
	for (( i=1; i<=$repeats; i++)) 
	do
		lambda_directory=$outputs_dir/${engine}_${i}/$transformation/$stage/lambda_$lambda
		echo "Lambda directory is: $lambda_directory"
		echo "Using ${engine}_${i} for $transformation at $stage lambda $lambda"
		if [[ $engine == *"SOMD"* ]]; then	
			echo "Running AFE transformation..."
			cd $lambda_directory
			$BSS_HOME/somd-freenrg -C ./somd.cfg -l $lambda -c ./somd.rst7 -t ./somd.prm7 -m ./somd.pert -p CUDA 1> ./somd.out 2> ./somd.err
		else
			echo "Engine $engine is not supported yet."
		fi
	done
done
end=`date +%s`
runtime=$((end - start))
echo "Finished in $runtime seconds, or $((runtime/60)) minutes"
