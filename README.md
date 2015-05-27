SuccessFramework
================

Success framework is clean, flexible and powerful framework for building bigger apps. Powered with best practices, OOP design principles and lessons learned.

[Terms and conditions :) ](##terms and conditions)

[New project generation from template intructions](##New project generation from templates intructions)

[New project generation example](##Examples)

[BusinessApp template features](##BusinessApp template features)

##terms and conditions

In order to be comfortable with the framework you need agree to terms and conditions:

1. You are not a rockstar or a ninja. You are able to implement complex algorithms and logic, but know that 90% of being a good programmer is simply writing readable and maintainable code which will be used by others. 

2.  You like to abstract common functionality and components into reusable facade-type solutions. You like solving challenging technical problems with simple and elegant solutions. You always try to encapsulate into black box as much as possible and create KISS interface when creating component which will be used in other part of the app. You hate code duplication. 

3. You are looking for a solution to build bigger app which will be developed by your current or future iOS team. You always try to avoid unnecessary merge conflicts by designing you app in a way your work won’t overlap with a work by other developer. 

4. You like MVC and want to comply to it by having a separate view, controller and model stored inside separate files (Xibs over Storyboards)

5. You try to build consistent UI and always try to define a finite set of colors, fonts and other UI attributes. Therefore you use configuration files with predefined settings and values which are used across the app and which could be changed easily later (User-defined runtime attributes, fonts, colors and other settings)

6. You like writing testable code therefore you promote Dependency injection. But you don’t like magic and hacks therefore you prefer to use simple solution for implementing Dependency injection on your own, so you could understand and change it easily later if needed (ViewControllerFactory)

7. You like building universal apps but you also want to have as elegant solution as possible for implementing conditional logic for your iPhone and iPad. Therefore you want you code would be smart enough to auto pick correct classes (MyViewControlller_iphone, MyViewControlller_ipad) during runtime.

8. You understand your MVC needs one more part - data objects which are like containers for storing your custom object with its properties. You hate using plain dictionaries across the app with hardcoded keys. And you like when these custom objects are able to parse and create themselves from json.

9. You don’t overuse categories and definitely are not using them as substitutes for subclassing. Therefore you use them as little helpers by adding small but reused methods to native UIKit classes.

10. You understand both composition and inheritance have a place in this world. And you like to be able to have common functionality for you all viewControllers and models, therefore you are comfortable by extending BaseViewController or similar for all of your viewControllers, and BaseModel for your models. You understand you could try to workaround that with composition, categories or other, however you understand that very granular composition solutions overcomplicate the code and require more time for newcomer devs.

##New project generation from template intructions

SuccessFramework consists of generator, predefined templates and template configuration files. So, when you need quickly to start a new project, you create a copy of existing configuration file, rename it, change values inside it and call generator script. Then you grab generated project from "Projects" and start happy coding :)

##New project generation example

Currently, there is only one template which is targeted for business type of apps. To generate a project from this template you need to open "var_BusinessApp_" template configuration file and put the names:

```
_AuthorName_=Gytenis Mikulenas
_MyCompanyName_=AppUnited
_BusinessApp_=DemoApp
```

Then open Terminal in SuccessFramework folder and perform the command with template name parameters:

```
. generate.sh "_BusinessApp_" -d
```

PS: -d will clean the contents of "Projects" folder.

##BusinessApp template features

1. Highly modular and clean project structure

2. Universal app for both iPhone and iPad devices

3. Base functionality for any UIKit+BackendAPI based app (CoreViewController, BaseViewController, BaseDetailsViewController, BaseWebViewController, BaseModel, ..)

4. Model and data object separation for separating concerns between business logic (models) and data containers (data objects)

5. Ready to go for TDD architecture with dependency injection for viewControllers and their models

6. Common shared functionality facade type components (Manager):**UserManager** (encapsulates login, signUp, logout, resetPassword and other related functionality, and allow observer to subscribe for status change callbacks), **MessageBarManager** (for showing animated nice short messages on top of the screen), **CrashManager** (for encapsulating crash reporting related logic), **SettingsManager** (for encapsulating business logic when working NSUserDefaults or any other simple data storage), **ReachabilityManager** (for encapsulating network status logic and allow observer to subscribe for status change callbacks), **AnalyticsManager** (for encapsulating Google Analytics or other reporting service related logic).

7. API clients and operation style classes for communicating with backend

8. Colors, fonts and styles are managed and configured via single Constants configuration files

9. Simple UI components for cross app UI consistency (NormalLabel, NormalButton, NormalTextField, PasswordTextField)

10. Custom and cross app consistent navigation bar (TopNavigationBar) 

11. Custom font support

12. Development, Stage and Production network switch support via DEBUG and 
ConstNetworkConfig.h

13. Console logger view (Magento Log button on navigation bar)

14. Network environment switch for debug (Green Env button on navigation bar)

15. Language change support during runtime via Settings screen

16. Demo form screen (ScrollViewExample) with input fields and validation

17. Demo list screen (Home, TableViewExample)

18. Nice and handy date, view and other helpers methods via categories.

