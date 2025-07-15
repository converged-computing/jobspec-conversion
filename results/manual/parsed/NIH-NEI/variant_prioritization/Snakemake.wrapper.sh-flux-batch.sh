#!/bin/bash
#FLUX: --job-name=moolicious-caramel-8197
#FLUX: -c=8
#FLUX: --urgency=16

module load snakemake/5.24.1 || exit 1
cp /data/OGL/resources/variant_prioritization.git.log .
mkdir -p 00log
sbcmd="sbatch --cpus-per-task={threads} \
--mem={cluster.mem} \
--time={cluster.time} \
--partition={cluster.partition} \
--output={cluster.output} \
--error={cluster.error} \
{cluster.extra}"
if [[ $(grep "^genomeBuild" $1 | grep -i "GRCh38" | wc -l) < 1 ]]; then
	json="/home/$USER/git/variant_prioritization/src/cluster.json"
	snakefile="/home/$USER/git/variant_prioritization/src/Snakefile"
else
	json="/home/$USER/git/variant_prioritization/src_hg38/cluster.json"
	snakefile="/home/$USER/git/variant_prioritization/src_hg38/Snakefile"
fi
snakemake -s $snakefile \
-pr --local-cores 2 --jobs 1999 \
--configfile $1 \
--cluster-config $json \
--cluster "$sbcmd"  --latency-wait 120 --rerun-incomplete \
-k --restart-times 0 --resources res=1 $2
