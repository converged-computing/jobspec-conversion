#!/bin/bash
#FLUX: --job-name=graph_combine
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --priority=16

actiontime=1
epsilonarraypost=(0.1) # Computation of fine grid and psi10.8, post
NUM_DAMAGE=3
ID_MAX_DAMAGE=$((NUM_DAMAGE - 1))
declare -A hXarr1=([0]=0.2 [1]=0.2 [2]=0.2)
declare -A hXarr2=([0]=0.1 [1]=0.1 [2]=0.1)
declare -A hXarr3=([0]=0.05 [1]=0.05 [2]=0.05)
declare -A hXarr4=([0]=0.2 [1]=0.01 [2]=0.2)
declare -A hXarr5=([0]=0.1 [1]=0.05 [2]=0.1)
declare -A hXarr6=([0]=0.1 [1]=0.025 [2]=0.1)
declare -A hXarr7=([0]=0.1 [1]=0.01 [2]=0.1)
declare -A hXarr8=([0]=0.2 [1]=0.1 [2]=0.2)
hXarrays=(hXarr1)
Xminarr=(4.00 1.2 1.0 0.0)
Xmaxarr=(9.00 4.0 6.0 3.0)
xi_a=(1000. 0.0002 0.0002)
xi_p=(1000. 0.050 0.025)
psi0arr=(0.105830)
psi1arr=(0.5)
python_name_unit="Result_2jump_UD_plotpost_CRS_FK_smallgamma.py"
server_name="mercury"
LENGTH_psi=$((${#psi0arr[@]} - 1))
LENGTH_xi=$((${#xi_a[@]} - 1))
hXarr_SG=(0.2 0.2 0.2)
Xminarr_SG=(4.00 0.0 -5.5 0.0)
Xmaxarr_SG=(9.00 4.0 0.0 3.0)
interp_action_name="2jump_step_0.2_0.2_0.2_LR_0.01"
fstr_SG="NearestNDInterpolator"
auto=1
year=25
scheme_array=("direct")
HJBsolution_array=("direct")
LENGTH_scheme=$((${#scheme_array[@]} - 1))
for epsilonpost in ${epsilonarraypost[@]}; do
    for hXarri in "${hXarrays[@]}"; do
        count=0
        declare -n hXarr="$hXarri"
        # action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS"
        # action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS_PETSCFK"
        # action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS_PETSCFK_20dmg"
        # action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS2_PETSCFK"
        # action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_CRS2_PETSCFK_simulate2"
		# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_notonpoint"
		# action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_testpostivee"
		action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_smallgamma"
        for PSI_0 in ${psi0arr[@]}; do
            for PSI_1 in ${psi1arr[@]}; do
                # for PSI_2 in ${psi2arr[@]}; do
                        for k in $(seq 0 $LENGTH_scheme); do
                    mkdir -p ./job-outs/${action_name}/Graph_PlotPost/scheme_${scheme_array[$k]}_HJB_${HJBsolution_array[$k]}/PSI0_${PSI_0}_PSI1_${PSI_1}/
                    if [ -f ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_Graph.sh ]; then
                        rm ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_Graph.sh
                    fi
                    mkdir -p ./bash/${action_name}/
                    touch ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_Graph.sh
                    tee -a ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_Graph.sh <<EOF
module load python/booth/3.8  gcc/9.2.0
echo "\$SLURM_JOB_NAME"
echo "Program starts \$(date)"
start_time=\$(date +%s)
python3 /home/bcheng4/TwoCapital_Shrink/abatement_UD/${python_name_unit} --dataname  ${action_name} --pdfname ${server_name} --psi0 ${PSI_0} --psi1 ${PSI_1}  --xiaarr ${xi_a[@]} --xigarr ${xi_p[@]}   --hXarr ${hXarr[@]} --Xminarr ${Xminarr[@]} --Xmaxarr ${Xmaxarr[@]} --auto $auto --IntPeriod ${year} --num_gamma ${NUM_DAMAGE} --scheme ${scheme_array[$k]}  --HJB_solution ${HJBsolution_array[$k]}  --num_gamma $NUM_DAMAGE
echo "Program ends \$(date)"
end_time=\$(date +%s)
elapsed=\$((end_time - start_time))
eval "echo Elapsed time: \$(date -ud "@\$elapsed" +'\$((%s/3600/24)) days %H hr %M min %S sec')"
EOF
                    sbatch ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_Graph.sh
                    done
                done
            done
        # done
    done
done
