SuccessFramework
================

Success framework is clean, flexible and powerful framework for building bigger apps. Powered with best practices, OOP design principles and lessons learned.

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

10. You understand both composition and extension has a place in this world. And you like to be able to have common functionality for you all viewControllers and models therefore you are comfortable by extending BaseViewController or similar for all of your viewController, and BaseModel for your models. You understand you could try to workaround that with composition, categories or other, however you understand that very granular composition solutions overcomplicate the code and require more time for newcomer devs.

##New project generation from templates intructions

SuccessFramework consists of generator, predefined templates and template configuration files. So, when you need quickly to start a new project, you create a copy of existing configuration file, rename it, change values inside it and call generator script. Then you grab generated project from "Projects" and start happy coding :)

##Examples

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
