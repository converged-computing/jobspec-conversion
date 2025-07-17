#!/bin/bash
#FLUX: --job-name=fuzzy-squidward-0915
#FLUX: -n=64
#FLUX: --queue=t1standard
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
srun -l /bin/hostname | sort -n | awk '{print $2}' > ./nodes.$SLURM_JOB_ID
for LEV in 5 6 7 8 9 10 11 12; do
    echo $LEV
    time mpiexec -np $SLURM_NTASKS -machinefile ./nodes.$SLURM_JOB_ID ../../ice \
      -ice_verif 2 -ts_type beuler -ice_tf 10.0 -ice_dtinit 10.0 -da_refine $LEV \
      -snes_monitor -snes_converged_reason -ksp_converged_reason -ice_dtlimits \
      -pc_type gamg -pc_gamg_agg_nsmooths 0
      # -pc_type asm -sub_pc_type gamg
      # -pc_type mg -pc_mg_levels $(( $LEV - 1 ))
      # -pc_type mg -pc_mg_levels $(( $LEV - 2 ))
      # -pc_type asm -sub_pc_type ilu
done
rm ./nodes.$SLURM_JOB_ID
