# MunroQueryEngine

This is a simple package designed to let you query formatted Munro CSV files.



## Getting Started
To use this package, import it into your project. You can use this repo as the package URL, choose branch `main` to load from. See [apple docs](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).


## Load Data

Make an instance of a `MunroQueryEngineController`
You can pre-load any data you like by passing in a URL to the file with `.loadCsvData(from url: URL?)`
*Note, the URL is optional, and can be ignored. This will result in the default Munro dataset being loaded.*
*Note, CSV's must be properly formatted to be decoded, please see the example CSV files in this project if you need a guide*

## Run a Query
To execute a query, use `makeQuery(_ query: MunroQuery)`
This function accepts a self-documenting MunroQuery object, have a look at it to see what kind of queries you can run.

*Note, if you have not previously loaded data, the default dataset will be loaded*
*Note, if you do not specify a sorting, no order is guaranteed.*
*Note, not all munro properties are loaded, you can use the running number property to link your query results to the larger munro databases.*

## Example
Switch to the branch `appDemo` and run the demoApp to the library being used.

```
import MunroQueryEngine
...

let munroQueryController = MunroQueryEngineController()
do {
    let query = try MunroQuery()
    print(munroQueryController.makeQuery(query))
} catch {
    print(error)
}
```

