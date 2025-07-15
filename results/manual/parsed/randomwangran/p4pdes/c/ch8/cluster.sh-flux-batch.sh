#!/bin/bash
#FLUX: --job-name=delicious-lamp-1521
#FLUX: -n=12
#FLUX: --queue=debug
#FLUX: --priority=16

ulimit -s unlimited
ulimit -l unlimited
cd $PETSC_DIR
make streams NPMAX=$SLURM_NTASKS
cd $SLURM_SUBMIT_DIR
srun -l /bin/hostname | sort -n | awk '{print $2}' > ./nodes.$SLURM_JOB_ID
GO="mpiexec -n $SLURM_NTASKS -machinefile ./nodes.$SLURM_JOB_ID"
$GO ../ch5/pattern -da_refine 6 -ptn_phi 0.05 -ptn_kappa 0.063 -ts_max_time 2000 -ptn_noisy_init 0.15 -ts_monitor -log_view
$GO ../ch6/fish -fsh_dim 3 -da_refine 7 -pc_mg_levels 6 -pc_type mg -snes_type ksponly -ksp_converged_reason -log_view
$GO ../ch7/minimal -da_grid_x 33 -da_grid_y 33 -snes_grid_sequence 6 -snes_fd_color -snes_converged_reason -snes_monitor -ksp_converged_reason -pc_type mg -log_view
$GO ../ch11/advect -da_refine 8 -ts_max_time 0.5 -ts_rk_type 3bs -ts_monitor -log_view
$GO ../ch12/obstacle -da_grid_x 33 -da_grid_y 33 -snes_grid_sequence 6 -snes_converged_reason -snes_monitor -ksp_converged_reason -pc_type mg -log_view
rm ./nodes.$SLURM_JOB_ID
