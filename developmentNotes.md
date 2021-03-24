# Munro Library Challenge

## Rough Todos

1. Create a package project
2. Create a data store component
    1. Protocol based
    2. Have an instance which loads from the CSV file
    3. Write a stub for one which can receive JSON?
    4. Contains a set of Munro objects
3. Package project should expose some interfaces 
    1. loadData(_ fileLocation: String?) throws -> ()
    2. performQuery(_ query: QUERY_TYPE) -> []
4. We will need a query object with these fields
    1. Category (Munro, Monro Top, Either)
    2. Sorting
        1. Order (ascending, descending) [default: descending]
        2. PropertyToSortBy(height, name) [default: name]
        3. Additional property: .nestedSort([SortableProperty])
            1. Needs to be an additional indirect case of the enum
            2. Function should loop through the properties passed in
            3. If there is a pervious property, identify array slices which contain identical according to the last property and sequential.
            4. If there is not, take the whole array as a slice
            5. Sort the slices independently using the current property
    3. HeightRange
        1. Min: Float [default: 0]
        2. Max: Float [default: .greatestFiniteMagnitude]
        3. Note that a height range must be initialised with a greater max than min.
5. We need a Munro data type for getting it back
    1. Could include number of excluded or filtered instances.
6. Make a dummy app to embed the framework in.
    1. App should launch and display the result of a simple query.
    
## Dangers

Any issues. Memory management- not designing Rome here, let’s assume the data set can fit in memory? Where should the logic go? Well you have two parts, the data store which is private, and the query engine, which could be static and accept a store instance.

## Reaching for perfection

You could genericise the store and query tools, the store side would be easy, the query tools not so much. You’d need a concept of table headers, and generic functions across columns. The tool I’ve built lacks that dimension. One could approach it pretty easily with a service engine, hard to test though, maybe with TDD? Ok so, you have protocol conformance for columns, and you receive a set of functions specifications from an enum relative to column indexes. To run the function the query engine must check the columns specified conform to the protocol requirements of the function’s arguments, and throw an error if the conditions aren’t met. You proceed sequentially over functions until you produce your result. There’s an elegant way I’m sure of doing this with combine.
