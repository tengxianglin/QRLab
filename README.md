# QRLab

**QRLab** is a MATLAB toolbox for exploring quantum information processing and quantum resource theory.


## Features
- **Entanglement Theory**: 

    - *Static Entanglement Measure*: Tempered Logarithmic Negativity $E_{
\mathrm{\tau}}$, Rains Bound $R$, MaxRainsEntropy $R_{
\mathrm{max}}$, Logarithmic Negativity $E_\text{N}$, $E_{
\mathrm{PPT}}$, $E_
\mathrm{eta}$

    - *Dynamic Entanglement Measure*: Max Logarithmic Negativity, Max Rains information

    - *Quantum Capacity*

- **Coherence Theory**: 

    - *Static Coherence Measure*: Robustness of Coherence

    - *Channel Simulation*: Simulating non-free operations via resource states

- **Magic Theory**: 

    - *Static Magic Measure*: Robustness of Magic (qubit), Magic Mana (qudit), max/min Thuama (qudit) 

    - *Representative Magic State Generation*


- **Quasi-Theory**: 

    - Probabilistic error cancelation 

    - Observable dependent probabilistic error cancellation 

    - Observable dependent deterministic error cancelation 

    - Circuit Knitting 

    - Virtual Recovery

- **Supermap**: 
    - Quantum Switch (both kraus and choi), Apply Quantum Switch
    - Link Product

- **Seesaw Algorithms**: Algorithms for providing sub-optimal solutions for non-linear optimization problems. 

    - CHSH game 

    - LOCC protocol

- **Extra Functions**: 

    - Conditional quantum mutual information 

API reference: https://quairkit.com/QRLab

## Requirements
- MATLAB (desktop)
- QETLAB == 0.9
- CVX == 2.1

## Installation
1. Clone QRLab to your local machine.
2. Download QETLAB 0.9: https://qetlab.com/
3. Add QRLab and QETLAB to the MATLAB path:
```matlab
addpath(genpath('...\QETLAB-0.9'));
addpath(genpath('...\QRLab'));
savepath; % optional: persist paths
```
4. Install CVX 2.1: https://cvxr.com/cvx/
- Windows:
```matlab
cd yourpath\cvx;
cvx_setup;
```
- Linux/macOS:
```matlab
cd ~/MATLAB/cvx;
cvx_setup;
```
5. (Optional) For full magic qubit functionality, install channel_magic 2.0:
- https://github.com/jamesrseddon/channel_magic

## Quick Start
Verify your setup with a simple entanglement calculation:
```matlab
% Create a 2-qubit maximally entangled state (Bell state)
rho = MaxEntangled(2) * MaxEntangled(2)'; % from QETLAB
LN = LogNeg(rho);                          % from QRLab
disp('Logarithmic Negativity (expected ~1 for Bell state):');
disp(LN);
```
If LN prints a value close to 1, QRLab and dependencies are working.

## Usage and Examples
- Function help in MATLAB:
```matlab
help LogNeg
```
- Explore additional functions via the API docs: https://quairkit.com/QRLab
- Many features (entanglement, coherence, magic, quasi-theory, supermaps, seesaw) follow a consistent functional interface; see the documentation for arguments, options, and examples.

## Troubleshooting
- Paths not set or missing functions:
  - Ensure both QRLab and QETLAB are on the MATLAB path:
  ```matlab
  addpath(genpath('...\QETLAB-0.9'));
  addpath(genpath('...\QRLab'));
  which LogNeg -all
  which MaxEntangled -all
  ```
- CVX not initialized:
  - Run cvx_setup and ensure no errors are reported.
- Version mismatches:
  - Confirm QETLAB == 0.9 and CVX == 2.1 specifically.
- Magic functions unavailable:
  - Install channel_magic 2.0 and add it to the MATLAB path if you need qubit magic tools.

If issues persist, compare your steps with Installation and Quick Start, then consult the API docs.

## Contributing
Contributions to expand and improve QRLab are welcome. Typical flow:
- Open an issue describing a bug/feature.
- Fork the repository, create a feature branch, and submit a pull request.
- Add concise tests/examples where appropriate.

## Acknowledgements
We acknowledge the CVXQUAD package (https://github.com/hfawzi/cvxquad) for MATLAB-based convex optimization utilities including von Neumann entropy and quantum relative entropy, which have been valuable in this research.
