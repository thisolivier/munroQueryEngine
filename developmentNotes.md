# Munro Library Challenge

## Rough Sketch

1. Lets do this TDD
2. Start with testing entities
3. Then test the store
4. Then test the query tool
5. Finally test the module
    
## Dangers

Any issues. Memory management- not designing Rome here, let’s assume the data set can fit in memory? Where should the logic go? Well you have two parts, the data store which is private, and the query engine, which could be static and accept a store instance.

## Reaching for perfection

You could genericise the store and query tools, the store side would be easy, the query tools not so much. You’d need a concept of table headers, and generic functions across columns. The tool I’ve built lacks that dimension. One could approach it pretty easily with a service engine, hard to test though, maybe with TDD? Ok so, you have protocol conformance for columns, and you receive a set of functions specifications from an enum relative to column indexes. To run the function the query engine must check the columns specified conform to the protocol requirements of the function’s arguments, and throw an error if the conditions aren’t met. You proceed sequentially over functions until you produce your result. There’s an elegant way I’m sure of doing this with combine.
