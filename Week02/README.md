![Front Banner](Documentation/FrontBanner.png)

<br />

### What did you decide to use for the model and why... Struct or Class?

Both classes and structures are like blueprints. We lay out all properties and methods that we will use to initialize an actual object once we run our app.

In this example I decided to use a **struct**.
Classes are passed by reference and if I create another object of the same class, that object would essentially point to the same instance. If that object gets destroyed, all of the copies get destroyed.

If I decided to add another feature to the game, for example - more game levels, I could easily do it because when a struct initializes an object it creates a separate object with separate values. Therefore, my separate game objects will always be updated with the right and corresponding values. I can keep all the different level's data separate. It is less prone to errors.

I initially created a class. However, I decided to use a struct. It is also an Apple's recommened way of storing data and modeling behaviour. 

In this simple example, there might not be a wrong answer. Both class and struct would work the same.

## Concepts learned

<p align="center">
<img src="Documentation/Week02Concepts.png">
</p>

<br />
   
![End Banner](Documentation/EndBanner.png)
