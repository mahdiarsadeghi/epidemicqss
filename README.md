# Quasi-steady-state epidemic fitting

MATLAB code for fitting a quasi-steady-state epidemic model to reported COVID-19 cases. The model and analysis accompany “Long-term regulation of prolonged epidemic outbreaks in large populations via adaptive control: a singular perturbation approach” by Muhammad Ali Al-Radhawi, Mahdiar Sadeghi, and Eduardo Sontag.

## Repository map

- `main.m` runs example fits for selected US states and countries.
- `bin/` contains the model and fitting functions.
- `US.csv` and `data.csv` contain the input case data used by the examples.
- `results/` contains generated plots from previous runs.

## Run locally

Open MATLAB or GNU Octave, add `bin/` to the path, set the working directory to the repository root, and run:

~~~matlab
main
~~~

The script prints fitted parameters and writes plots under `results/`. The input files are historical research data; check their provenance and date before extending the analysis.

## Citation

If you use this code, cite the paper named above and describe any changes to the fitting procedure or input data.
