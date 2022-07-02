# KOS

# ABOUT
  1. Python and Javascript syntax based
  2. Block based, meaning uses space to indetify different parts of code
  3. Scripted, meaning executes one command at a time
  4. Dynamic based meaning no type annotations needed
  5. Simple, because there are only few keywords
# VARIABLES
  ## Declarations
  To declare variables 
  ```
    name = 'Kostia'
    last = 'Ilnytskyi'
    num = 1
  ```
  All variables are global by default 
  
  To make variable local, use local keyword
  ```
    local country = 'New York' 
  ```
  To make variable constant, use const keyword
  ```
    const birthday = 'Jan 06 2006'
  ```
  They are intergers, strings,booleans, nils and lists
  ```
    list = [1,2,3,4,'Random Numbers']
    number = 1
    text = 'Hello World'
    asked = true
    answered = false
    nothing = nil
  ```
  ## Print and Input
  Use print keyword to print out text
  ```
    age = 16
    print 'I am ', age,' years old'
    ~Output: I am 16 years old
  ```
  Space is required after print keyword
  By default input returns string input
  ```
    ~Input: Hello World
    text = input('Type some Text')
    print text
    ~Output: Hello World
  ```
  To specify what kind of input you want you...
  ```
    number = input('Give number: '):int
    list = input('Give list: '):list
    asked = input('Give booleans: '):boolean
  ```
  If input is **specified** and for example, it is **specified** to interger and it is given an string it will repeat a question again, until it is given an interger as a input
  Also, you can specify an variable
  ```
    number1 = 21
    number2 = 69
    number3 = 420
    ~Input: number2
    choice = input('Give variable: '):var
    print choice 
    ~Output: 21
  ```
 ## Operators
   They are only four operators: +=, -=, *=, /=
   ```
     num = 5
     num += 2
     print num
     ~Output: 7
   ```
   Operators they just simplify an simple mathematical action 
   ```
   num = 5
   num = num + 2
   print num
   ~Output: 7
   ```
   ## Semicolons
   Like javascript it uses to separate statements/actions
   In this languages it uses to separate declarations and operators
   The main purpose of semicolons is to declare or operate in a single line
   ```
   num = 1; name = 'Kostia'; last = 'Ilnytskyi'
   num += 2; num -= 1
   print num 
   ~Output: 2
   ```
   **NOTE** semicolons are optional and they are only use in declaring variables or perform operation
   
   # BLOCKS
   Blocks in this coding language are if statements, for loop, while loops, functions and pages.
   they are saparated by four spaces or by tab like in Python
   ## If statements
   Inequalities: ==, !=, <=, >=, <, >
   if statement is used for conditional execution
   ```
   num1 = 5
   num2 = 1
   if num2 > num1
       print 'first'
   elif num2 < num1
       print 'second'
   else
       print 'third'
   ~Output: second
   ```
   **NOTE** to make executional lines which are: 'print first', 'print second', 'print third', you have to make 4 spaces or press tab
   You can use booleans
   ```
   asked = true
   if asked
       print 'asked is true'
   else
       print 'asked is false'
   ~Output: asked is true
   ```
   ## For loops
   For loops is used to repeat, a specific lines of code, a fixed number of timer
   As arguments you can put an string, number or list
   Like if statements it uses spaces to know which lines to execute
   ### For loops using strings
   ```
   name = 'Kostia' <- Note string has 6 characters
   for index, i in name  
       print index, i
   ~Output:
   1K
   2o
   3s
   4t
   5i
   6a
   ```
   index is a number that represents a number of how many times did for loop work for
   i is a temporary variable used to store a value 
   **NOTE** index is optional in for loops when using strings or list as a argument, when using interger you **CANNOT** use index   
  ```
   name = 'Kostia' 
   for i in name  
       print i
   ~Output:
   K
   o
   s
   t
   i
   a
  ```
   To use list as a argumnet
   ```
   names = ['Kostia', 'Lucy', 'Jeff', 'Alex']
   for _, i in names
       print _, i
   ~Output:
   1kostia
   2Lucy
   3Jeff
   4Alex
   ```
   ## While loops
   While loops are used to repeat specific number of lines, as long as condition is true
   Like for loops and if statements, it uses spaces to indentify executable lines
   ```
   asked = true
   while asked
       print 'asked true'
   ~Output: prints out 'asked true' forever
   ```
   **NOTE** if you made your statement true, like in a example on top, it makes code unsafe and repeats for ever press control c to stop your program. 
   Safe way to do it
   ```
   num = 0
   while num <= 20
       print num
       num += 1
   ~Output: prints out number 20 times
   ```
   ## Functions
   Function is a block of organized code that is used to perform a single task when it is called
   You declrare function by add fun keyword, following name of the function and arguments
   Arguments inside function are automatically delcared local
   Function use spaces to indentify which lines of code to execute
   ```
   fun add(num1, num2)
      print num1 + num2
   ~Output: nothing
   ```
   To call a function you use a name of the function and by putting some values in
   ```
   fun add(num1, num2)    <- num1 will be 1 and num2 will be 5
      print num1 + num2
   add(1, 5)              <-     1 and 5 are values
   ~Output: 6
   ```
   You can call functions as much as you want
   ## Pages
   If you have mutiple files and you want to use them together then use keyword use and following file that you desire
   **Main.txt**
   ``` 
   use 'add'
   print number
   ~Output: 12
   ```
   **Add.txt**
   ``` 
   number = 12
   ```
   The keyword use, what it does is when it is called, it reads the following file and goes throw the code and let the user to use variables and functions.
   
   
