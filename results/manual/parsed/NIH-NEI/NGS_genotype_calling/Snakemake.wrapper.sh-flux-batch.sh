#!/bin/bash
#FLUX: --job-name=bloated-avocado-0806
#FLUX: -c=8
#FLUX: --urgency=16

cp /data/OGL/resources/NGS_genotype_calling.git.log .
mkdir -p 00log
module load snakemake/6.0.5 || exit 1
sbcmd="sbatch --cpus-per-task={threads} \
--mem={cluster.mem} \
--time={cluster.time} \
--partition={cluster.partition} \
--output={cluster.output} \
--error={cluster.error} \
{cluster.extra}"
lib=$2
ngstype=$3
metadata_file=$(grep "metadata_file" $1 | head -n 1 | cut -d"'" -f 2)
if [ -e $metadata_file ];
then
	echo "metadata_file provided"
	sort --field-separator="," -k 1,2 $metadata_file > metadata_file.edited && mv metadata_file.edited $metadata_file
else
	for fastq1 in fastq/*.gz; do
	filename=$(basename $fastq1)
	header=$(zcat $fastq1 | head -1)
	id=$(echo $header | cut -d: -f 3,4 | sed 's/\:/\./g')
	sm=$(echo $filename | cut -d_ -f 1 | sed 's/\-/\_/g')
	echo "$sm,$filename,@RG\\\tID:$id"_"$sm\\\tSM:$sm\\\tLB:$lib"_"$sm\\\tPL:ILLUMINA" >> metadata_file.csv
	done
fi
case "${ngstype^^}" in
	"PANEL")
		snakemake -s /home/$USER/git/NGS_genotype_calling/NGS_generic_OGL/panel.Snakefile \
		-pr --local-cores 2 --jobs 1999 \
		--cluster-config /home/$USER/git/NGS_genotype_calling/NGS_generic_OGL/panel.cluster.json \
		--cluster "$sbcmd"  --latency-wait 120 --rerun-incomplete \
		-k --restart-times 0 \
		--resources parallel=4 \
		--configfile $1 $4
		;;
	"EXOME"|"WES")
		snakemake -s /home/$USER/git/NGS_genotype_calling/NGS_generic_OGL/exome.Snakefile \
		-pr --local-cores 2 --jobs 1999 \
		--cluster-config /home/$USER/git/NGS_genotype_calling/NGS_generic_OGL/exome.cluster.json \
		--cluster "$sbcmd"  --latency-wait 120 --rerun-incomplete \
		-k --restart-times 0 \
		--resources parallel=4 \
		--configfile $1 $4
		;;
	*)
		snakemake -s /home/$USER/git/NGS_genotype_calling/NGS_generic_OGL/Snakefile \
		-pr --local-cores 2 --jobs 1999 \
		--cluster-config /home/$USER/git/NGS_genotype_calling/NGS_generic_OGL/cluster.json \
		--cluster "$sbcmd"  --latency-wait 120 --rerun-incomplete \
		-k --restart-times 0 \
		--resources parallel=4 \
		--configfile $1 $4
		;;
esac
