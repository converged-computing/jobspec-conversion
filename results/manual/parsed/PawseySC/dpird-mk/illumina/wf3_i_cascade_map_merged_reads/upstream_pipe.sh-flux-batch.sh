#!/bin/bash
#FLUX: --job-name=fuzzy-puppy-9784
#FLUX: --urgency=16

account=pawsey0281
sample=$(basename $(pwd))
basegroup=$(dirname $(pwd))
basescratch=${basegroup/group/scratch}
if [ $basescratch == $basegroup ] ; then
 basescratch=${basegroup}_tmp
fi
group="$basegroup/$sample"
scratch="$basescratch/$sample"
script_merge="01.merge.qc.sh"
script_trim="02.trim.qc.sh"
script_assemble="03.assemble.sh"
script_map_contigs="04.map_contigs.sh"
script_blast="05.blast.sh"
read_file_1="R1.fastq.gz"
read_file_2="R2.fastq.gz"
if [ $# -eq 0 ] ; then
 echo "You need to provide as an argument the minimum length of contigs to be kepth after assembly. Exiting."
 exit
fi
if [ ! -s $read_file_1 -o ! -s $read_file_2 ] ; then
 echo "One or both input read files $read_file_1, $read_file_2 are missing. Exiting."
 exit
fi
list_script+="$script_merge"
list_script+=" $script_trim"
list_script+=" $script_assemble"
list_script+=" $script_map_contigs"
list_script+=" $script_blast"
sed -i "s;#SBATCH --account=.*;#SBATCH --account=$account;g" $list_script
sed -i "s;^ *sample=.*;sample=\"$sample\";g" $list_script
sed -i "s;^ *group=.*;group=\"$group\";g" $list_script
sed -i "s;^ *scratch=.*;scratch=\"$scratch\";g" $list_script
sed -i "s;^ *min_len_contig=.*;min_len_contig=$1;g" $script_assemble
mkdir -p $scratch
echo Group directory : $group
echo Scratch directory : $scratch
jobid_merge=$(       sbatch --parsable                                      $script_merge       | cut -d ";" -f 1 )
echo Submitted script $script_merge with job ID $jobid_merge
jobid_trim=$(        sbatch --parsable --dependency=afterok:$jobid_merge    $script_trim        | cut -d ";" -f 1 )
echo Submitted script $script_trim with job ID $jobid_trim
jobid_assemble=$(    sbatch --parsable --dependency=afterok:$jobid_trim     $script_assemble    | cut -d ";" -f 1 )
echo Submitted script $script_assemble with job ID $jobid_assemble
jobid_map_contigs=$( sbatch --parsable --dependency=afterok:$jobid_assemble $script_map_contigs | cut -d ";" -f 1 )
echo Submitted script $script_map_contigs with job ID $jobid_map_contigs
jobid_blast=$(       sbatch --parsable --dependency=afterok:$jobid_assemble $script_blast       | cut -d ";" -f 1 )
echo Submitted script $script_blast with job ID $jobid_blast
