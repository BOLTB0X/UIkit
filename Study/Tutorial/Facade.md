# Facade Design Pattern
> "건물의 정면"을 의미하는 단어로 어떤 소프트웨어의 다른 커다란 코드 부분에 대하여 간략화된 인터페이스를 제공해주는 디자인 패턴을 의미
> <br/>

이 패턴은 많은 수의 클래스로 작업할 때, 사용하기 복잡하거나 이해하기 어려울 때 많이 이용함
<br/>

<img src = "https://files.koenig.kodeco.com/uploads/2013/07/facade2-480x241.png">
<br/>

> Facade 패턴은 숨기고 있는 클래스의 인터페이스 및 구현에서 시스템을 사용하는 코드를 분리합니다.
> <br/>
> 또한 하위 시스템의 내부 작업에 대한 외부 코드의 종속성을 줄입니다. 
> <br/>
> 이것은 파사드 아래의 클래스가 변경될 가능성이 있는 경우에도 유용합니다. 
> <br/>
> 파사드 클래스는 장면 뒤에서 변경되는 동안 동일한 API를 유지할 수 있기 때문입니다.
> <br/>
> 예를 들어 백엔드 서비스를 교체하려는 날이 오면 API를 사용하는 코드를 변경할 필요 없이 Facade 내부의 코드만 변경하면 됩니다.
> <br/>

즉 퍼사드 Object는 바깥쪽의 코드가 라이브러리의 안쪽 코드에 의존하는 일을 감소시켜 주고, 복잡한 코드를 사용 할 수 있게 간단한 인터페이스를 제공
<br/>

## 코드(예시)

```swift
class SubsystemA {
    func getNames() -> [String] {
        return ["NameA1", "NameA2"]
    }
}

class SubsystemB {
    func getNames() -> [String] {
        return ["NameB1", "NameB2"]
    }
}

class Facade {
    let subsystemA: SubsystemA
    let subsystemB: SubsystemB

    init(subsystemA: SubsystemA, subsystemB: SubsystemB) {
        self.subsystemA = subsystemA
        self.subsystemB = subsystemB
    }

    func getAllNames() -> [String] {
        return subsystemA.getNames() + subsystemB.getNames()
    }
}
```

- Facade: 하위 시스템의 세부 사항에 신경 쓰지 않거나 서로 간의 상호 작용을 단순화하려는 경우 사용할 수 있는 상위 수준 인터페이스를 제공
<br/>
클래스 또는 구조체일 수 있음(단순화를 위해 예제에서는 클래스를 사용하고 있지만 시나리오에서 허용하는 경우 확실히 구조체일 수 있음).
<br/>

- Subsystems: 하위 시스템의 기능을 구현하고 Facade 유형에 대한 지식같은 딥한것 X
<br/> 
Facade 구성 요소와 마찬가지로 Class 또는 Struct 둘다 가능
<br/>

## 참고
https://betterprogramming.pub/design-patterns-in-swift-facade-a7303dc3d95b
