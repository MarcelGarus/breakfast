# The Breakfast Programming Language

> This is a work in progress.
> This readme is aspirational, many things don't work yet.

Breakfast is a programming language for writing functional, fast, and reusable code.

**Functional**:
Functions don't have side effects.
They are eagerly evaluated.
All data is acyclic.

**Fast**:
All types are known at compile time.
Data has an efficient memory layout.
Garbage collection works using reference counting.

**Reusable**:
You can write generic code that inspects types at compile time.
This means you don't need macros.

## Features

Breakfast has structural typing.
Types are always uppercase, type variables are lowercase.
`|` defines enums, `&` defines structs.

```breakfast
Json =
  | Int Int
    Map (Map String Json)
    ...
Map key value =
  & entries: Slice (MapEntry key value)
    size: Int
MapEntry key value =
  | Empty
    Filled key value
```

Functions have type annotations.
You can always figure out the return type of a function just by looking at the signature.
Breakfast allows overloading based on the parameter types.

```breakfast
+ a: Int b: Int -> Int = builtins.add a b

size_of type: Type -> Int =
  % type_info type
    Int: 8
    Struct field: ...
    Enum: ...
    ...

get map: (Map k v) key: k -> Maybe v = ...

parse json: Json target: Type -> target = ...
```

## TODO

- think of file ending (.bf?)
