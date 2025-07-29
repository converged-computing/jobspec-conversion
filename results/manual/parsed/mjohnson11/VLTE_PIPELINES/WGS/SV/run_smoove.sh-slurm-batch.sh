#!/bin/bash
#SBATCH --job-name=run_smoove
#SBATCH --output=../../../Output/shell_outs/run_smoove_%a.out
#SBATCH --error=../../../Output/shell_outs/run_smoove_%a.err
#SBATCH --mail-user=milo.s.johnson.13@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3500
#SBATCH --time=00:01:00

WELL=$(sed -n ${SLURM_ARRAY_TASK_ID}'{p;q}' ../../accessory_files/Wells.txt)
MYBAMS=""
for ((i=1;i<540;i++));
do
    SAMP=$(sed -n ${i}'{p;q}' ../../accessory_files/bam_map_combined_option.txt | awk '{print $1}')
    BAMPATH=$(sed -n ${i}'{p;q}' ../../accessory_files/bam_map_combined_option.txt | awk '{print $2}')
    if [[ $SAMP == *$WELL* ]]; then
        echo " ${BAMPATH}"
        MYBAMS+=" ../${BAMPATH}"
    fi
done
singularity exec ~/smoove_latest.sif smoove call --outdir ../../../Output/WGS/smoove_output/ --name ${WELL} --fasta ../../../Output/WGS/reference/w303_vlte.fasta -p 1 --genotype ${MYBAMS}
