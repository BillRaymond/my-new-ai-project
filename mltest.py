import tensorflow as tf
import numpy as np
from tensorflow import keras

### This model model will accept X and Y coordinates
#   When we submit a new X value, the model
#   will precict the probably of the Y value

# Create a model
model = tf.keras.Sequential([keras.layers.Dense(units=1, input_shape=[1])])
model.compile(optimizer='sgd', loss='mean_squared_error')

# Define X and Y training data
xs = np.array([-1.0, 0.0, 1.0, 2.0, 3.0, 4.0], dtype=float)
ys = np.array([-2.0, 1.0, 4.0, 7.0, 10.0, 13.0], dtype=float)

# Define the model
model.fit(xs, ys, epochs=500)

# Use the model to predict the 
# value of Y based on an X input (10)
prediction = model.predict([10.0])
print("Prediction: ", prediction)
