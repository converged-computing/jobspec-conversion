#!/bin/bash
#FLUX: --job-name=bumfuzzled-cupcake-0988
#FLUX: --exclusive
#FLUX: --urgency=16

rankspernode=1
totalranks=$(( ${SLURM_NNODES} * ${rankspernode} ))
run_tag="deepcam_prediction_run1-cori"
data_dir_prefix="/data"
output_dir="./runs/profiles/${run_tag}"
profilebase="/usr/local/cuda/bin/nv-nsight-cu-cli --profile-from-start off -f"
mkdir -p ${output_dir}
touch ${output_dir}/profile.out
metrics="smsp__inst_executed_pipe_tensor_op_hmma.sum"
metrics+="smsp__sass_thread_inst_executed_op_fadd_pred_on.sum \
smsp__sass_thread_inst_executed_op_fmul_pred_on.sum \
smsp__sass_thread_inst_executed_op_ffma_pred_on.sum "
metrics+="smsp__sass_thread_inst_executed_op_hadd_pred_on.sum \
smsp__sass_thread_inst_executed_op_hmul_pred_on.sum \
smsp__sass_thread_inst_executed_op_hfma_pred_on.sum "
metrics+="smsp__cycles_elapsed.sum \
smsp__cycles_elapsed.sum.per_second "
metrics+="smsp__pipe_tensor_op_hmma_cycles_active.sum \
smsp__pipe_tensor_op_hmma_cycles_active.sum.per_second "
metrics+="l1tex__t_sectors_pipe_lsu_mem_local_op_ld.sum \
l1tex__t_sectors_pipe_lsu_mem_local_op_st.sum "
metrics+="l1tex__data_pipe_lsu_wavefronts_mem_shared_op_ld.sum \
l1tex__data_pipe_lsu_wavefronts_mem_shared_op_st.sum "
metrics+="l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum \
l1tex__t_sectors_pipe_lsu_mem_global_op_st.sum "
metrics+="l1tex__t_set_accesses_pipe_lsu_mem_global_op_atom.sum \
l1tex__t_set_accesses_pipe_lsu_mem_global_op_red.sum \
l1tex__t_set_accesses_pipe_tex_mem_surface_op_atom.sum \
l1tex__t_set_accesses_pipe_tex_mem_surface_op_red.sum "
metrics+="lts__t_sectors_op_read.sum \
lts__t_sectors_op_write.sum "
metrics+="lts__t_sectors_op_atom.sum \
lts__t_sectors_op_red.sum "
metrics+="dram__sectors_read.sum \
dram__sectors_write.sum "
metrics+="lts__t_sectors_aperture_sysmem_op_read.sum \
lts__t_sectors_aperture_sysmem_op_read.sum"
for metric in ${metrics}; do
    #assemble profile string
    profilecmd="${profilebase} --metrics ${metric} -o ${output_dir}/profile_${metric}"
    #run training
    srun -u -N ${SLURM_NNODES} -n ${totalranks} -c $(( 40 / ${rankspernode} )) --cpu_bind=cores \
	 shifter \
	 ${profilecmd} \
	 /opt/conda/bin/python ../profile_hdf5_ddp.py \
	 --wireup_method "nccl-slurm-pmi" \
	 --run_tag ${run_tag} \
	 --data_dir_prefix ${data_dir_prefix} \
	 --output_dir ${output_dir} \
	 --max_inter_threads 0 \
	 --optimizer "Adam" \
	 --start_lr 1e-3 \
	 --num_warmup_steps 5 \
	 --num_profile_steps 1 \
	 --profile "Forward" \
	 --weight_decay 1e-2 \
	 --amp_opt_level O1 \
	 --local_batch_size 2 |& tee -a ${output_dir}/profile.out
done
