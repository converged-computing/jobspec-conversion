#!/bin/bash
#FLUX: --job-name=contig_extraction
#FLUX: --queue=common
#FLUX: --urgency=16

sample_list="/full_path_to/wd/redundancy_removal/metadata/sample_list1.tsv"
_extract_rename_joberrors="/full_path_to/wd/redundancy_removal/extract_rename_joberrors"
_extract_rename_jobouputs="/full_path_to/wd/redundancy_removal/extract_rename_joboutputs"
if [ ! -d "$_extract_rename_joberrors" ]; then
mkdir $_extract_rename_joberrors
fi
if [ ! -d "$_extract_rename_jobouputs" ]; then
mkdir $_extract_rename_jobouputs
fi
_nb_jobs=`wc -l < $sample_list`
echo "$sample_list"
cat $sample_list
echo "$_nb_jobs"
sbatch --wait --array=1-$_nb_jobs -o $_extract_rename_jobouputs/slurm-%A_%a.out -e \
$_extract_rename_joberrors/slurm-%A_%a.err \
/full_path_to/wd/redundancy_removal/scripts/run_extract_rename.sh \
$sample_list || exit 1
exit 0
