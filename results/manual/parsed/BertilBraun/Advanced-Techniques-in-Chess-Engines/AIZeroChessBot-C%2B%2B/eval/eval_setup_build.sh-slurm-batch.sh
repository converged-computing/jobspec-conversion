#!/bin/bash
#SBATCH --job-name=setup
#SBATCH --output=setup_%j.txt
#SBATCH --error=setup_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=100000
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module restore chess
mkdir -p models
if [ ! -f "models/stockfish_8_x64" ]; then
    echo "Downloading stockfish model..."
    wget -O models/stockfish.zip https://drive.usercontent.google.com/u/0/uc?id=1hhuy4O9grrqaL92hbFboMrwFnCZXNheq\&export=download
    unzip models/stockfish.zip -d models
    mv models/stockfish-8-linux/Linux/stockfish_8_x64 models/stockfish_8_x64
    rm -rf models/stockfish-8-linux
    rm models/stockfish.zip
else
    echo "Stockfish model already downloaded."
fi
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES ..
cmake --build . --config Release
cp EvalAIZeroChessBot ../EvalAIZeroChessBot
cd ..
echo "Setup completed."
