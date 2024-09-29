# The Breakfast Programming Language

Breakfast is a programming language for writing functional, fast, reusable code.

**Functional**:
Functions can't have side effects. Data is immutable and acyclic. Code is eagerly evaluated.

**Fast**:
Types are known at compile time. Values have an efficient memory layout.

**Reusable**:
You can write generic code. You can inspect types at compile time.

## Intro

Type names are always uppercase. Type variables are lowercase. Use `&` to create structs and `|` to create enums.

```breakfast
Json =
  | Int Int
    Map (Map String Json)
    Bool Bool

List t = & buffer: (Buffer t) len: Int
```

Function names are always lowercase or symbols. The signatures of functions have type annotations that allow you to figure out the return type without looking at the body.

```breakfast
+ a: Int b: Int = builtins.add a b
+ a: String b: String = builtins.concat a b

get list: (List t) index: Int -> t = ...
get map: (Map k v) key: k -> v = ...

parse json: Json target: Type -> target =
  % type_info target
    Int:
      % json
        Int int: int
        else: crash "Expected int, found other stuff."
    Struct fields:
      % json
        Map map:
          ...
        else: crash ...
```

## TODO

- think of file ending (.bf?)
