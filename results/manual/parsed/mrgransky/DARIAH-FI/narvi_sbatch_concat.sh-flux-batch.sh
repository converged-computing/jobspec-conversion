#!/bin/bash
#FLUX: --job-name=spm_xy_1e6_all_queries
#FLUX: --queue=amd
#FLUX: -t=14399
#FLUX: --priority=16

user="`whoami`"
stars=$(printf '%*s' 100 '')
txt="$user began Slurm job: `date`"
ch="#"
echo -e "${txt//?/$ch}\n${txt}\n${txt//?/$ch}"
echo "${stars// /*}"
echo "CPUS/NODE: $SLURM_JOB_CPUS_PER_NODE, MEM/NODE(--mem): $SLURM_MEM_PER_NODE"
echo "$SLURM_SUBMIT_HOST @ $SLURM_JOB_ACCOUNT, node: $SLURMD_NODENAME, CLUSTER: $SLURM_CLUSTER_NAME, Partition: $SLURM_JOB_PARTITION, $SLURM_JOB_GPUS"
echo "JOBname: $SLURM_JOB_NAME, ID: $SLURM_JOB_ID, WRK_DIR: $SLURM_SUBMIT_DIR"
echo "nNODES: $SLURM_NNODES, NODELIST: $SLURM_JOB_NODELIST, NODE_ID: $SLURM_NODEID"
echo "nTASKS: $SLURM_NTASKS, TASKS/NODE: $SLURM_TASKS_PER_NODE, nPROCS: $SLURM_NPROCS"
echo "CPUS_ON_NODE: $SLURM_CPUS_ON_NODE, CPUS/TASK: $SLURM_CPUS_PER_TASK, MEM/CPU: $SLURM_MEM_PER_CPU"
echo "nTASKS/CORE: $SLURM_NTASKS_PER_CORE, nTASKS/NODE: $SLURM_NTASKS_PER_NODE"
echo "THREADS/CORE: $SLURM_THREADS_PER_CORE"
echo "${stars// /*}"
echo "$SLURM_CLUSTER_NAME conda env from Anaconda..."
source activate py39
dfsDIR="/lustre/sgn-data/Nationalbiblioteket/dataframes_XY_maxNumFeatures_1000000" ########## must be adjusted! ##########
for qu in 'torvisoittokunta' 'Economical Crisis in Finland' 'Global Warming' 'Helsingin Kaupunginteatteri' 'Suomen pankki lainat ja talletukset' 'Suomalainen Kirjakauppa' 'kantakirjasonni' 'Senaatti-kiinteistöt ja Helsingin kaupunki' 'finska skolor på åland' 'Helsingfors stadsteater' 'Åbo Akademi i Vasa' 'Stockholms universitet' 'Jakobstads svenska församling' 'Ålands kulturhistoriska museum' 'TAMPEREEN TEHDAS' 'Tampereen seudun työväenopisto' 'Helsingin pörssi ja suomen pankki' 'Tampereen Työväen Teatteri' 'Juha Sipilä Sahalahti' 
do
	echo "Query: $qu"
	python -u concat_dfs.py --dfsPath $dfsDIR --lmMethod 'stanza' --qphrase "$qu"
done
done_txt="$user finished Slurm job: `date`"
echo -e "${done_txt//?/$ch}\n${done_txt}\n${done_txt//?/$ch}"
echo "${stars// /*}"
