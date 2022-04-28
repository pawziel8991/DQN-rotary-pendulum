Open the file 'dzialanie_1.m'.
The dzialanie_1 file allows full configuration of the learning, simulation and pendulum model parameters, unless otherwise noted in particular places.
In line 10 we have a choice:
either create a network from scratch and teach it according to a given scoring criterion
or use one of the networks saved as a .mat file stored in a file named 'savedAgents'.

Next in the script are defined the physical parameters of the pendulum and the value of the moment of force of a single action.
The moments of inertia of the arms are calculated automatically from the formulas defined in the script.
In the simulation parameters it is important to set a point criterion for the end of training (-150 should meet the requirements for correct control, you can always give more e.g. -120 to maximize performance)

Start the program by clicking 'Run'.

Simulink should open with a pendulum visualization window and an oscilloscope window
A window with graphs of the current learning progress of the network is also displayed 

The visualization runs in real time, so the graphs and the entire learning process also runs in real time.
This is convenient to monitor the progress of the pendulum in real time.

When we care about fast learning of the network and the final result we close the visualization and oscilloscope windows. Then the learning process lasts several minutes.

When the learning process is finished and we want to see the effect in the visualization, we have to open the 'VR Sink' block in the Simulation block diagram.
If you want to analyze simultaneously the graphs of angles and angular velocities of the arm 2, interference and selected actions by the controller, click the 'Scope' block
In the upper right corner of the 'Scope' window there is a legend and by pressing the description in the legend you can display only those signals which you are currently interested in.

Then click 'Run' on the 'Simulation' tab of the Simulink window and observe the operation of the learned network

Networks are stored in the workspace inside the Agent class (a), under the names nn(Q-network) and nn_target(target-network). They contain the coefficient values of the learned weights

In case you don't understand something, the comments in the script should clarify most of it