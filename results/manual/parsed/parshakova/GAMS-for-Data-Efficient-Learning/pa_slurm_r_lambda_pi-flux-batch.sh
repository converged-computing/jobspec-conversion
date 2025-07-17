#!/bin/bash
#FLUX: --job-name=tjarray
#FLUX: -c=2
#FLUX: --queue=papago
#FLUX: -t=720000
#FLUX: --urgency=16

hostname
srun hostname
srun nvidia-smi -L
cd /tmp-network/user/tparshak/exp_gams
seqlen=( 30 )
motif=( 4 )
dssize=( 1000 )
feats=( 's001111' '1001111' )
train_reg=( 'rs' 'snis_r' )
mtypes=( 'm' )
for n in ${seqlen[@]}; do
	for m in ${motif[@]}; do
		for ds in ${dssize[@]}; do
			for f in ${feats[@]}; do
				for tr in ${train_reg[@]}; do
					for mt in ${mtypes[@]}; do
						echo "$ds||$m||$n||$f||$tr||$mt"
						python -u r_plambda_distill_pitheta.py --n ${n} --ds_size ${ds} --motif ${m} --job ${SLURM_JOB_ID} --feat ${f} --train ${tr} --mtype ${mt} --restore yes --distill_size 20000
						echo "$ds||$m||$n||$f||$tr||$mt"
					done
				done
			done
		done
	done
done
scontrol show job ${SLURM_ARRAY_JOB_ID}
echo "SLURM_JOBID=$SLURM_JOBID"
echo "SLURM_ARRAY_JOB_ID=$SLURM_ARRAY_JOB_ID"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"
cp /tmp-network/user/tparshak/plambda_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.log /home/tparshak/logs/plambda_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.log
rm -f /tmp-network/user/tparshak/plambda_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.log
