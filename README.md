## 0. Prerequisite

```bash
brew install racket # install racket

raco pkg install sicp # install sicp dialect
raco pkg install racket-langserver # install lang server

racket -I sicp # to start scheme as interpreter mode
# or use editor me hlx
hx example.scm
```
## 1. Building Abstractions with Procedures
- [x] 1.1 The Elements of Programming
    > A powerful programming language is more than just a means for in-
    > structing a computer to perform tasks. The language also serves as a
    > framework within which we organize our ideas about processes.
    > Thus, any powerful programming language should be able to describe primitive data and
    > primitive procedures and should have methods for combining and abstracting procedures and data.
    - primitive expressions: 언어가 다루는 가장 단순한 개체들을 나타냄
    - means of combination: 더 단순한 것들로부터 복합 요소들을 만드는 방법
    - means of abstraction: 복합 요소들에 이름을 붙여서 하나의 단위로 다룰 수 있게 하는 방법
  - [x] 1.1.1 Expressions
  - [x] 1.1.2 Naming and the Environment
    > A critical aspect of a programming language is the means
    > it provides for using names to refer to computational objects.
    > We say that the name identifies a variable whose value is the object.

    ```lisp
      > (define pi 3.14159)
      > (define radius 10)
      > (define circumference (* 2 pi radius))
      > circumference
    ```
  - [x] 1.1.3 Evaluating Combinations
    > One of our goals in this chapter is to isolate issues about thinking procedurally. As a case in point, let us consider that, in evaluating combinations, the interpreter is itself following a procedure. To evaluate a combination, do the following:
    1. Evaluate the subexpressions of the combination.
    2. Apply the procedure that is the value of the leftmost subexpres-sion (the operator) to the arguments that are the values of the other subexpressions (the operands).
    > 값을 평가하는데 있어 재귀가 매우 자연스럽게 녹아있다. 복잡해질 수 있는 복합적인 연산을 재귀는 매우 단순하게 표현한다.
    > '값'을 평가하려면, '(서브)값'을 평가하세요, 그리고 operator를 oprands에 적용하세요
  - [x] 1.1.4 Compound Procedures
    - `(define (<name> <formal parameters>) <body>)`
    - The `<body>` is an expression that will yield the value of the procedure application when the formal parameters are replaced by the actual arguments to which the procedure is applied.
  - [x] 1.1.5 The Substitution Model for Procedure Application
    - applicative order : To apply a compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.
    > evaluate the arguments and then apply
    ```lisp
    (f 5)
    (sum-of-squares (+ a 1) (* a 2))
    (sum-of-squares (+ 5 1) (* 5 2))
    (+ (square 6) (square 10))
    (+ (* 6 6) (* 10 10))
    (+ 36 100)
    136
    ```
    - normal order : would not evaluate the operands until their values were needed. Instead it would first substitute operand expressions for parameters until it obtained an expression involving only primitive operators, and would then perform the evaluation
    > fully expand and then reduce
    ```lisp
    (f 5)
    (sum-of-squares (+ 5 1) (* 5 2))
    (+ (square (+ 5 1)) (square (* 5 2)))
    (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
    (+ (* 6 6) (* 10 10))
    (+ 36 100)
    ```
    > lisp 에서는 전자를 택한다. '평가'후 '치환'을 하는 것 만으로 (+ 5 1), (* 5 2)와 같은 계산의 횟수가 줄어든 것을 볼 수 있다.
  - [x] 1.1.6 Conditional Expressions and Predicates
    ```lisp
    (define (abs x)
      (cond ((> x 0) x)
            ((= x 0) 0)
            ((< x 0) (- x))))
    (define (abs2 x)
      (cond ((< x 0) (- x))
            (else x)))

    (define (abs3 x)
      (if (< x 0)
          (- x)
          x))
    ```
    ```lisp
    ; (if <predicate> <consequent> <alternative>)
    (and (> x 5) (< x 10))
    (define (>= x y)
      (or (> x y) (= x y)))
    (define (>= x y)
      (not (< x y)))
    ```
  - [x] 1.1.7 Example: Square Roots by Newton's Method
    - 함수와 절차의 차이는 사물의 속성을 기술하는 것과 일을 어떻게 하는지를 기술하는 것의 구별의 함의 이다.
    - 수학적 정의는 "무엇인지"를 말하지만, 컴퓨터 프로그램은 "어떻게 할지"를 명시해야 한다.
    - [newton 제곱근](./chapter01/newton_sqrt.scm) 을 보면, 루프 없이 재귀만으로 반복을 구현한다는것을 알려준다. 
  - [x] 1.1.8 Procedures as Black-Box Abstractions
    - procedure와 sub-procedure가 있을 때 sub-procedure는 blackbox여야 한다.
    - 위와 같은 상대적인 제약이 아니더라도 궁극적으로는 procedure의 내부 구현은 blackbox여야 한다.
    - 그러기 위해 procedure의 formal parameters는 body에 로컬로 바인딩 되어있다. (그 반대는 free variable)
    - 그리고 서브 프로시져를 노출 할 필요가 없다면, namespace의 혼란을 막기 위해 internal로 둘 수 있다.
    - 내부 절차들이 외부 절차의 매개변수나 변수에 접근할 수 있는 것은 렉시컬 스코프 규칙 때문이다. 이는 변수의 바인딩이 코드의 텍스트 구조에 의해 결정되어, 중첩된 절차가 자신을 둘러싼 환경의 변수들을 자유롭게 참조할 수 있게 한다
    - 자세한 예시 (scope)[./chapter01/scope.scm]
- [x] 1.2 Procedures and the Processes They Generate
  - A procedure is a pattern for the local evolution of a computational process. It specifies how each stage of the process is built upon the previous stage. We would like to be able to make statements about the overall, or global, behavior of a process whose local evolution has been specified by a procedure. This is very difficult to do in general, but we can at least try to describe some typical patterns of process evolution.
  - [x] 1.2.1 Linear Recursion and Iteration
    - (재귀의 방식 vs iter 방식)[./chapter01/factorial.scm]
    ```scheme
      ; This type of process, characterized by a chain of deferred operations, is called a recursive process.
      (factorial 6)
      (* 6 (factorial 5))
      (* 6 (* 5 (factorial 4)))
      (* 6 (* 5 (* 4 (factorial 3))))
      (* 6 (* 5 (* 4 (* 3 (factorial 2)))))
      (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
      (* 6 (* 5 (* 4 (* 3 (* 2 1)))))
      (* 6 (* 5 (* 4 (* 3 2))))
      (* 6 (* 5 (* 4 6)))
      (* 6 (* 5 24))
      (* 6 120)
      720
      ; iter
      (factorial 6)
      (fact-iter 1 1 6)
      (fact-iter 1 2 6)
      (fact-iter 2 3 6)
      (fact-iter 6 4 6)
      (fact-iter 24 5 6)
      (fact-iter 120 6 6)
      (fact-iter 720 7 6)
      720
    ```
    - 재귀와 같은 process는 인터프리터가 지연 평가될 operation들을 추적해야하고, 그 추적해야 하는 갯수는 해당 input이 n개라면 n번 늘어나기에 선형 재귀라고 이야기한다.
    - 반면 후자의 경우는 지금 단계의 지금 단계의 변수들만 추적하면 된다. 이러한 경우를 iterative process 라고 한다. (결과적으로 이터레이터에서는 process가 줄어들거나 늘어나지 않는다, 고정된 크기의 변수들과, 그 변수를 어떻게 업데이트 할지에 대한 룰, 종료와 관련된 조건들이 전부이다)
  - [x] 1.2.2 Tree Recursion
  - [x] 1.2.3 Orders of Growth
  - [ ] 1.2.4 Exponentiation
  - [ ] 1.2.5 Greatest Common Divisors
  - [ ] 1.2.6 Example: Testing for Primality
- [ ] 1.3 Formulating Abstractions with Higher-Order Procedures
  - [ ] 1.3.1 Procedures as Arguments
  - [ ] 1.3.2 Constructing Procedures Using lambda
  - [ ] 1.3.3 Procedures as General Methods
  - [ ] 1.3.4 Procedures as Returned Values

## 2. Building Abstractions with Data

- [ ] 2.1 Introduction to Data Abstraction
  - [ ] 2.1.1 Example: Arithmetic Operations for Rational Numbers
  - [ ] 2.1.2 Abstraction Barriers
  - [ ] 2.1.3 What Is Meant by Data?
  - [ ] 2.1.4 Extended Exercise: Interval Arithmetic
- [ ] 2.2 Hierarchical Data and the Closure Property
  - [ ] 2.2.1 Representing Sequences
  - [ ] 2.2.2 Hierarchical Structures
  - [ ] 2.2.3 Sequences as Conventional Interfaces
  - [ ] 2.2.4 Example: A Picture Language
- [ ] 2.3 Symbolic Data
  - [ ] 2.3.1 Quotation
  - [ ] 2.3.2 Example: Symbolic Differentiation
  - [ ] 2.3.3 Example: Representing Sets
  - [ ] 2.3.4 Example: Huffman Encoding Trees
- [ ] 2.4 Multiple Representations for Abstract Data
  - [ ] 2.4.1 Representations for Complex Numbers
  - [ ] 2.4.2 Tagged data
  - [ ] 2.4.3 Data-Directed Programming and Additivity
- [ ] 2.5 Systems with Generic Operations
  - [ ] 2.5.1 Generic Arithmetic Operations
  - [ ] 2.5.2 Combining Data of Different Types
  - [ ] 2.5.3 Example: Symbolic Algebra

## 3. Modularity, Objects, and State

- [ ] 3.1 Assignment and Local State
  - [ ] 3.1.1 Local State Variables
  - [ ] 3.1.2 The Benefits of Introducing Assignment
  - [ ] 3.1.3 The Costs of Introducing Assignment
- [ ] 3.2 The Environment Model of Evaluation
  - [ ] 3.2.1 The Rules for Evaluation
  - [ ] 3.2.2 Applying Simple Procedures
  - [ ] 3.2.3 Frames as the Repository of Local State
  - [ ] 3.2.4 Internal Definitions
- [ ] 3.3 Modeling with Mutable Data
  - [ ] 3.3.1 Mutable List Structure
  - [ ] 3.3.2 Representing Queues
  - [ ] 3.3.3 Representing Tables
  - [ ] 3.3.4 A Simulator for Digital Circuits
  - [ ] 3.3.5 Propagation of Constraints
- [ ] 3.4 Concurrency: Time Is of the Essence
  - [ ] 3.4.1 The Nature of Time in Concurrent Systems
  - [ ] 3.4.2 Mechanisms for Controlling Concurrency
- [ ] 3.5 Streams
  - [ ] 3.5.1 Streams Are Delayed Lists
  - [ ] 3.5.2 Infinite Streams
  - [ ] 3.5.3 Exploiting the Stream Paradigm
  - [ ] 3.5.4 Streams and Delayed Evaluation
  - [ ] 3.5.5 Modularity of Functional Programs and Modularity of Objects

## 4. Metalinguistic Abstraction

- [ ] 4.1 The Metacircular Evaluator
  - [ ] 4.1.1 The Core of the Evaluator
  - [ ] 4.1.2 Representing Expressions
  - [ ] 4.1.3 Evaluator Data Structures
  - [ ] 4.1.4 Running the Evaluator as a Program
  - [ ] 4.1.5 Data as Programs
  - [ ] 4.1.6 Internal Definitions
  - [ ] 4.1.7 Separating Syntactic Analysis from Execution
- [ ] 4.2 Variations on a Scheme — Lazy Evaluation
  - [ ] 4.2.1 Normal Order and Applicative Order
  - [ ] 4.2.2 An Interpreter with Lazy Evaluation
  - [ ] 4.2.3 Streams as Lazy Lists
- [ ] 4.3 Variations on a Scheme — Nondeterministic Computing
  - [ ] 4.3.1 Amb and Search
  - [ ] 4.3.2 Examples of Nondeterministic Programs
  - [ ] 4.3.3 Implementing the amb Evaluator
- [ ] 4.4 Logic Programming
  - [ ] 4.4.1 Deductive Information Retrieval
  - [ ] 4.4.2 How the Query System Works
  - [ ] 4.4.3 Is Logic Programming Mathematical Logic?
  - [ ] 4.4.4 Implementing the Query System
    - [ ] 4.4.4.1 The Driver Loop and Instantiation
    - [ ] 4.4.4.2 The Evaluator
    - [ ] 4.4.4.3 Finding Assertions by Pattern Matching
    - [ ] 4.4.4.4 Rules and Unification
    - [ ] 4.4.4.5 Maintaining the Data Base
    - [ ] 4.4.4.6 Stream Operations
    - [ ] 4.4.4.7 Query Syntax Procedures
    - [ ] 4.4.4.8 Frames and Bindings

## 5. Computing with Register Machines

- [ ] 5.1 Designing Register Machines
  - [ ] 5.1.1 A Language for Describing Register Machines
  - [ ] 5.1.2 Abstraction in Machine Design
  - [ ] 5.1.3 Subroutines
  - [ ] 5.1.4 Using a Stack to Implement Recursion
  - [ ] 5.1.5 Instruction Summary
- [ ] 5.2 A Register-Machine Simulator
  - [ ] 5.2.1 The Machine Model
  - [ ] 5.2.2 The Assembler
  - [ ] 5.2.3 Generating Execution Procedures for Instructions
  - [ ] 5.2.4 Monitoring Machine Performance
- [ ] 5.3 Storage Allocation and Garbage Collection
  - [ ] 5.3.1 Memory as Vectors
  - [ ] 5.3.2 Maintaining the Illusion of Infinite Memory
- [ ] 5.4 The Explicit-Control Evaluator
  - [ ] 5.4.1 The Core of the Explicit-Control Evaluator
  - [ ] 5.4.2 Sequence Evaluation and Tail Recursion
  - [ ] 5.4.3 Conditionals, Assignments, and Definitions
  - [ ] 5.4.4 Running the Evaluator
- [ ] 5.5 Compilation
  - [ ] 5.5.1 Structure of the Compiler
  - [ ] 5.5.2 Compiling Expressions
  - [ ] 5.5.3 Compiling Combinations
  - [ ] 5.5.4 Combining Instruction Sequences
  - [ ] 5.5.5 An Example of Compiled Code
  - [ ] 5.5.6 Lexical Addressing
  - [ ] 5.5.7 Interfacing Compiled Code to the Evaluator

---

