#!/bin/bash
#FLUX: --job-name=dirty-toaster-8010
#FLUX: -t=3600
#FLUX: --urgency=16

<<<<<<< HEAD
=======
>>>>>>> upstream/master
<<<<<<< HEAD
python -u -c "import PyHipp as pyh;import DataProcessingTools as DPT;lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1); lfall.save();hfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, loadHighPass=True,pointsPerWindow=3000, saveLevel=1); hfall.save();"
=======
python -u -c "import PyHipp as pyh; import DataProcessingTools as DPT; lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1); lfall.save(); hfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, loadHighPass=True, pointsPerWindow=3000, saveLevel=1); hfall.save();"
>>>>>>> upstream/master
