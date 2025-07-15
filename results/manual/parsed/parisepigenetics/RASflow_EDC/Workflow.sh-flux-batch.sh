#!/bin/bash
#FLUX: --job-name=RASflow
#FLUX: -t=86400
#FLUX: --priority=16

echo '########################################'
echo 'Date:' $(date --iso-8601=seconds)
echo 'User:' $USER
echo 'Host:' $HOSTNAME
echo 'Job Name:' $SLURM_JOB_NAME
echo 'Job Id:' $SLURM_JOB_ID
echo 'Directory:' $(pwd)
echo '########################################'
echo 'RASflow_EDC version: v1.3'
echo '-------------------------'
echo 'Main module versions:'
start0=`date +%s`
. scripts/parse_yaml.sh
eval $(parse_yaml configs/cluster_config.yaml "config_")
cat configs/.config_template.yaml > configs/config.yaml
echo "  - partition=$config_partition" >> configs/config.yaml
module purge
module load $config_modules # access yaml content
echo "Loaded modules : $config_modules"
python --version
echo 'snakemake' && snakemake --version
echo '-------------------------'
echo 'PATH:'
echo $PATH
echo '########################################'
unset DISPLAY
singularity_image="https://zenodo.org/record/7303435/files/rasflow_edc.simg"
CONFIG_FILE="config_ongoing_run.yaml"
if test -f "$CONFIG_FILE"; then
    echo "Another run is on going, please wait for its end before restarting RASflow_EDC. "
else 
    cp configs/config_main.yaml $CONFIG_FILE && chmod 444 $CONFIG_FILE
    # run the workflow
    python scripts/main_cluster.py $singularity_image
    # remove configuration file copy
    chmod 777 $CONFIG_FILE && rm $CONFIG_FILE
    echo '########################################'
    echo 'Job finished' $(date --iso-8601=seconds)
    end=`date +%s`
    runtime=$((end-start0))
    minute=60
    echo "---- Total runtime $runtime s ; $((runtime/minute)) min ----"
    # move logs
    mkdir -p logs
    mv "RASflow-$SLURM_JOB_ID.out" logs
fi
