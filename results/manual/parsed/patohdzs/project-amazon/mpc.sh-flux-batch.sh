#!/bin/bash
#FLUX: --job-name=id_${id}_${action_name}
#FLUX: --queue=caslake
#FLUX: -t=126000
#FLUX: --priority=16

pfarray=(20.76)
idarray=($(seq 1 10))
hmc_python_name="mpc_computation.py"
for id in "${idarray[@]}"; do
    for pf in "${pfarray[@]}"; do
                                count=0
                                action_name="test"
                                dataname="${action_name}"
                                mkdir -p ./job-outs/${action_name}/pf_${pf}_id_${id}/
                                if [ -f ./bash/${action_name}/pf_${pf}_id_${id}/run.sh ]; then
                                    rm ./bash/${action_name}/pf_${pf}_id/run.sh
                                fi
                                mkdir -p ./bash/${action_name}/pf_${pf}_id_${id}/
                                touch ./bash/${action_name}/pf_${pf}_id_${id}/run.sh
                                tee -a ./bash/${action_name}/pf_${pf}_id_${id}/run.sh <<EOF
module load python/anaconda-2022.05  
echo "\$SLURM_JOB_NAME"
echo "Program starts \$(date)"
start_time=\$(date +%s)
python3 -u /project/lhansen/HMC/project-amazon/scripts/$hmc_python_name  --pf ${pf} --id ${id} 
echo "Program ends \$(date)"
end_time=\$(date +%s)
elapsed=\$((end_time - start_time))
eval "echo Elapsed time: \$(date -ud "@\$elapsed" +'\$((%s/3600/24)) days %H hr %M min %S sec')"
EOF
        count=$(($count + 1))
        sbatch ./bash/${action_name}/pf_${pf}_id_${id}/run.sh
    done
done
