+ a: Int b: Int -> Int = builtin_add a b
- a: Int b: Int -> Int = builtin_sub a b
+ a: String b: String -> String = builtin_concat a b
equals a: Int b: Int -> Bool =
  % builtin_compare a b
    Less: False
    Equal: True
    Greater: False

Bool =
  |
    True
    False
not bool: Bool -> Bool =
  % bool
    True: False
    False: True

Maybe t =
  |
    Some t
    None
unwrap maybe: (Maybe t) -> t =
  % maybe
    Some t: t
    None: builtin_crash "Called unwrap on None"

List t =
  |
    Empty
    More t (List t)
list a: t -> (List t) = More a Empty
list a: t b: t -> (List t) =
  More
    a
    list b
list a: t b: t c: t -> (List t) =
  More
    a
    list b c
len list: (List t) -> Int =
  % list
    Empty: 0
    More item rest:
      +
        len rest
        1
is_empty list: (List t) -> Bool =
  equals
    len list
    0
get_maybe list: (List t) index: Int -> (Maybe t) =
  % list
    Empty: None
    More item rest:
      % equals index 0
        True: Some item
        False:
          get_maybe
            rest
            - index 1
get list: (List t) index: Int -> t =
  unwrap
    get_maybe list index

main a: Int -> Int =
  list =
    % equals 0 0
      True: list True True True
      False: list False False
  len list
