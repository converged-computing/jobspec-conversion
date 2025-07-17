#!/bin/bash
#FLUX: --job-name=fat-carrot-6421
#FLUX: -c=4
#FLUX: --queue=epyc_ssd
#FLUX: --urgency=16

export NXF_OPTS='-Xms500M -Xmx2G'

echo "Some Usable Environment Variables:"
echo "================================="
echo "hostname=$(hostname)"
echo \$SLURM_JOB_ID=${SLURM_JOB_ID}
echo \$SLURM_NTASKS=${SLURM_NTASKS}
echo \$SLURM_NTASKS_PER_NODE=${SLURM_NTASKS_PER_NODE}
echo \$SLURM_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
echo \$SLURM_JOB_CPUS_PER_NODE=${SLURM_JOB_CPUS_PER_NODE}
echo \$SLURM_MEM_PER_NODE=${SLURM_MEM_PER_NODE}
module purge
module load nextflow/21.10
module load singularity/3.8.7
export NXF_OPTS="-Xms500M -Xmx2G"
workdir="/tmp"
installdir="/mnt/data/GROUP-smbpk/sbidp3/AMRplusplus"
resultsdir="/mnt/data/GROUP-smbpk/sbidp3/AMRplus-all-out"
run="DANS-AMR_April_bracken"
cd ${installdir}
nextflow run ${installdir}/main_AMR++.nf \
	-w "${workdir}/${run}/work" \
	-c "${installdir}/config/test_singularity_slurm.config" \
	--reads "${workdir}/${run}/fastq/*{R1,R2}.fastq.gz" \
	--pipeline kraken_and_bracken \
	--output "${workdir}/${run}/bracken" \
	-with-report "${workdir}/${run}/${run}.html" \
	-with-trace "${installdir}/logs/${SLURM_JOB_ID}.trace.txt" \
	-resume
