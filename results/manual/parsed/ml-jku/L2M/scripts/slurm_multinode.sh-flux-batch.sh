#!/bin/bash
#FLUX: --job-name=confused-peas-4677
#FLUX: -N=2
#FLUX: --queue=X
#FLUX: --urgency=16

export LOGLEVEL='INFO'

source activate mddt
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
RANDOM=84210
echo Node IP: $head_node_ip
echo Nodes array: $nodes
echo Head node: $head_node
echo head_node_ip: $head_node_ip
export LOGLEVEL=INFO
python main.py -m hydra/launcher=torchrun +hydra.launcher.nnodes=2 hydra.launcher.nproc_per_node=2 hydra.launcher.max_nodes=2 hydra.launcher.rdzv_id=$RANDOM hydra.launcher.rdzv_backend=c10d hydra.launcher.rdzv_endpoint=$head_node_ip:29501 +ddp=True experiment_name=mddt_pretrain seed=42 env_params=multi_domain_mtdmc agent_params=cdt_pretrain_disc agent_params.kind=MDDT agent_params/model_kwargs=multi_domain_mtdmc agent_params/data_paths=mt40v2_dmc10 run_params=pretrain eval_params=pretrain_disc +agent_params/replay_buffer_kwargs=multi_domain_mtdmc +agent_params.accumulation_steps=2 +agent_params.use_amp=True +agent_params.batch_size=256
