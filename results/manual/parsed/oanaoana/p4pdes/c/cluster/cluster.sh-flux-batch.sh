#!/bin/bash
#FLUX: --job-name=wobbly-puppy-2761
#FLUX: -n=12
#FLUX: --queue=debug
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
ulimit -s unlimited
ulimit -l unlimited
srun -l /bin/hostname | sort -n | awk '{print $2}' > ./nodes.$SLURM_JOB_ID
GO="mpiexec -n $SLURM_NTASKS -machinefile ./nodes.$SLURM_JOB_ID"
$GO ../ch5/pattern -da_refine 6 -ptn_phi 0.05 -ptn_kappa 0.063 -ts_final_time 5000 -ptn_noisy_init 0.15 -ts_monitor -log_view
$GO ../ch6/fish -fsh_dim 2 -snes_type ksponly -ksp_type gmres -ksp_rtol 1.0e-10 -ksp_converged_reason -log_view -pc_type asm -sub_pc_type lu -da_refine 9
$GO ../ch6/fish -fsh_dim 2 -snes_type ksponly -ksp_type gmres -ksp_rtol 1.0e-10 -ksp_converged_reason -log_view -pc_type mg -pc_mg_levels 2 -pc_mg_type additive -mg_levels_ksp_type preonly -mg_levels_pc_type asm -mg_levels_sub_pc_type lu -mg_coarse_ksp_type preonly -mg_coarse_pc_type redundant -mg_coarse_redundant_pc_type lu -da_refine 9
$GO ../ch6/fish -fsh_dim 3 -da_refine 8 -pc_mg_levels 6 -pc_type mg -snes_type ksponly -ksp_converged_reason -log_view
$GO ../ch11/advect -da_refine 8 -ts_final_time 1.0 -ts_rk_type 3bs -ts_monitor -log_view
$GO ../ch12/obstacle -da_grid_x 33 -da_grid_y 33 -snes_grid_sequence 6 -snes_converged_reason -snes_monitor -ksp_converged_reason -pc_type mg -log_view
rm ./nodes.$SLURM_JOB_ID
