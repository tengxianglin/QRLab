# Software Description

## Product identity

QRLab is a MATLAB software package for quantum resource-theory computation and simulation. It targets research prototyping, algorithm benchmarking, and educational demonstrations.

## Functional modules

1. **Entanglement module**
   - Static measures (for example logarithmic negativity and related variants).
   - Dynamic/channel-oriented metrics and capacity utilities.

2. **Coherence module**
   - Coherence quantification and channel simulation routines.

3. **Magic module**
   - Qubit and qudit magic measures.
   - Utility assets for stabilizer and channel-magic computations.

4. **Quasi-theory module**
   - Probabilistic and deterministic error-mitigation components.
   - Decomposition and virtual-recovery methods.

5. **Supermap module**
   - Higher-order channel transformations including quantum switch and link product.

6. **Utility module**
   - Shared matrix/state helper functions.

## Algorithmic characteristics

- Linear-algebraic manipulation of density matrices and Choi matrices.
- Convex optimization-based routines via CVX for selected measures.
- Tensor, permutation, partial-trace, and partial-transpose operations via QETLAB integration.

## Inputs and outputs

- Inputs are numeric matrices representing states/channels and dimension vectors.
- Outputs are scalar measures, transformed channels/states, and structured results from dispatcher utilities.

## Execution environment

- MATLAB desktop workflow.
- External dependencies: QETLAB and CVX for full functionality.

## Productization enhancements in this update

- Standardized help and validation in selected public APIs.
- Added test harness and runnable examples.
- Added user/developer documentation and formal changelog.
