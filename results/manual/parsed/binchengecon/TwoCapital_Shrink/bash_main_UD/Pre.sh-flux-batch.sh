#!/bin/bash
#FLUX: --job-name=${xi_a[$j]}_${xi_c[$j]}_${xi_d[$j]}_${xi_g[$j]}_${PSI_0}_${PSI_1}_${varrho}_${epsilon}
#FLUX: -c=5
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --priority=16

actiontime=1
epsilonarraypost=(0.05) # Computation of fine grid and psi10.8, post
epsilonarraypre=(0.05) #
python_name="predamage_2jump_CRS2.py"
NUM_DAMAGE=20
ID_MAX_DAMAGE=$((NUM_DAMAGE - 1))
maxiterarr=(80000 200000)
declare -A hXarr1=([0]=0.2 [1]=0.2 [2]=0.2)
declare -A hXarr2=([0]=0.1 [1]=0.1 [2]=0.1)
declare -A hXarr3=([0]=0.05 [1]=0.05 [2]=0.05)
declare -A hXarr4=([0]=0.2 [1]=0.01 [2]=0.2)
declare -A hXarr5=([0]=0.1 [1]=0.05 [2]=0.1)
declare -A hXarr6=([0]=0.1 [1]=0.025 [2]=0.1)
declare -A hXarr7=([0]=0.1 [1]=0.01 [2]=0.1)
declare -A hXarr8=([0]=0.2 [1]=0.1 [2]=0.2)
hXarrays=(hXarr2)
Xminarr=(4.00 1.2 1.0 0.0)
Xmaxarr=(9.00 4.0 6.0 3.0)
xi_a=(100000. 100000. 100000.)
xi_c=(0.050 100000. 100000.)
xi_d=(100000. 0.050 100000.)
xi_g=(100000. 100000. 0.050)
varrhoarr=(1120)
psi0arr=(0.105830)
psi1arr=(0.5)
LENGTH_psi=$((${#psi0arr[@]} - 1))
LENGTH_xi=$((${#xi_a[@]} - 1))
hXarr_SG=(0.2 0.2 0.2)
Xminarr_SG=(4.00 0.0 -5.5 0.0)
Xmaxarr_SG=(9.00 4.0 0.0 3.0)
interp_action_name="2jump_step_0.2_0.2_0.2_LR_0.01"
fstr_SG="NearestNDInterpolator"
for epsilon in ${epsilonarraypre[@]}; do
	for epsilonpost in ${epsilonarraypost[@]}; do
		for hXarri in "${hXarrays[@]}"; do
			count=0
			declare -n hXarr="$hXarri"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS_PETSCFK"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS_PETSCFK_20dmg"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS2_PETSCFK"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS2_PETSCFK"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_testpostivee"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilon}_globalmiss"
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilon}_globalmiss2"			
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilon}_globalmiss2_varrho1120"			
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilon}_globalmiss_varrho1120"			
			action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilon}_presentation"			
			# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilon}_presentation448"			
			epsilonarr=(0.05 ${epsilon})
			fractionarr=(0.1 ${epsilon})
			for PSI_0 in ${psi0arr[@]}; do
				for PSI_1 in ${psi1arr[@]}; do
					for varrho in ${varrhoarr[@]}; do
					for j in $(seq 0 $LENGTH_xi); do
						mkdir -p ./job-outs/${action_name}/Pre/xia_${xi_a[$j]}_xic_${xi_c[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}/
						if [ -f ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xic_${xi_c[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_Eps_${epsilon}.sh ]; then
							rm ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xic_${xi_c[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_Eps_${epsilon}.sh
						fi
						mkdir -p ./bash/${action_name}/
						touch ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xic_${xi_c[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_Eps_${epsilon}.sh
						tee -a ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xic_${xi_c[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_Eps_${epsilon}.sh <<EOF
module purge
module load python/booth/3.8  gcc/9.2.0
echo "\$SLURM_JOB_NAME"
echo "Program starts \$(date)"
start_time=\$(date +%s)
srun python3 /home/bcheng4/TwoCapital_Shrink/abatement_UD/$python_name --num_gamma $NUM_DAMAGE --xi_a ${xi_a[$j]} --xi_c ${xi_c[$j]} --xi_d ${xi_d[$j]} --xi_g ${xi_g[$j]}   --epsilonarr ${epsilonarr[@]}  --fractionarr ${fractionarr[@]}   --maxiterarr ${maxiterarr[@]}  --psi_0 $PSI_0 --psi_1 $PSI_1    --name ${action_name} --hXarr ${hXarr[@]} --Xminarr ${Xminarr[@]} --Xmaxarr ${Xmaxarr[@]} --varrho ${varrho}
echo "Program ends \$(date)"
end_time=\$(date +%s)
elapsed=\$((end_time - start_time))
eval "echo Elapsed time: \$(date -ud "@\$elapsed" +'\$((%s/3600/24)) days %H hr %M min %S sec')"
EOF
						count=$(($count + 1))
						sbatch ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xic_${xi_c[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_Eps_${epsilon}.sh
						done
					done
				done
			done
		done
	done
done
