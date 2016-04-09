# Deep Neural Networks #

![2_layer_neural_net](2_layer_neural_net.png)  
Depicted above is a "2-layer" neural network:
- The first layer effectively consists of the set of weights and biases applied to X and passed through __ReLUs__ (rectified linear units). The output of this layer is fed to the next one, but is not observable outside the network, hence it is known as a __hidden layer__.
- The second layer consists of the weights and biases applied to these intermediate outputs, followed by the softmax function to generate probabilities.

