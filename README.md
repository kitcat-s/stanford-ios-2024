# 240604
## 오늘 한 일
- 강의 복습하기 ( 1 ~ 2 )
- Swift Tour 읽기 ( Generics )
- 알고리즘 문제 풀어보기

## 오늘 배운 것
- 함수에서 어떤 값이 반환되면 즉시 함수는 종료된다.
    ``` swift
    func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Element: Equatable, T.Element == U.Element
    {
        // 중복되는 값을 담을 배열 만들기. 이때 배열은 T 에 값을 담아야 하므로 T.Element 타입으로 선언하기
        var commonElements: [T.Element] = []
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    commonElements.append(lhsItem)
               // return 값이 결정되는 순간 함수가 종료되므로, 조건문이 참일 경우 중복 값 배열에 추가한 후 true 반환
                    return true
                }
            }
        }
        // 함수가 반복문 동안 다 돌았음에도 배열에 들어간 값이 없으면 false 반환
        return false
    }

    anyCommonElements([1, 2, 3], [3])
    ```


# 240531
## 오늘 한 일
- Swift Tour 읽기 ( Enumerations and Structures )
- 알고리즘 문제 풀어보기 

## 오늘 배운 것
- 콘솔에서 input 받기: readLine() 사용


# 240528
## 오늘 한 일
- Swift Tour 읽기 ( Object and classes ~ Enumerations and Structures )

## 오늘 배운 것
- What is to force unwrap an optional using `!` operator: 값이 optional 일 때, 검증 단계를 강제적으로 생략하기 위해 사용


# 240524
## 오늘 한 일
- Swift Tour 읽기

## 오늘 배운 것
- `map`을 사용할 때는 자동으로 루프가 돌아서 `for` 루프를 사용하지 않음

    ``` swift
    // map 사용 시
    var numbers = [20, 19, 7, 12]
    let modifiedNumbers = numbers.map { (number: Int) -> Int in
        return number % 2 == 0 ? number : 0
    }
    print(modifiedNumbers)
    ```
    
    ``` swift
    // for loop 사용 시
    var numbers = [20, 19, 7, 12]
    var modifiedNumbers: [Int] = []
    for number in numbers {
        if number % 2 != 0 {
            modifiedNumbers.append(0)
        } else {
            modifiedNumbers.append(number)
        }
    }
    print(modifiedNumbers)
    ```

# 240503
## 오늘 한 일
- 카드 컨텐츠를 `Array`화 하기
- 복붙 코드 ForEach로 대체하기
- 카드 기본 갯수 지정하기
- 카드 추가/제거 버튼 만들기
- 코드 개선하기 ( 쪼개기 & 함수화 )
- 그리드 적용하기

## 오늘 배운 것
- `Argument`를 부여할 때 순서를 지키기
- `ViewBuilder`
- `ViewBuilder` 안에서는 조건문, 리스트, 지역 변수만 사용 가능
- `ViewBuilder` 안에서는 `For`은 사용할 수 없고, `ForEach`문만 사용 가능
- Swift에서 숫자의 범위를 표기하는 방법 : 마지막 숫자 포함 시 `s…d`, 마지막 숫자 미포함 시 `s..<d`
- Implicit Return : 변수가 한 줄의 코드만을 담고 있을 때는 `return` 생략하기
- 코드는 12줄 미만으로 쪼개는 습관 만들기

# 240502

## 오늘 한 일
- Git 연동하기
- 카드 탭할 때 뒤집기

## 오늘 배운 것
- let & var : 각각 변하지 않는 변수와 변하는 변수를 지정 시 사용한다.
- view
>
> "A type that represents part of your app’s user interface and provides modifiers that you use to configure views." - Apple Developer Document
>
> 앱의 사용자 인터페이스를 의미하는 프로토콜로, 뷰를 개조할 수 있게 하는 modifier를 제공한다.
- 이벤트 핸들러 .onTapGesture
- struct : 객체나 함수를 담는 그릇! class와 비슷하지만 다르다. SwiftUI에서는 struct가 더 많이 사용된다고 한다.

# 240427 프로젝트 세팅
## 오늘 한 일
- 프로젝트 세팅하기
