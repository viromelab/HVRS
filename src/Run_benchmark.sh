#!/bin/bash
#
./Installation.sh --all
./Simulation.sh
./Reconstruction.sh --all
./Evaluation.sh
./Plots.sh
./Cleaning.sh
#
