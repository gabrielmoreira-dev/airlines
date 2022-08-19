# Airlines

This is a simple app created to demonstrate the Clean Swift Architecture application in a iOS project. 


## Clean Swift Architecture (VIP)

The Clean Swift is an architectural pattern based on Uncle Bob's Clean Architecture. It's commonly used in robust long-running applications, as the SOLID principles of clean architecture provide code for great maintainability and scalability.

Clean Swift is based on the VIP cycle, which consists of a one-way cycle consisting of three elements:

* **ViewController:** Responsible for displaying information on the screen and listening for user events;

* **Interactor:** Responsible for all data processing and business logic of the scene, being able to rely on auxiliary components called Services or Workers that are responsible for making HTTP calls;

* **Presenter:** Responsible for formatting the models sent by the Interactor in order to facilitate their display on the screen.

<img src="https://user-images.githubusercontent.com/52149023/185693201-09717453-0f19-4d45-a18f-1793fad8482e.png" width=500 />

In this cycle, information flows in a unidirectional way. Thus, when the ViewController requests an action from the Interactor, it obtains and processes the necessary data according to the application's business rules and sends it to Presenter. Presenter, in turn, formats the received data and sends it to the ViewController, which will be responsible for displaying the data on the user screen.


## References

[Clean Swift Oficial Website](https://clean-swift.com/)

[Introducing Clean Swift Architecture](https://medium.com/hackernoon/introducing-clean-swift-architecture-vip-770a639ad7bf)

[Coordinators Essential Tutorial](https://medium.com/blacklane-engineering/coordinators-essential-tutorial-part-i-376c836e9ba7)
