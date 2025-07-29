#!/bin/bash
#SBATCH --job-name=m_dist
#SBATCH --account=bigoilict
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=10-15:20:00
#SBATCH --partition=ict_gpu
#SBATCH --constraint=ntasks-per-node=4

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
echo "SLURM_JOBID: " $SLURM_JOBID
HOSTNAMES=$(hostname -I)
IP=$(echo $HOSTNAMES| cut -d' ' -f 2)
JOBNAME=$SLURM_JOB_NAME            # re-use the job-name specified above
NODES=$(scontrol show hostname $SLURM_JOB_NODELIST)
echo "${NODES[@]}"
declare -a IPs=()
for node in "${NODES[@]}"
do
   echo $node
   IP=$(cat /etc/hosts  | grep "$node" | awk '{ print $1 }')
   IPs+=($IP)
done
echo "${IPs[@]}"
JOINED_NODES=${IPs[@]}
JOINED_NODES=${JOINED_NODES// /,}
echo "JOINED_NODES: " $JOINED_NODES 
SHARED_FOLDERS="/scratch/parceirosbr/julia.potratz,/scratch/parceirosbr/bigoilict/share"
SIF_DOCKER_NAME="/scratch/parceirosbr/bigoilict/share/BigOil/NER/dockers/ner_pytorch_2.1_latest.sif"
PROJECT_HOME=$(pwd)
module load python/3.7.2
python distributed_ner.py \
--shared_folders ${SHARED_FOLDERS} \
--sif_file_path ${SIF_DOCKER_NAME} \
--nodes ${JOINED_NODES} \
--project_home ${PROJECT_HOME}
