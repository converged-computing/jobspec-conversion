#!/bin/bash
#FLUX: --job-name=IND_BIAS
#FLUX: -c=2
#FLUX: --queue=meta_gpu-ti
#FLUX: -t=950400
#FLUX: --urgency=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1.3
gpu_counter=1
for seed in {0..100}
    do
        for arch_idx in {0..30}
            do
              # Job to perform
              if [ $gpu_counter -eq $SLURM_ARRAY_TASK_ID ]; then
                 PYTHONPATH=$PWD python nasbench_analysis/architecture_inductive_bias/train.py --seed=${seed} --save=independent --search_space=3 --layers=9 --init_channels=16 --arch_idx=${arch_idx} --num_linear_layers=2
                 exit $?
              fi
              let gpu_counter+=1
            done
    done
done
echo "DONE";
echo "Finished at $(date)";
