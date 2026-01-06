# Optimizing-urban-bike-sharing-systems-a-stochastic-mathematical-model
Ahmadi, S. A., Ghasemi, P., &amp; Ehmke, J. F. (2024). Optimizing urban bike-sharing systems: a stochastic mathematical model for infrastructure planning. Central European Journal of Operations Research, 1-35.

**Overview**

- This repository provides a small-scale validation implementation of a stochastic mathematical optimization model for bike-sharing station allocation and cycling network design. The model is formulated and solved in GAMS and is intended to demonstrate the structure, logic, and correctness of the proposed methodology.

- The code corresponds to the modeling framework presented in the associated journal article and allows researchers to understand and reproduce the model formulation and solution approach, independent of confidential real-world data.

**Data Privacy and Confidentiality**

- The original large-scale case study relies on real operational, spatial, and demand data obtained from external stakeholders and public authorities. These data are subject to privacy, contractual, and ethical restrictions and therefore cannot be shared publicly.

**To address this:**

- All numerical inputs in this repository are synthetic, scaled-down, or modified

- Station locations, demand values, costs, and network structures do not represent real systems

- The code is provided solely for validation, learning, and reproducibility

**Purpose of This Repository**

- Validate the correctness of the mathematical formulation

- Demonstrate implementation details in GAMS

- Enable other researchers to adapt the model to their own datasets

- Support transparency without violating data privacy

**Model Characteristics**

- Mixed-Integer Programming (MIP)

- Scenario-based stochastic demand

- Multi-period decision structure

- Budget-constrained infrastructure planning

- Implemented and solvable using CPLEX solver 
