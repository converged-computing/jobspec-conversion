#!/bin/bash
#FLUX: --job-name="ClinOmics"
#FLUX: --priority=16

export TimeStamp='$NOW'
export SERPENTINE_HOME='/data/Clinomics/Tools/serpentine2'

NOW=$(date +"%H%M%S_%m%d%Y")
export TimeStamp=$NOW
cd $SLURM_SUBMIT_DIR
module load python/3.4.3
export SERPENTINE_HOME="/data/Clinomics/Tools/serpentine2"
module load R/3.2.0_gcc-4.4.7
${SERPENTINE_HOME}/scripts/do_samplesheet2json.R -s Clinomics_pipeline_samplesheet.txt -c ${SERPENTINE_HOME}/config_common.json -o '.'
module load rpy2/2.6.1-R_3.2.0
snakemake \
	--nolock \
	--jobname 'cln.{rulename}.{jobid}' \
	-s ${SERPENTINE_HOME}/workflows/variant_calling/Snakefile \
	-d `pwd` \
	--js ${SERPENTINE_HOME}/jobscript.sh \
	-k -r -p -w 10 -T \
	--rerun-incomplete \
	--stats serpentine_${NOW}.stats \
	-j 3000 \
	--cluster "sbatch -p ccr -e log/{params.rulename}.%j.e -o log/{params.rulename}.%j.o {params.batch}" \
	>& serpentine_${NOW}.log 
