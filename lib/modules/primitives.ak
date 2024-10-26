use aiken/builtin
use aiken/crypto.{VerificationKeyHash}
use cardano/assets.{Lovelace}

test integer() {
  // let-bindings: https://aiken-lang.org/language-tour/variables-and-constants#variables--let-bindings
  let i: Int = 1
  let j = 2

  // thousand separator:
  let ada: Lovelace = 3_000_000

  and {
    // operators:
    i + j == 3,
    j - i == 1,
    i * j == 2,
    // division:
    j / i == 2,
    i / j == 0,
    ada / j == 1500000,
    ada / 7 == 428_571,
    // remainder:
    j % i == 0,
    i % j == 1,
    ada % j == 0,
    ada % 7 == 3,
    // comparison:
    i < j,
    j > i,
    i <= ada,
    ada >= j,
  }
}

test bytearray() {
  let a: ByteArray = "abcd"
  let b = "1234"

  let c = #"abcd"
  let d = #[0xab, 0xcd]

  // traces: https://aiken-lang.org/language-tour/troubleshooting#traces
  trace @"\"abcd\"": a
  trace @"#\"abcd\"": c, d

  let pkh: VerificationKeyHash =
    #"00000000000000000000000000000000000000000000000000000056"
  let not_pkh = "00000000000000000000000000000000000000000000000000000056"

  and {
    a != c,
    b == "1234",
    c == d,
    pkh != not_pkh,
  }
}

// ## String

/// function: https://aiken-lang.org/language-tour/functions
fn todo_fn() {
  todo @"TODO"
}

fn fail_fn() {
  fail @"ERROR"
}

test string() fail {
  let x = todo_fn()
  let y = fail_fn()

  trace @"LABEL": x, y
  True
}

// ## Bool

test boolean() {
  let y: Bool = True
  let n = False

  // anonymous-functions: https://aiken-lang.org/language-tour/functions#anonymous-functions
  let yes =
    fn() {
      trace @"YES"
      True
    }
  let no =
    fn() {
      trace @"NO"
      False
    }

  and {
    y,
    !n,
    y == !n,
    y != n,
    // short-circuit:
    y && True,
    True && True,
    // no() && yes(),
    n || True,
    True || False,
    yes() || no(),
    // or-block:
    or {
      y,
      n,
    },
  }
  // trace-if-false:
  // y?,
  // !n?,
  // (y == !n)?,
  // (y != n)?,
  // (yes()? || no()?)?,
  // or {
  //   yes()?,
  //   no()?,
  // }?,
}

// ## Tuple

test tuple() {
  let t2: (Int, Int) = (1, 2)
  let t3: (Int, ByteArray, Bool) = (3, "abc", True)
  let t4 = (False, "123", 4, #"56")

  // destructuring: https://aiken-lang.org/language-tour/custom-types#destructuring
  let (a, _) = t2
  let (_a, b, _c) = t3
  let (_1, _2, _3, d) = t4

  and {
    a == 1,
    b == "abc",
    d == #[0x56],
  }
}

// ## List

test list() {
  let ls: List<Int> = [1, 2, 3]
  let bs = ["abc", "def"]
  let os = []

  and {
    // spread-operator: https://aiken-lang.org/language-tour/custom-types#list
    // see also: https://aiken-lang.org/language-tour/custom-types#spread-operator
    [0, ..ls] == [0, 1, 2, 3],
    ["123", ..bs] == ["123", "abc", "def"],
    [True, ..os] == [True],
  }
  // [..ls, 4] == [1,2,3,4] // cannot spread a list at the front:
  // [..os] == []
}

// ## Option

/// custom types: https://aiken-lang.org/language-tour/custom-types
type Thing {
  Thing
}

test option() {
  let something: Option<Thing> = Some(Thing)
  let nothing = None

  let is_thing =
    when something is {
      Some(_) -> True
      None -> False
    }
  trace @"Is there something?": is_thing

  expect None = nothing
}

// ## Never and Void

test never_void() {
  and {
    // aiken/builtin: https://aiken-lang.github.io/prelude/aiken/builtin.html#choose_void
    builtin.choose_void(Never, True),
    builtin.choose_void(Void, True),
    builtin.choose_void(Thing, True),
  }
}

// ## Data

test data() {
  // upcasting: https://aiken-lang.org/language-tour/custom-types#upcasting
  let a: Data = 1
  let b: Data = "abc"
  let c: Data = True

  // downcasting: https://aiken-lang.org/language-tour/custom-types#downcasting
  expect i: Int = a
  expect s: ByteArray = b
  expect y: Bool = c

  and {
    i == 1,
    s == "abc",
    y,
  }
}
