#!/bin/bash
#FLUX: --job-name=job_name
#FLUX: -t=345600
#FLUX: --urgency=16

source activate gmx_MMPBSA
module add gromacs/v2021.4-intel-2022.2.0
script_dir="$SCRIPT_PATH"
out_dir="$OUTPUT_PATH/index.pdbid/index.pdbid_SLURM_ARRAY_TASK_ID"
store_dir="$STORE_PATH/index.pdbid/index.pdbid_SLURM_ARRAY_TASK_ID"
echo "Started on: `date`"
python3 $script_dir/run_simulations.py index pdbid $SLURM_ARRAY_TASK_ID -l
echo "Finished on: `date`"
pushd ${OUTPUT_PATH}
if [ -f index.pdbid/index.pdbid_${SLURM_ARRAY_TASK_ID}/FINAL_RESULTS_MMPBSA.dat ]; then
	echo "Found index.dpbid/index.pdbid_SLURM_ARRAY_TASK_ID/FINAL_RESULTS_MMPBSA.dat. Uploading output and logs tar.gz to S3 ..."
	tar -czvf index.pdbid.tar.gz index.pdbid
	aws s3 cp index.pdbid.tar.gz ${S3_OUTPUT_PATH}/index.pdbid.tar.gz
	rm index.pdbid.tar.gz
	popd
	pushd ${LOG_PATH}
	tar -czvf index.pdbid-log.tar.gz index.pdbid
	aws s3 cp index.pdbid-log.tar.gz ${S3_LOG_PATH}/index.pdbid-log.tar.gz
	rm index.pdbid-log.tar.gz
else
	echo "Did not find index.pdbid/index.pdbid_SLURM_ARRAY_TASK_ID/FINAL_RESULTS_MMPBSA.dat. Skipping upload to S3 ..."
fi
popd
