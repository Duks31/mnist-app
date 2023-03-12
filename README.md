# mnist-app
![8 test photo](https://github.com/Duks31/mnist-app/blob/master/test_photos/eight.png)

<h2> Desription </h2>

<h4> MNIST overview </h4>

[MNIST](https://en.wikipedia.org/wiki/MNIST_database) is a classic machine learning dataset that is often referred to as the "Hello World" of machine learning. It consists of a large set of handwritten digits, which are labeled with their corresponding numerical values.

The goal of machine learning models trained on the MNIST dataset is to correctly classify each digit image into its corresponding numerical value (0-9). This is a classification task, and various machine learning algorithms and techniques can be used to accomplish this.

<h4> Classifying MNIST Digits with Neural Networks </h4>

One popular approach to solving the MNIST classification task is by using neural networks. Neural networks are a type of machine learning algorithm that are modeled after the structure of the human brain. They consist of interconnected layers of artificial neurons, which can be trained to learn patterns in the input data.
 
In the case of the MNIST dataset, neural networks can be used to learn the features of the handwritten digits and to classify them into their corresponding numerical values. This is done by feeding the pixel values of each digit image into the neural network as input, and then using the output of the network to predict the digit value.

Neural networks can be trained using a variety of techniques, such as backpropagation, stochastic gradient descent, and convolutional neural networks (CNNs). CNNs, in particular, have been found to be highly effective for image classification tasks like MNIST.

<h4> Integrating MNIST Model into a Flutter App for Digit Recognition </h4>

After training a neural network on the MNIST dataset, the resulting model can be used for a variety of tasks. One such task might be to classify new images of handwritten digits. Another task might be to integrate the model into a larger application, such as a mobile app.

In my case, I used the trained MNIST model to create a mobile app using the Flutter framework. The app allows users to draw their own handwritten digits on the screen, and then uses the trained model to classify the digit and display the result.

This integration of the MNIST model into a Flutter app is a great example of how machine learning can be used to enhance the functionality of real-world applications. By leveraging the power of neural networks and the flexibility of Flutter, it was possible to create a unique and engaging user experience that wouldn't have been possible with traditional programming techniques alone.


<h2> Features </h2>

The app I created using the trained MNIST model has a key feature, it allows users to draw their own handwritten digits on the screen using their finger or a stylus. The app then uses the trained model to classify the digit and display the predicted numerical value on the screen.

<h2> Installation </h2>

[click to download minstapp](https://github.com/Duks31/mnist-app/raw/master/mnist_app/apk/app-release.apk)

Please note that the app I created using the MNIST model is currently only supported on Android devices. If you have an iOS device, I apologize for the inconvenience and encourage you to explore alternative apps or solutions for digit recognition.

when installing the apk into your mobile you bypass all the check that are given by google play protect and allow install.

<h2>Bugs and Model Accuracy</>
I am certainly aware that the app has some bugs (eg when drawing some numbers), also the model accuracy is not so high, so there may be times where what you draw isnt what is being predicted.

<h2> Acknowledgement </h2>

This project inspired by [Aladdin Persson](https://github.com/aladdinpersson) in his [video](https://www.youtube.com/watch?v=Yla6MqEePh8)

