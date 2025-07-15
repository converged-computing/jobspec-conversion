#!/bin/bash
#FLUX: --job-name=align_magnoliids_reduced
#FLUX: --queue=global
#FLUX: --priority=16

echo "JOB CONFIGURATION"
echo "Job ID: " $SLURM_JOB_ID
echo "Name of the job: " $SLURM_JOB_NAME		
echo "List of nodes allocated to the job: " $SLURM_JOB_NODELIST
echo "Number of nodes allocated to the job: " $SLURM_JOB_NUM_NODES
echo "Number of CPU tasks in this job: " $SLURM_NTASKS
echo "Directory from which sbatch was invoked: " $SLURM_SUBMIT_DIR
path_to_dir_in="/data3/projects/AFRODYN2/magnoliids/hybpiper_magnoliids/retrieved_supercontigs/oneline/header_remove10";
path_to_dir_out="/data3/projects/AFRODYN2/magnoliids/align_magnoliids_reduced_$SLURM_JOB_ID/";
path_to_tmp="/scratch/helmstetter_$SLURM_JOB_ID/";
echo "Transfering files to node";
mkdir $path_to_tmp
scp -r /$path_to_dir_in/* $path_to_tmp
echo "done copying files";
module load bioinfo/mafft/7.305
module load bioinfo/Gblocks
echo "starting alignment";
cd $path_to_tmp
ls -1 ./ | \
while read sample; do
  	echo "mafft --auto ${sample} > aligned.${sample}"
done | parallel -j20
echo "done alignment";
echo "starting trimming";
ls -1 ./ | \
while read sample; do
	#the -b2 parameter can be removed (default) or set to 0 depending on severity of cleaning desired
  	echo "Gblocks aligned.${sample} -t=d -b5=a"
done | parallel -j20
cd ~
echo "done trimming";
echo "Transfering data from node to master";
mkdir $path_to_dir_out
scp -rp $path_to_tmp/ nas3:/$path_to_dir_out/
echo "done transfer";
echo "Deleting data on node";
rm -rf $path_to_tmp
echo "Done deleting, FINISHED!";
