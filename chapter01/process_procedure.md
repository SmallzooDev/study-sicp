# 프로세스 vs 절차의 구별

### 절차(Procedure) - "코드의 형태"
- 정적인 텍스트로 작성된 프로그램
- 구문적(syntactic) 관점
- "어떻게 작성했는가"

### 프로세스(Process) - "실행 패턴"
- 동적인 실행 시 메모리/시간 사용 방식
- 의미론적(semantic) 관점
- "어떻게 계산되는가"

[같은 Procedure를 가지고, 다른 Process가 생겨날 수 있다](./factorial.scm)
- 예를 들어 iter의 경우 프로그램이 중단되어도 바로 다시 이어서 진행 할 수 있다.
- 반면 recursive같은 경우는 'hidden'정보가 필요한데, 그 정보는 interpreter에 의해 유지되며, "지금 어디 process를 진행중이지" 와 같은 정보로 요약될 수 있다.

> 반복과 재귀를 대조할 때, recursive process의 개념과 recursive procedure의 개념을 혼동하지 않도록 주의해야 합니다. procedure를 recursive하다고 기술할 때, 우리는 procedure 정의가 (직접적으로든 간접적으로든) procedure 자체를 참조한다는 구문적 사실을 언급하는 것입니다. 하지만 process가 예를 들어 linearly recursive한 패턴을 따른다고 기술할 때, 우리는 procedure가 어떻게 작성되었는지의 구문이 아니라 process가 어떻게 진화하는지에 대해 말하는 것입니다. fact-iter와 같은 recursive procedure가 iterative process를 생성한다고 언급하는 것이 혼란스러워 보일 수 있습니다. 하지만 그 process는 정말로 iterative합니다: 그 상태가 세 개의 상태 변수로 완전히 포착되며, 인터프리터는 process를 실행하기 위해 단지 세 개의 변수만 추적하면 됩니다.

- 이부분이 헷갈리는 이유는 현대 언어들이, Procedure적으로 recursive하게 작성하면 Process도 무조건적으로 recursive하게 동작하기 때문이다.
- 실제 Process를 Iterative 하게 동작하게 하려면 do, while, loop와 같은 문법에 의존해야한다.
- 반면 Process도 Iterative하게 동작하는것을 tail-recursion이라고 하며, 이것을 지원하는건 함수형 언어의 주요 기능중 하나이다.

```c
// 이래도 스택은 쌓인다.
int fact_iter_c(int product, int counter, int max_count) {
    if (counter > max_count) 
        return product;
    return fact_iter_c(product * counter, counter + 1, max_count);
}
```
