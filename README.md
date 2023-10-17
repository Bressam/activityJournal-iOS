## Activity Journal
This project is an study and application of Uncle Bob's clean code.
The project also uses cutting edge iOS development features, such as newest features of SwiftUI and SwiftData as database.

## Design Patterns
 - Singleton: Used on factories, so only one factory of each type exists;
 - Factory: Used to create services. Therefore the service creation is centered into a single function and can be easily adjusted. Also provides simple implementation of mocked services;
 - Dependecy injection: Used to improve testability and simplify responsabilities, so mocked values can be injected and classes don't need to know how others are created or their dependencies.
 - Dependency inversion: A service layer for dataProviders is created to each service, and classes using the service only receive the protocol. This improves the possibilities of injecting different services, and also classes only need to know the protocol defined, not each service detail.
