# NumberGenerator
This repo shows a UIViewController presenting a way to generate and count random numbers. 

There are some helpers located in the Helper file. It contains:
- Label: This is a generic label so that I can init Labels in one line
- Button: This is a generic label so that I can init Labels in one line
- Present Alert: This is just a simple extension on UIViewController that alloes me to present an alert in one line. 

The API call is broken out into the ViewController -> API Interactor -> API Repo.
This allows for compartmentalizing of our API code.

The API is called on the generator button press. The data is returned from a delegate in the API Interactor.
If the API fails, the app will generate a number locally.

<p align="center">
	<a href=""><img src="https://github.com/StevenWorrall/NumberGenerator/blob/main/RandomNumberGeneratorDemo.gif" height=400px width=auto ></a>
</p>
