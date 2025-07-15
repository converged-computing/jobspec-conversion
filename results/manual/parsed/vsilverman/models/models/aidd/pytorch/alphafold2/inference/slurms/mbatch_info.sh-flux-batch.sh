#!/bin/bash
#FLUX: --job-name=iaf2info
#FLUX: --exclusive
#FLUX: --queue=64c512g
#FLUX: --priority=16

echo "----"
echo jobid=$SLURM_JOB_ID # job index
echo submitdir=$SLURM_SUBMIT_DIR # working directory of script that submit
echo job_nnodes=$SLURM_JOB_NUM_NODES # node number when task is allocated
echo job_nodelist=$SLURM_JOB_NODELIST # node list when task is allocated
echo job_cpupernode=$SLURM_JOB_CPUS_PER_NODE # allocated CPU cores in allocated task
echo "----"
nidsubstr=${SLURM_JOB_NODELIST:5:-1}
IFS=',' nidranges=(${nidsubstr})
nnodes=0
unset $nids
for nidrange in ${nidranges[@]}; do
  if [[ $nidrange == *"-"* ]]; then
    IFS='-' startend=(${nidrange})
    start=${startend[0]}
    end=${startend[1]}
    IFS=' ' subnodes=`seq $start $end|xargs`
    for nid in $subnodes; do
      nids[$nnodes]=$nid
      ((nnodes+=1))
    done
  else
    nids[$nnodes]=$nidrange
    ((nnodes+=1))
  fi
done
echo "total node number = $nnodes"
prefix="node"
for nid in ${nids[@]}; do
  echo allocate task on $prefix$nid
  srun -w $prefix$nid --exclusive bash slurms/print_node_info.sh &
done
