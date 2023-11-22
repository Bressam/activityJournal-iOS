# Activity Journal - iOS
This project is an study and application of Uncle Bob's clean code.
The project also uses **cutting edge iOS development** features, such as newest features of **SwiftUI** and **iOS 17**. Also uses **SwiftData** as database, presented on WWDC 2023 and only available to iOS 17.

### iOS Demo & Color theme
| iOS Demo  |
|:-------------:|
| <img width=260px src="https://github.com/Bressam/ActivityJournal-iOS/blob/main/SampleResources/demo.gif"> |

| Color Theme | Empty Data |
|:-------------:|:-------------:|
| <img width=260px src="https://github.com/Bressam/ActivityJournal-iOS/blob/main/SampleResources/theme-responsiveness-demo.gif"> | <img width=260px src="https://github.com/Bressam/ActivityJournal-iOS/blob/main/SampleResources/emptyData-demo.gif">|

### Symbol animations
iOS 17 brings a new possibility: Symbol effects! Many system icon's images have multiple layer animations. At this project I used 2 different type of animations:
 - **Indefinite**: This kind of animation allows to keep it on loop until called to stop. It was used at the empty data view.
 - **Discrete**: Animates everytime a value changes. This animation was used at the "add activity" icon, at the Navigation Bar's button.


| Indefinite | Discrete |
|:-------------:|:-------------:|
| <img width=260px src="https://github.com/Bressam/ActivityJournal-iOS/blob/main/SampleResources/symbol1-demo.gif"> | <img width=260px src="https://github.com/Bressam/ActivityJournal-iOS/blob/main/SampleResources/symbol2-demo.gif">|

## Design Patterns
 - Singleton: Used on factories, so only one factory of each type exists;
 - Factory: Used to create services. Therefore the service creation is centered into a single function and can be easily adjusted. Also provides simple implementation of mocked services;
 - Dependecy injection: Used to improve testability and simplify responsabilities, so mocked values can be injected and classes don't need to know how others are created or their dependencies.
 - Dependency inversion: A service layer for dataProviders is created to each service, and classes using the service only receive the protocol. This improves the possibilities of injecting different services, and also classes only need to know the protocol defined, not each service detail.
 
## Git Flow
The project follow the best practices on git flow. Bellow is a brief description of all branches used:
 - **main**: Release branch, represents all store releases;
 - **development**: Development branch, where all features branches starts from and usually the newest and most stable code;
 - **FEATURE/{featureName}**: The "FEATURE folder" wraps all feature branches. A feature branch will start from development, ex.: FEATURE/home. And all the feature work will be done at the feature branch until it is ready to be merged on development branch.
 - **hotfix**: Hotfix branch is used to fix major updates on release build (latest version on main branch). This is important to be able to fix a major issue on release branch without carrying all the new development branch that store unstable, and usually not validated yet, features.

The project also uses Git Tags to mark important release milestones.

### Project Git Flow image:
<img width=1909px src="https://github.com/Bressam/ActivityJournal-iOS/blob/main/SampleResources/activityJournal-gitflow.png">
