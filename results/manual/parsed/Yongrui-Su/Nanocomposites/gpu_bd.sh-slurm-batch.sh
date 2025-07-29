#!/bin/bash
#SBATCH --job-name=att_tauss_0.5
#SBATCH --output=outputfile.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=1,k20m|k40m

module load cuda/6.5
module load boost/1.55+python-2.7-2014q1
nvidia-smi
./ysu_bd_gpu
exit_code=$?
if [ $exit_code -eq 88 ]; then
    #echo cat hills                                                                                                                                                      
    #to keep stdout looking nice                                                                                                                                         
    #echo Appending stdout to stdout.prev                                                                                                                               
    if [ -e outputfile.txt.prev ]; then
        cat outputfile.txt.prev outputfile.txt > tmp
        mv tmp outputfile.txt
    fi
    mv outputfile outputfile.prev
    #find files that have been modified recently ...say the last 30 minutes                                                                                             
    echo -e "=================================\nResubmitting simulation!!!\n=================================\n"
    sbatch gpu_bd.sh
    exit 0
else
    echo "exe did not exit due to MAX_WALL_CLOCK"
