#!/bin/sh
#PBS -N ngs-pipeline
#
# 
# Usually slurm can translate the PBS varibles so no need to initialize the sbatch variables.
#set -eo pipefail
module load snakemake/5.24.1
module load singularity
if [[ $time == 'd' ]]; then
	export TIME="20160415"
elif [[ $time == 'p' ]]; then
	export TIME=$(date +"%Y%m%d")
else
	export TIME=$time
#	echo -e "Can not run without knowing which mode you would like to set time up\n";
#	exit;
fi
if [[ ! -z $ngs ]]; then
        export NGS_PIPELINE=$ngs
fi
if [[ ! -z $dataDir ]]; then
        export DATA_DIR=$dataDir
fi

if [[ ! -z $workDir ]]; then
        export WORK_DIR=$workDir
        SAM_CONFIG=$WORK_DIR/samplesheet.json
fi

## for samplesheet
if [[ $sheet == 'samplesheet.json' ]]; then
	SAM_CONFIG=$WORK_DIR/samplesheet.json
else
	SAM_CONFIG=$sheet
fi

sheet_name=`basename $SAM_CONFIG .json`
export SAMPLESHEET="$sheet_name"
export CLUSTER_CONF="$cluster_conf"
#NOW=$(date +"%Y%m%d_%H%M%S")
NOW=$runTime
#export TIME=$(date +"%Y%m%d%H")
export TMP="$NOW"

pid=$(echo $sheet_name | cut -d'_' -f1)

if [[ ! -z $sheet_name ]]; then
	export Patient_ID=$pid
else
	pid=$(echo $sheet_name | cut -d'=' -f1)
	export Patient_ID=$pid	
fi

if [[ `hostname` =~ "cn" ]] || [ `hostname` == 'biowulf.nih.gov' ]; then
	#module load snakemake/3.5.5.nl
	export HOST="biowulf.nih.gov"
elif [[ `hostname` =~ "tghighmem" ]] || [[ `hostname` =~ "tgcompute" ]] || [ `hostname` == 'login01' ] ; then
	#module load snakemake/3.5.5
	export HOST="login01"
else 
	echo -e "Host `hostname` is not recognized\n"
	echo -e "This pipeline is customized to run on biowulf.nih.gov or TGen Cluster @ KhanLab\n";
	echo -e "If you would like to use it on another system, you have to change config/config_cluster.json and some hardcoded system dependencies\n";
	exit;
fi


cd $WORK_DIR
if [ ! -d log ]; then
	mkdir log
fi



# set extra singularity bindings
#EXTRA_SINGULARITY_BINDS="-B /data/Clinomics/Tools/singularity"

export SINGULARITY_CACHEDIR="/data/Clinomics/Tools/singularity"
#mkdir -p $SINGULARITY_CACHEDIR

## set and export SINGULARITY_BINDPATHS
. /usr/local/current/singularity/app_conf/sing_binds


function set_singularity_binds(){
    local gpfs_links link gpfs_dirs add_comma

    gpfs_links="$(ls -d /gs*)"
    # check to see if any gs* links are broken
    for link in $gpfs_links; do
        if [ -e "${link}" ]; then
            gpfs_dirs+="${add_comma:-}${link}"
            # only prepend the comma _after_ the first iteration
            add_comma=,
        fi
    done
    SINGULARITY_BINDS="-B ${gpfs_dirs:-},/vf,/spin1,/data,/fdb,/gpfs"
#     SINGULARITY_BINDS="-B /data/khanlab,/data/Clinomics,/data/khanlab2,/data/khanlab3"
}


#export SINGULARITY_BINDPATH="/data"

function printbinds(){
  set_singularity_binds
  echo $SINGULARITY_BINDS
}

#printbinds

export ACT_DIR="/Actionable/"
SNAKEFILE=$NGS_PIPELINE/ngs_pipeline.rules

cmd="--directory $WORK_DIR --snakefile $SNAKEFILE --configfile $SAM_CONFIG --jobscript $NGS_PIPELINE/scripts/jobscript.sh --use-singularity --singularity-prefix /data/Clinomics/Tools/singularity-prefix  --use-envmodules --jobname {params.rulename}.{jobid} --nolock --latency-wait 180 --ri -k -p  -r -j 3000 -T 1  --resources SIFT=8 --stats ngs_pipeline_${sheet_name}_${NOW}.stats -R RNASeq "
#cmd="--directory $WORK_DIR --snakefile $SNAKEFILE --configfile $SAM_CONFIG --jobscript $NGS_PIPELINE/scripts/jobscript.sh --jobname {params.rulename}.{jobid} --nolock  --ri -k -p -T -r -j 3000 --resources DeFuse=25 --resources SIFT=8 --stats ngs_pipeline_${sheet_name}_${NOW}.stats -R RNASeq -O MergeFQ Khanlab_Pipeline RNASeq"
umask 022
if [ $HOST   == 'biowulf.nih.gov' ]; then
	echo "Host identified as $HOST"
	echo "Variables are $cmd"
	snakemake $cmd --cluster "sbatch -o $pid/$time/log/{params.rulename}.%j.o -e $pid/$time/log/{params.rulename}.%j.e {params.batch}" >& ngs_pipeline_${sheet_name}_${NOW}.log
elif [ $HOST == 'login01' ]; then
	echo "Host identified as $HOST"
	echo "Variables are $cmd"
	snakemake $cmd --cluster "sbatchT -o log/{params.rulename}.%j.o -e log/{params.rulename}.%j.e {params.batch}" >& ngs_pipeline_${sheet_name}_${NOW}.log
	rm -rf /projects/scratch/ngs_pipeline_${sheet_name}_${NOW}_*
fi

if [ -f ngs_pipeline_${sheet_name}_${NOW}.stats ]; then	
	python $NGS_PIPELINE/scripts/stats2Table.py ngs_pipeline_${sheet_name}_${NOW}.stats >ngs_pipeline_${sheet_name}_${NOW}.stats.txt
fi


if [ -s ngs_pipeline_${sheet_name}_${NOW}.stats.txt ]; then
	echo "No job took significant time"
else
	rm -rf ngs_pipeline_${sheet_name}_${NOW}.stats.txt	
fi
