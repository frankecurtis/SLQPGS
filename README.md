SLQPGS
======

This is SLQPGS version 1.3.  If you encounter any significant bugs, then please contact [Frank E. Curtis](mailto:frank.e.curtis@gmail.com).

Overview
--------

SLQPGS (Sequential Linear or Quadratic Programming with Gradient Sampling) is a prototype code for nonconvex, nonsmooth constrained optimization. The search direction computation is performed by minimizing a local linear or quadratic model of the objective subject to a linearization of the constraints. Gradients for each problem function are sampled to make the search direction computation effective in nonsmooth regions. The user has the option of choosing between SLP-GS or SQP-GS modes, and has the option of tuning various input parameters for each application. The code for a sample problem is provided in order to illustrate how other problems can be formulated and solved with the code.

The code is written in Matlab and released under the MIT License.

Citing SLQPGS
-------------

SLQPGS is provided free of charge so that it might be useful to others.  Please send e-mail to [Frank E. Curtis](mailto:frank.e.curtis@gmail.com) with success stories or other feedback.  If you use SLQPGS in your research, then please cite the following paper:

- Frank E. Curtis and Michael L. Overton. "A Sequential Quadratic Programming Algorithm for Nonconvex, Nonsmooth Constrained Optimization." SIAM Journal on Optimization, 22(2):474–500, 2012.