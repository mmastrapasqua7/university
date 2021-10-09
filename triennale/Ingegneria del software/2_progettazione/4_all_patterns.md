# Design Patterns Problems
## Creational Patterns
- Factory Method

provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.

- Abstract Factory

lets you produce families of related objects without specifying their concrete classes.

- Builder

lets you construct complex objects step by step. The pattern allows you to produce different types and representations of an object using the same construction code.

- Prototype

lets you copy existing objects without making your code dependent on their classes.

- Singleton

lets you ensure that a class has only one instance, while providing a global access point to this instance.

## Structural Patterns

- Adapter

allows objects with incompatible interfaces to collaborate.

- Bridge

lets you split a large class or a set of closely related classes into two separate hierarchies - abstraction and implementation - which can be developed independently of each other.

- Composite

lets you compose objects into tree structures and then work with these structures as if they were individual objects.

- Decorator

lets you attach new behaviors to objects by placing these objects inside special wrapper objects that contain the behaviors.

- Facade

provides a simplified interface to a library, a framework, or any other complex set of classes.

- Flyweight

lets you fit more objects into the available amount of RAM by sharing common parts of state between multiple objects instead of keeping all of the data in each object.

- Proxy

lets you provide a substitute or placeholder for another object. A proxy controls access to the original object, allowing you to perform something either before or after the request gets through to the original object.

## Behavioral Patterns

- Chain of Responsibility

lets you pass requests along a chain of handlers. Upon receiving a request, each handler decides either to process the request or to pass it to the next handler in the chain.

- Command

turns a request into a stand-alone object that contains all information about the request. This transformation lets you parameterize methods with different requests, delay or queue a request’s execution, and support undoable operations.

- Iterator

lets you traverse elements of a collection without exposing its underlying representation (list, stack, tree, etc.).

- Observer

lets you define a subscription mechanism to notify multiple objects about any events that happen to the object they’re observing.

- State

lets an object alter its behavior when its internal state changes. It appears as if the object changed its class.

- Strategy

lets you define a family of algorithms, put each of them into a separate class, and make their objects interchangeable.
