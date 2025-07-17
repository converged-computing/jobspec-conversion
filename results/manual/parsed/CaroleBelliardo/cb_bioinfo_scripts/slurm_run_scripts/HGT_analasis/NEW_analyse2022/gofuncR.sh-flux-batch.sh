#!/bin/bash
#FLUX: --job-name=gofunc
#FLUX: -c=8
#FLUX: --queue=all
#FLUX: --urgency=16

module load singularity/3.5.3 
IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/GOFunc.sif'
path='/lerins/hub/projects/25_IPN_MetaNema/6-Pangenome/10-gofuncR/'
cd /lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/NEW_analyse/data_analyses/goFunc
FILES=($(ls -1))
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}
path=/lerins/hub/projects/25_IPN_MetaNema/66_Pangenome_clean/NEW_analyse/data_analyses/goFunc/$FILENAME
echo $path
singularity run -B "/lerins/hub" -B "/work/$USER" $IMG snakemake --snakefile /lerins/hub/DB/WORKFLOW/GOfuncR/Snakefile -j $SLURM_CPUS_PER_TASK --configfile ${path}/param.yaml
echo "$path ok"
