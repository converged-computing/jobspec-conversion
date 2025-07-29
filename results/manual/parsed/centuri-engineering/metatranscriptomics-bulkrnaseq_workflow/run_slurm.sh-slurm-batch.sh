#!/bin/bash
#SBATCH --job-name=Microbeannotator
#SBATCH --account=a272
#SBATCH --output=./%N.%x.out
#SBATCH --error=./%N.%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=11:00:00

module load userspace/all
module load python3/3.6.3
module load singularity/3.5.1
pip install snakemake==6.3.0
pip install pandas
snakemake --snakefile Snakefile \
	--reason \
	--use-singularity \
	--use-conda \
	--conda-frontend conda \
	--singularity-args="-B /scratch/$SLURM_JOB_USER/mio_filella_crocosphaera/" \
	--jobs 1 \
	--latency-wait 20 \
	--max-jobs-per-second 5 \
	--max-status-checks-per-second 5 \
	--cluster-config cluster_config.json \
	--cluster 'sbatch -A {cluster.project} \
		--job-name {cluster.job-name} \
		--partition {cluster.partition} \
		--time {cluster.time} \
		-N {cluster.nodes-number} \
		-n {cluster.cores} \
		--mem-per-cpu {cluster.mem-per-cpu} \
		--output {cluster.output} \
		--error {cluster.error}' \
