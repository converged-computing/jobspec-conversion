#!/bin/bash
#SBATCH --job-name=hvd_test
#SBATCH --output=hvd_test_out.txt
#SBATCH --error=hvd_test_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=4

export PYTHONPATH='/project/jhlsrf003/JHL_installations/Python/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/jupyterhub/1.1.0-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/IPython/7.13.0-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/matplotlib/3.2.1-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/Tkinter/3.8.2-GCCcore-9.3.0/lib/python3.8:/sw/arch/Debian10/EB_production/2020/software/Tkinter/3.8.2-GCCcore-9.3.0/easybuild/python:/sw/arch/Debian10/EB_production/2020/software/SciPy-bundle/2020.03-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/Python/3.8.2-GCCcore-9.3.0/easybuild/python'

module purge
module load 2020
module load OpenMPI/4.0.3-GCC-9.3.0
module load Python/3.8.2-GCCcore-9.3.0
export PYTHONPATH="/project/jhlsrf003/JHL_installations/Python/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/jupyterhub/1.1.0-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/IPython/7.13.0-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/matplotlib/3.2.1-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/Tkinter/3.8.2-GCCcore-9.3.0/lib/python3.8:/sw/arch/Debian10/EB_production/2020/software/Tkinter/3.8.2-GCCcore-9.3.0/easybuild/python:/sw/arch/Debian10/EB_production/2020/software/SciPy-bundle/2020.03-foss-2020a-Python-3.8.2/lib/python3.8/site-packages:/sw/arch/Debian10/EB_production/2020/software/Python/3.8.2-GCCcore-9.3.0/easybuild/python"
time mpirun -np 4  python mnist_hvd_2.py
