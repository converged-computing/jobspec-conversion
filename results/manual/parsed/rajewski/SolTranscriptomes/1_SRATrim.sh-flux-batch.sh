#!/bin/bash
#FLUX: --job-name=goodbye-signal-2683
#FLUX: -c=6
#FLUX: --priority=16

set -eu
module load singularity/3.9.3
if [ ! -e SIFs/trim-galore_0.6.5.sif ]; then
	echo "Build a Singularity image for Trim Galore v0.6.5"
	exit 1
fi
accession=$(awk "NR==$SLURM_ARRAY_TASK_ID" SRA_IDs.tsv | cut -f1)
stem=$(awk "NR==$SLURM_ARRAY_TASK_ID" SRA_IDs.tsv | cut -f2)
end=$(awk "NR==$SLURM_ARRAY_TASK_ID" SRA_IDs.tsv | cut -f3)
_sra=$(realpath ./SRA)
_sif=/bigdata/littlab/arajewski/FULTranscriptomes/SIFs/trim-galore_0.6.5.sif
echo "Trimming FASTQ(s) for $stem"
if [ $end == "PE" ]; then
	echo "Running in paried-end mode"
	singularity exec \
		-B "$_sra:/mnt/SRA" \
		"$_sif" \
		trim_galore \
			--no_report_file \
			-j "$SLURM_CPUS_PER_TASK" \
			--paired \
			-o /mnt/SRA/ \
			/mnt/SRA/${stem}_1.fq.gz /mnt/SRA/${stem}_2.fq.gz
	echo "Done"
elif [ $end == "SE" ]; then
	echo "Running in single-end mode"
	singularity exec \
                -B "$_sra:/mnt/SRA" \
                "$_sif" \
                trim_galore \
                        --no_report_file \
                        -j "$SLURM_CPUS_PER_TASK" \
			-o /mnt/SRA/ \
			/mnt/SRA/${stem}_1.fq.gz
	echo "Done"
else
	echo "Malformed line in SRA_IDs.tsv"
fi
