# ADC-WW3-Coupling-Dev
This repository stores code or analysis scripts for the ADC-WW3 project I am working on.
The coupling between ADCIRC and WW3 is done with the Earth System Modeling Framework (ESMF) with NUOPC layer.
The coupling is developed by NOAA COASTAL ACT group. (NEMS)

## Structure of this repository:
### Source Codes 
The source codes come from the a forked repository. (I am not sure if I can upload the source code to this repository.

### Benchmark Case
In this folder, I will provide the setup for the ADCIRC model and the input field as in the storm surge paper that I have been working on.

The benchmark case comes from previous thesis work on the storm surge.
### Test Cases:
provide a descriptions on each test case:
Two types of testcases:
 1. ww3data: a fictious wave model, where prescribed sea-state dependent wind stress is prescribed and provided for use (same as the wind stress used in the benchmark case). In this case, the mesh is unstructured grid and it is identical to the ADCIRC mesh;
 
 2. ww3: the real wave model, where sea-state dependent wind stress will be computed and passed to the ADCIRC model. In this case, the mesh for wind and wave model will be cartesian and conversion will happen using the ESMF conversion function. Another question is that can the WW3 model and the ADCIRC model have different mesh coverage?
 

### Analysis scripts - matlab
#### comparison between test case and benchmark case.
NCCMP - a function to compare netCDF file is used to quickly compare the netCDF files bit-by-bit;
PlotDif - a function to compare netCDF file by doing difference and plot it out. 
Ideally, there should be no difference between scripts;

#### visualization scripts
visualize the wind forcing field and compare it what I used in the benchmark case;
visualize the output field (surface elevation and velocity); 



 
 


