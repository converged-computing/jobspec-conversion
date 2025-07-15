#!/bin/bash
#FLUX: --job-name=crusty-hope-4031
#FLUX: --urgency=16

export OMP_NUM_THREADS='1           # 设置全局 OpenMP 线程为1 '
export PETSC_DIR='/home/yangchao/zl/petsc-3.6.4'
export PETSC_ARCH='linux-gnu-c-debug'

module add mpich/3.2.1             # 添加 mpich/3.2.1 模块，注意，不带 -pmi 后缀
export OMP_NUM_THREADS=1           # 设置全局 OpenMP 线程为1 
export PETSC_DIR=/home/yangchao/zl/petsc-3.6.4
export PETSC_ARCH=linux-gnu-c-debug
mpiexec -n 8 ./main -ksp_monitor\
  -ksp_atol 1.e-11 -ksp_rtol 1.e-3 -ksp_type gmres -ksp_gmres_restart 30\
  -ksp_pc_side right -pc_type asm -pc_asm_type restrict -pc_asm_overlap 2 -sub_ksp_type preonly\
  -sub_pc_type ilu -ksp_converged_reason -da_grid_x 256 -da_grid_y 256  -fd 0\
  -eps 0.025 -Length 128 -endT 3200 -Tmin 0.01 -Tmax 20 -interP 100 -sub_pc_factor_levels 2
