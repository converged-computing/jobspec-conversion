#!/bin/bash
#FLUX: --job-name=psycho-peanut-butter-5774
#FLUX: -c=6
#FLUX: --exclusive
#FLUX: -t=180
#FLUX: --urgency=16

for j in {0..16..4}
do
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+0)) 0 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+0))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+1)) 1 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+1))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+2)) 2 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+2))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+3)) 3 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+3))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    wait
done
