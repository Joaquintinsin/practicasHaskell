data Person = Person {
    firstName :: String
  , lastName :: String
  , age :: Int
  , height :: Float
  , phoneNumber :: String
  , flavor :: String
} deriving (Show)

-- Getters
getFirstName :: Person -> String
getFirstName (Person { firstName = fn }) = fn

getLastName :: Person -> String
getLastName (Person { lastName = ln }) = ln

getAge :: Person -> Int
getAge (Person { age = a }) = a

getHeight :: Person -> Float
getHeight (Person { height = h }) = h

getPhoneNumber :: Person -> String
getPhoneNumber (Person { phoneNumber = pn }) = pn

getFlavor :: Person -> String
getFlavor (Person { flavor = f }) = f

-- Setters
setFirstName :: Person -> String -> Person
setFirstName (Person { lastName = ln, age = a, height = h, phoneNumber = pn, flavor = f }) newFirstName = Person { firstName = newFirstName, lastName = ln, age = a, height = h, phoneNumber = pn, flavor = f }

setLastName :: Person -> String -> Person
setLastName (Person { firstName = fn, age = a, height = h, phoneNumber = pn, flavor = f }) newLastName = Person { firstName = fn, lastName = newLastName, age = a, height = h, phoneNumber = pn, flavor = f }

setAge :: Person -> Int -> Person
setAge (Person { firstName = fn, lastName = ln, height = h, phoneNumber = pn, flavor = f }) newAge = Person { firstName = fn, lastName = ln, age = newAge, height = h, phoneNumber = pn, flavor = f }

setHeight :: Person -> Float -> Person
setHeight (Person { firstName = fn, lastName = ln, age = a, phoneNumber = pn, flavor = f }) newHeight = Person { firstName = fn, lastName = ln, age = a, height = newHeight, phoneNumber = pn, flavor = f }

setPhoneNumber :: Person -> String -> Person
setPhoneNumber (Person { firstName = fn, lastName = ln, age = a, height = h, flavor = f }) newPhoneNumber = Person { firstName = fn, lastName = ln, age = a, height = h, phoneNumber = newPhoneNumber, flavor = f }

setFlavor :: Person -> String -> Person
setFlavor (Person { firstName = fn, lastName = ln, age = a, height = h, phoneNumber = pn }) newFlavor = Person { firstName = fn, lastName = ln, age = a, height = h, phoneNumber = pn, flavor = newFlavor }
