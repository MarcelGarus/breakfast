# Welcome to Breakfast!  

# Nothing (aka Unit or Void)  
# Nothing is a type with only one instance. From an information theoretical
# perspective, being given an instance of a Nothing type gives you no
# information whatsoever. The size of a Nothing instance is zero – it disappears
# at compile time! Like a ghost!
# Functions without an explicit return type return Nothing by default. Functions
# that don't have anything useful to return (such as print) return Nothing
# instead. Empty bodies return Nothing.

Nothing =
  | Nothing

#fun write[W](writer: W, nothing: Nothing) { writer."nothing" }
#fun write_debug[W](writer: W, nothing: Nothing) { writer."nothing" }
#fun ==(a: Nothing, b: Nothing): Bool { true }
equals a: Nothing b: Nothing -> Bool = True
ignore value: t -> Nothing = Nothing

# Never  
# Never is a type with zero instances. If you write a function that accepts an
# argument of Never, it can never be called (otherwise, the caller would have
# a Never instance).
# Why do we need something like this? Some expressions always abort control
# flow, for example `crash "Oh no!"`. These evaluate to the Never type. Because
# Never is never instantiated, it can be assigned to anything:
#
# some_bool = crash "Oh no!"

# Bool  
# A type with two instances.

Bool =
  | True
    False

not bool: Bool -> Bool =
  bool
  % True: False
    False: True
equals a: Bool b: Bool -> Bool =
  a
  % True: b
    False: not b
and a: Bool b: Bool -> Bool =
  a
  % True: b
    False: False
or a: Bool b: Bool -> Bool =
  a
  % True: True
    False: b
xor a: Bool b: Bool -> Bool =
  a
  % True: not b
    False: b
implies a: Bool b: Bool -> Bool =
  a
  % True: b
    False: True

# fun write[W](writer: W, b: Bool) { writer.write(if b then "true" else "false") }
# fun hash(hasher: &Hasher, value: Bool) { hasher.hash(if value then 0 else 1) }

# Comparisons  

Ordering =
  | Less
    Equal
    Greater

flip ordering: Ordering -> Ordering =
  ordering
  % Less: Greater
    Equal: Equal
    Greater: Less

# fun <[T](a: T, b: T): Bool { a <=> b is less }
# fun >[T](a: T, b: T): Bool { a <=> b is greater }
# fun >=[T](a: T, b: T): Bool { not(a <=> b is less) }
# fun <=[T](a: T, b: T): Bool { not(a <=> b is greater) }

# fun min[T](a: T, b: T): T { if a < b then a else b }
# fun max[T](a: T, b: T): T { if a > b then a else b }
# fun clamp[T](a: T, range: Range[T]): T { max(range.start, min(range.end.dec(), a)) }

# Hashing  
# You should implement a hash(&Hasher, T) function for types that can be hashed.
# In this function, they can contribute some uniqueness/entropy to the Hasher by
# calling other hash functions on it. In the end, all hash functions boil down
# to hash(&Hasher, Int). The Hasher uses the djb2 algorithm.

#Hasher =
#  | Hasher Int

#initial_hasher -> Hasher = Hasher 5381
#add hasher: Hasher value: Int -> Hasher =
#  hasher
#  % Hasher state: state | * 33 | + value | Hasher
#finish hasher: Hasher -> Int =
#  hasher
#  % Hasher state: state | * 33

#fun hash_all[I](hasher: &Hasher, iter: I) {
#  for item in iter do hasher.hash(item)
#}

# Byte  
# A value from 0 to 255. All arithmetic operations wrap around. TODO: do they?

# add a: Byte b: Byte -> Byte = builtin_add_bytes a b
# sub a: Byte b: Byte -> Byte = builtin_sub_bytes a b
# mul a: Byte b: Byte -> Byte = builtin_mul_bytes a b
# div a: Byte b: Byte -> Byte = builtin_div_bytes a b
# mod a: Byte b: Byte -> Byte = builtin_mod_bytes a b
# and a: Byte b: Byte -> Byte = builtin_and_bytes a b
# or a: Byte b: Byte -> Byte = builtin_or_bytes a b
# xor a: Byte b: Byte -> Byte = builtin_xor_bytes a b
# compare a: Byte b: Byte -> Ordering = builtin_compare_bytes a b
# to_int byte: Byte -> Int = builtin_byte_to_int byte
# equals a: Byte b: Byte -> Bool =
#   compare a b
#   % Less: False
#     Equal: True
#     Greater: False

# fun hash(hasher: &Hasher, byte: Byte)  { hasher.hash(byte.to_int()) }
# fun copy(byte: Byte) { byte }

#fun write[W](writer: W, int: Byte) { writer.write(radix(int, 10)) }
#fun radix(int: Byte, radix: Int): RadixFormat { radix(int.to_int(), radix) }
#fun digit_to_char(digit: Byte): Char {
#  if digit.to_int() > 9
#  then {digit - 10.lower_byte() + #a.byte}.to_char()
#  else {digit + #0.byte}.to_char()
#}
#fun write_debug[W](writer: W, byte: Byte) { writer."{byte}" }

# Int  
# If you write a number such as 3 in the code, it's an Int.

# var min_int = 0 - 9223372036854775806
# var max_int = 9223372036854775807

+ a: Int b: Int -> Int = builtin_add_ints a b
- a: Int b: Int -> Int = builtin_sub_ints a b
mul a: Int b: Int -> Int = builtin_mul_ints a b
div a: Int b: Int -> Int = builtin_div_ints a b
mod a: Int b: Int -> Int = builtin_mod_ints a b
and a: Int b: Int -> Int = builtin_and_ints a b
or a: Int b: Int -> Int = builtin_or_ints a b
xor a: Int b: Int -> Int = builtin_xor_ints a b
shift_left int: Int by: Int -> Int =
  by | equals 0
  % True: int
    False: int | mul 2 | shift_left (by | - 1)
shift_right int: Int by: Int -> Int =
  by | equals 0
  % True: int
    False: int | div 2 | shift_left (by | - 1)
# pow base: Int exponent: Int -> Int = pow_rec 1 base exponent
pow_rec result: Int base: Int exponent: Int -> Int =
  # TODO: do this more efficiently
  exponent | equals 0
  % True: result
    False: pow_rec (result | * base) base (exponent | - 1)
abs int: Int -> Int =
  compare int 0
  % Less: 0 | - int
    Equal: 0
    Greater: int
compare a: Int b: Int -> Ordering = builtin_compare_ints a b
round_up_to_multiple_of number: Int factor: Int -> Int =
  number | + factor | - 1 | div factor | mul factor
round_up_to_power_of number: Int factor: Int -> Int =
  round_up_to_power_of_rec 1 number factor
round_up_to_power_of_rec power: Int number: Int factor: Int -> Int =
  # TODO: do this more efficiently
  is_big_enough =
    compare power number
    % Less: False
      Equal: True
      Greater: True
  is_big_enough
  % True: power
    False: round_up_to_power_of_rec (power | * factor) number factor
sqrt num: Int -> Int =
  # num >= 0 or panic("you can't take the sqrt of a negative number")
  sqrt_rec 0 num
sqrt_rec candidate: Int target: Int -> Int =
  next = candidate | + 1
  mul next next | compare target
  % Less: sqrt_rec next target
    Equal: next
    Greater: candidate
log_two value: Int -> Int =
  value | equals 1
  % True: 0
    False: log_two (value | div 2) | + 1
# lower_byte int: Int -> Byte = builtin_lower_byte int
equals a: Int b: Int -> Bool =
  builtin_compare_ints a b
  % Less: False
    Equal: True
    Greater: False

#fun parse_int(string: String): Maybe[Int] {
#  var num = 0
#  for char in string do {
#    if not({#0..=#9}.contains(char))
#    then return none[Int]()
#    num = num * 10 + {char - #0}.to_int()
#  }
#  some(num)
#}

#fun write[W](writer: W, int: Int) {
#  if int < 0
#  then writer."-{ {0 - int}.radix(10)}"
#  else writer."{int.radix(10)}"
#}
#fun radix(int: Int, radix: Int): RadixFormat { RadixFormat { radix, int } }
#struct RadixFormat { radix: Int, int: Int }
#fun write[W](writer: W, format: RadixFormat) {
#  var divisor = 1
#  loop {
#    if format.int / divisor < format.radix then break
#    divisor = divisor * format.radix
#  }
#  loop {
#    writer.write(
#      {format.int / divisor % format.radix}.lower_byte().digit_to_char())
#    if divisor == 1 then break
#    divisor = divisor / format.radix
#  }
#}
#fun write_debug[W](writer: W, int: Int) { writer."{int}" }

# Strings  

+ a: String b: String -> String = builtin_concat_strings a b

# Maybe  

Maybe t =
  | Some t
    None
unwrap maybe: (Maybe t) message: String -> t =
  maybe
  % Some t: t
    None: builtin_crash message
unwrap maybe: (Maybe t) -> t = maybe | unwrap "Called unwrap on None"

# List  

List t =
  | Empty
    More t (List t)
list a: t -> (List t) = More a Empty
list a: t b: t -> (List t) = More a (list b)
list a: t b: t c: t -> (List t) = More a (list b c)
len list: (List t) -> Int =
  list
  % Empty: 0
    More item rest: rest | len | + 1
is_empty list: (List t) -> Bool = list | len | equals 0
get_maybe list: (List t) index: Int -> (Maybe t) =
  list
  % Empty: None
    More item rest:
      index | equals 0
      % True: Some item
        False: rest | get_maybe (index | - 1)
get list: (List t) index: Int -> t =
  list | get_maybe index | unwrap "out of bounds"

####################### Actual program #######################

main a: Int -> Int =
  a | mod 2
  # list =
  #   equals 0 0
  #   % True: list True True True
  #     False: list False False
  # len list
