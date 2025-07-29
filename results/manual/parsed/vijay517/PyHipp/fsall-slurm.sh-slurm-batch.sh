#!/bin/bash
#SBATCH --job-name=fsall
#SBATCH --output=fsall-slurm.%N.%j.out
#SBATCH --error=fsall-slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

<<<<<<< HEAD
=======
>>>>>>> upstream/master
<<<<<<< HEAD
python -u -c "import PyHipp as pyh;import DataProcessingTools as DPT;lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1); lfall.save();hfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, loadHighPass=True,pointsPerWindow=3000, saveLevel=1); hfall.save();"
=======
python -u -c "import PyHipp as pyh; import DataProcessingTools as DPT; lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1); lfall.save(); hfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, loadHighPass=True, pointsPerWindow=3000, saveLevel=1); hfall.save();"
>>>>>>> upstream/master
