
Differential Equations
- order: highest derivative
- system: number of equations 
- explicit: highest derivative occurs by itself
- linear: power of function we are looking for is linear

__Order__ of a solver: Error ~ c.h^order

Heun's method
- improved euler method
- embedded runge-kutta method
- take average of euler prediction and present value to estimate next value
- remarkable improvement, but have to call function twice
- adaptive step size based on local truncation error

Long term error 
- system behaviour over large times
- we can look at the energy term to see what the long term behaviour is

Phase Space
- solvers that conserve area in the phase space are pretty good at conserving energy
- area preserving property
- solvers have area preserving properties are called __symplectic__ or geometirc integrators
- example: simple pendulum phase - this will take the area in the phase space to zero becasue we know the motion dies out
- can modify euler method to become symplectic in some cases

Uses of models and simulations
- experiments that can't be done in real life
- prediction
- optimization
- study causes and effects
- determine unobservable quantities
