# 🌍 만국박람회 🌍

> <br>만국박람회 소개 및 전시품 목록, 전시품 상세화면을 보여줍니다.<br><br>

|박람회 정보|박람회 전시품 목록|전시품에 대한 상세 정보|
|-|-|-|
|<img src = "/image/Expo1900_Mainview.gif" width = 400px>|<img src = "/image/Expo1900_ExhibitionWorkList.gif" width = 400px>|<img src = "/image/Expo1900_WorkDetail.gif" width = 400px>|
## 주요 학습 내용 

- Codable 활용을 통한 JSON데이터와 매칭할 모델 타입 구현
    - XCTest를 활용하여 JSON데이터와 모델의 매칭 단위테스트 수행
- 테이블뷰의 Delegate와 Data Source의 역할의 이해
- 주어진 JSON 데이터를 파싱하여 테이블뷰에 표시
- 내비게이션 컨트롤러를 통한 화면 전환
    - Modal과 Navigation의 비교
- 뷰컨트롤러 간의 정보 전달 방식 비교
    - performSegue 와 delegate 설정의 비교
- ScrollView
---

## 전반적 설계
![expo1900_diagram](/image/Expo1900_Diagram.png)

---
## 화면전환
[H.I.G - Modality](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/modality/) & [H.I.G - Navigation](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/)을 참고하여 Modality와 Navigation에 대해 모색해보았습니다.<br>

### Modality 

<b>유저의 기존 context에서 분리시켜 "일시적으로" 새로운 content를 제시하고 해당 content에서 벗어날 수 있는 방식 또한 액션으로 나타내는 디자인 기술</b>
![expo1900_modal](/image/Expo1900_Modal.png)
<br>

- <b>iOS에서 제공하는 Modal 제시 방식</b>

    |Alert|Activity View|Action Sheet|
    |:---:|:---:|:---:|
    |![expo1900_alerts](/image/Expo1900_Alerts.png)|![expo1900_activitiviews](/image/Expo1900_ActivityViews.png)|![expo1900_actionsheets](/image/Expo1900_ActionSheets.png)|
    | UIAlertController | UIActivityViewController | UIAlertController.Style.actionSheet |
    | 앱이나 디바이스 상태에 관련된 중요한 정보 전달 및 피드백 요청| 현 context와 연관된 Activity(Copy, Favorite, Find etc.)가 실행될 수 있도록 제안할 경우 | 현 context에서 2가지 이상의 선택권을 제시할 경우|
    - Alerts
        - title, (optional) message, buttons, (optional) text fields 로 구성
        - message 제공 시, 짧고 완전한 문장을 제시한다.
        - 친근한 어조로 사용자에게 안내문을 알린다.
        - alert buttons에 대한 추가설명은 배제한다.
        - 일반적으로 두 개의 버튼을 사용한다(두 가지의 선택권 제공)
        - destructive(취소 또는 해제) 버튼은 명료하게 구분지어 나타낸다.
        - HomeScreen으로 이동 시, alerts 취소가 가능하도록 한다.
        
    - Activity Views
        - 기본 Activities 가 아닌 custom activities를 제시할 경우, '심플한 템플릿 이미지' (흑백 위주 /  적절한 투명도와 해상도 / drop shadow 추가안함) 로 디자인한다.
        - Activity명은 간단명료하게 한다.
        - 현 context와 적절하게 연관이 되는 activities인지 체크한다.
        - Action Button을 통해 Activity View에 접근할 수 있도록 한다.

    - Action Sheets
        - destructive (취소 또는 해제) 작업의 수행 가능성이 있을 경우 '확인' 절차를 요구하기 위해 사용한다.
        - destructive (취소 또는 해제) 작업을 수행하지 않는 방향을 고려하여 'Cancel'버튼을 제공한다.
        - destructive (취소 또는 해제) 작업에 대해 강조한다. (destructive action 관련 버튼의 색을 빨간색으로 설정한다.)
        - action sheet를 스크롤이 가능할 정도로 많은 옵션을 제시하는 것은 지양한다.(옵션의 수를 적게 한다.)
- <b>Custom Modal 제시 방식 (Presentation Style)</b>
    - Sheet<br><br>
        - '카드' 형식으로 화면을 표시한다.(화면을 부분적으로 커버한다.)
        - 밑에 깔려있는 전환 이전의 화면은 어둑하게 하여 Sheet로 위에 올라온 Modal 영역과 구분짓는다.
        - 전환 이전의 화면 일부를 사용자가 보여줌을 통해 사용자가 현재 보여지는 화면에서 되돌아갈 수 있음을 인지시킨다.
        - '카드' 화면을 내릴 때는 'Swipe down' 이나 'button tap' 방식을 가능케한다.
        - 카드를 popover 위에는 나타내지 않는다.
    <br>
    <p align = center><img src = "/image/Expo1900_Modal2.png" width = 400px></p>

    - Full Screen<br><br>
        - 화면 전면을 커버한다.
        - 영상, 사진 등 완전히 화면에 몰입해야 하는 상황에서 사용한다.
        - 버튼을 제공함을 통해 해당 화면에서 벗어날 수 있는 방안을 제시한다.
- <b> Modal Presentation 활용 경험</b><br><br>
    - 주어진 상황: 로그인 / 회원가입 두 개의 버튼이 있고 회원가입 버튼을 탭할 시, 회원가입 절차에 대한 과정을 진행한다.<br><br>
    - 구현 내용: 회원가입 flow를 진행하기 위해 로그인 / 회원가입 선택화면에서 화면전환을 Modal로 구현<br><br>

    ```swift
       @IBAction func touchUpSignUpButton(_ sender: Any) {
          guard let targetController = self.storyboard?.instantiateViewController(identifier: "FirstSignUpViewController") else {
              print("targetController 할당에 문제가 있습니다.")
              return
          }
          targetController.modalPresentationStyle = .fullScreen
          self.present(targetController, animated: true, completion: nil)
      }
    ```
   - 추가 설명: targetController 에 FirstSignUpViewController를 할당한 이후, modalPresentationStyle 설정 및 UIViewController의 present 메소드로 화면을 전환합니다.

### Navigation
<img src = "/image/Expo1900_Navigation.png" width = 600px><br>
이처럼 상황에 따라 다양한 navigation 형태를 취할 수 있습니다.<br> Navigation 은 modal과 달리 <b>진행의 '흐름'</b> 을 이어가는 형태이고, 화면의 전후관계가 명확하여 navigation을 통해 이전으로 되돌아가거나 흐름을 진행하는 것이 가능합니다.
- 명확한 경로를 제공한다. 사용자가 다음 지점을 어떻게 가야하는지 알 수 있어야한다.
- 흐름의 유동성에 맞는 터치 제스쳐를 사용한다.( 화면이동방향에 맞게 swipe )
- navigation bar에 data의 계층구조를 나타낼 수 있도록 한다. 계층구조 상 현재 위치를 navigation bar의 title에 나타낸다. back button을 통해 이전 위치로 돌아갈 수 있도록 한다.
- 카테고리 사이의 전환에 대해선 tab bar를 활용한다.
<br>

### UINavigationController
- <b>stack 구조</b>를 기반으로 하여 계층적 콘텐츠의 방향을 안내하는 용도의 container view controller
<img src = "/image/Expo1900_UINavigationController.png" width = 600px>
 새로운 ViewController를 <b>push</b> 하고, 이전 화면으로 돌아갈 경우 navigation bar의 back button을 탭함을 통해 현재 화면을 <b>pop</b> 합니다.

 Navigation Controller는 <b>navigation stack</b> 에서 child view controllers를 관리합니다.
 <b>root view controller</b>는 첫 화면, stack의 맨 아래에 있는 view controller를 의미합니다.

 <img src = "/image/Expo1900_UINavigationController2.png" width = 600px>


- 주요 프로퍼티/메서드 정리
    <b>Accessing Items on the Navigation Stack</b>

    |프로퍼티/메서드|타입|설명|
    |---|---|---|
    |var topViewController|UIViewController?|navigation stack의 맨 위에 있는 view controller|
    |var visibleViewController|UIViewController?|현재 보여지는 view와 관련된 view controller|
    |var viewControllers|[UIViewController]|navigation stack내의 view controllers|
    |func setViewControllers([UIViewController], animated: Bool)|-| navigation controller가 관리하는 viewControllers 교체|

    <b>Pushing and Popping Stack Items</b>

    |메서드|설명|
    |---|---|
    |func pushViewController(UIViewController, animated: Bool)|navigation stack에 viewcontroller push 및 디스플레이 교체|
    |func popViewController(animated: Bool) -> UIViewController?|navigation stack에서 viewcontroller pop 및 디스플레이 교체|
    |func popToRootViewController(animated: Bool) -> [UIViewController]?|navigation stack내의 root view controller 제외하고 모두 pop 및 디스플레이 교체|
    |func popToViewController(UIViewController, animated: Bool) -> [UIViewController]?| 특정 view controller가 navigation stack의 top이 될때까지 stack의 view controllers pop|
 
    [UINavigationController관련문서](https://developer.apple.com/documentation/uikit/uinavigationcontroller)

## NavigationController의 활용

> <br>박람회 전체에 대한 정보 -> 해당 박람회에서 보여주는 전시품 목록 -> 전시품에 대한 각각의 구체적 정보<br>
<b>정보의 흐름이 화면이 진행될수록 더 구체화된다</b>는 측면에서 화면전환방식으로 NavigationController를 활용했습니다.<br><br>

![expo1900_diagram](/image/Expo1900_UINavigationController3.png)

---
## Decodable 프로토콜 활용을 통한 JSON데이터와 Swift타입의 매칭
[Codable 학습 및 적용 블로그 작성내용 보러가기](https://innieminnie.github.io/codable/jsonencoder/jsondecoder/2021/05/11/Codable.html)

### Codable 프로토콜이 아닌 Decodable 프로토콜 채택
해당 프로젝트에선 encoding과정이 요구되지 않아, Decodable프로토콜을 채택하여 decoding한 JSON데이터와 구현한 타입을 매칭시켰습니다.

|JSON Data|매칭할 Swift Type|
|:-:|:-:|
|exposition_universelle_1900.json|ExpositionInformation|
|items.json|ExhibitionWork|
<br>

<b>ExpositionInformation</b>
|Key|Value|설명|
|:-:|:-:|:--:|
|title|String|박람회 이름|
|visitors|Int|박람회 방문자 수|
|location|String|박람회 장소|
|duration|String|박람회 개최 기간|
|description|String|박람회 소개|
<br>

<b>ExhibitionWork</b>
|Key|Value|설명|
|:-:|:-:|:-:|
|name|String|전시품 이름|
|image_name|String|전시품 이미지명|
|short_desc|String|전시품 요약 설명|
|desc|String|전시품 설멍|
<br>

### 🤔 JSON파일에 필요한 Key가 없는 경우?
<b>exposition_universelle_1900.json</b> 의 title을 삭제 후 단위테스트 수행

![expo1900_decoding_no_key](/image/Expo1900_Decoding_No_Key.png)

```swift
struct ExpositionInformation: Decodable {
    let title: String
    let visitors: Int
    let location: String
    let duration: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case title, visitors, location, duration, description
    }
    
    init(from decoder: Decoder) throws {
        let requiredInformations = try decoder.container(keyedBy: CodingKeys.self)
        title = (try requiredInformations.decode(String.self, forKey: .title))
        visitors = (try requiredInformations.decode(Int.self, forKey: .visitors))
        location = (try requiredInformations.decode(String.self, forKey: .location))
        duration = (try requiredInformations.decode(String.self, forKey: .duration))
        description = (try requiredInformations.decode(String.self, forKey: .description))
    }
}
```

```swift
import XCTest
@testable import Expo1900

class Expo1900Tests: XCTestCase {
    private var sut: ExpositionInformation!
    
    override func setUpWithError() throws {
        super.setUp()
        let data = try getData(from: "exposition_universelle_1900")
        sut = try JSONDecoder().decode(ExpositionInformation.self, from: data)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
}
extension XCTestCase {
    func getData(from JSONFileName: String) throws -> Data {
        guard let asset = NSDataAsset(name: JSONFileName) else {
            fatalError("Can not found data asset.")
        }
        
        return asset.data
    }
}
```

![expo1900_decoding_no_key_xctest](/image/Expo1900_Decoding_No_Key_XCTest.png)
- keyNotFound 관련 에러를 확인했습니다.

#### (1) try? 를 통해 key값을 발견하지 못할 경우 기본값을 넣어주었습니다.
```swift
init(from decoder: Decoder) throws {
        let requiredInformations = try decoder.container(keyedBy: CodingKeys.self)
        title = (try? requiredInformations.decode(String.self, forKey: .title)) ?? ""
        visitors = (try? requiredInformations.decode(Int.self, forKey: .visitors)) ?? 0
        location = (try? requiredInformations.decode(String.self, forKey: .location)) ?? ""
        duration = (try? requiredInformations.decode(String.self, forKey: .duration)) ?? ""
        description = (try? requiredInformations.decode(String.self, forKey: .description)) ?? ""
    }
```
![expo1900_decoding_no_key_xctest](/image/Expo1900_Decoding_No_Key_XCTest_2.png)
<br>

### 🤔 Value가 null인 경우엔 어떻게 처리해야할까?
<b>exposition_universelle_1900.json</b> 의 title을 null로 설정한 후 단위테스트 수행
![expo1900_decoding_no_value](/image/Expo1900_Decoding_Null_Value.png)

#### (2) 타입의 프로퍼티를 모두 옵셔널로 처리하여 nil값의 가능성을 열어주었습니다.
```swift
struct ExpositionInformation: Decodable {
    let title: String?
    let visitors: Int?
    let location: String?
    let duration: String?
    let description: String?
}
```
![expo1900_decoding_no_value_xctest](/image/Expo1900_Decoding_Null_Value_XCTest.png)

<b>디코딩 방식:</b>
 - <b>try? 를 통해 key값을 발견하지 못할 경우 기본값을 넣어주는 방식</b>을 선택했습니다. 

<b> 이유: </b> 
 타입을 생성하는 과정에서 nil 값의 가능성을 열어둘 경우
    -> 나중에 뷰에 해당 내용을 표시할 때 nil값의 처리과정이 요구된다.
 
 해당 방식보다 <b>타입의 프로퍼티에 전부 non-optional로 설정</b>하고 뷰에서 처리하기 이전에 디코딩 과정에서 값을 갖거나, 데이터의 값이 없는 경우 기본값으로 처리하여 <b>뷰에선 nil처리에 대해 대응할 필요가 없는 데이터를 대상으로 정보를 표현</b>할 수 있도록 하는 것이 더 적합하다고 판단하였습니다. 

---
## 박람회소개
- #### 박람회 정보 제공<br>
<img src = "/image/Expo1900_Mainview.gif" width = 300px height = 500px><br><br>
    - ScrollView를 활용하여 파싱해오는 데이터의 정보의 길이에 맞춰 모든 정보를 보여줄 수 있도록 합니다.

    - ScrollView 내의 여러 UIComponents들에 대해 StackView를 최대한 활용하여 오토레이아웃을 설정했습니다.

    - UITextLabel과 UITextView 내부의 텍스트 같은 경우, 기기의 사이즈 및 글씨 크기의 변동 시에도 유연하게 대처할 수 있게 DynamicType 카테고리의 Automatically Adjusts Fonts 을 활성화했습니다.

---
## 박람회의 전시품 소개
- ### 박람회의 전시품들에 대한 정보 제공<br>
<img src = "/image/Expo1900_ExhibitionWorkList.gif" width = 300px height = 500px><br><br>
    - TableView에 대한 전반적인 동작원리에 대해 학습하고 적용했습니다.

    - UITableViewCell의 재사용에 대해 이해하고 각 Cell의 UI요소들에 대한 오토레이아웃 적용을 통해 일정한 UIImageView 크기 비율 설정, 제목의 UILabel, 전시품의 요약내용의 UILabel은 3줄이하로 표시할 수 있도록 했습니다. 
---
## 전시품에 대한 상세설명
- ### 전시품에 대한 상세 정보 제공<br>
<img src = "/image/Expo1900_WorkDetail.gif" width = 300px height = 500px><br><br>

    - 이전 화면에서 특정 cell을 탭할 경우, 해당 전시품에 대한 상세내용을 보여줍니다. 
    - cell에 담긴 전시품에 대한 정보 전달을 위해 delegate 패턴을 활용했습니다.

### 🤔 뷰컨트롤러 간의 정보전달 방식에 있어 performSegue와 delegate 중 무엇이 더 적절할까?
> ExhibitionWorksListViewController -> ExhibitionWorkDetailViewController 로 화면 전환시, 전시품 정보 전달 방식에 대해 고민해보았습니다.<br><br>
<b>perfomeSegue 사용하는 경우,</b> 정보를 전달하는 뷰컨트롤러(ExhibitionWorkListViewController) 에서 정보를 전달받는 뷰컨트롤러(ExhibitionWorkDetailViewController)를 인지하고 있어야한다는 부분에 있어 결합도를 낮추는 방향에 대해 고민해보았습니다.<br><br>
이에 대해서 <b>Delegate패턴</b> 을 활용하는 방향으로 작성해보고 두 가지 방식에 대해 비교해보았습니다. 앞선 방식에 비해 Delegate를 설정하는 방식이 정보를 전달하는 뷰컨트롤러와 정보를 전달받는 뷰컨트롤러 간의 결합도를 낮출 수 있다고 생각했습니다. <br><br>
뷰 컨트롤러 간 정보 전달 방식에 대해 팀원과 함께 고민해봤습니다. 이번 프로젝트에서는 delegate를 활용하는 방식으로 코드를 작성했지만 정보 전달의 방향이 양방향으로 설정되어 주고받는 행위가 지속적으로 행해지는 경우에는 delegate패턴을, 해당 프로젝트와 같이 정보 전달 방향이 한쪽으로만 이어질 때 (테이블 뷰 셀을 탭할 경우, 해당 전시품에 대한 상세정보를 보여주는 상황)엔 delegate보다 performSegue가 더 적합할 수 있다고 의논해보았습니다.<br><br>
[해당내용관련 커밋](https://github.com/yagom-academy/ios-exposition-universelle/pull/20)

---

## 트러블슈팅

### 1. ScrollView 및 StackView 다루기
> <b>박람회 안내 화면</b>과 <b>전시품상세정보 화면</b>에서 받아오는 JSON데이터의 텍스트길이나 이미지크기가 유동적이기에, 상황에 따라 데이터의 모든 정보를 표현하기 위해선 ScrollView를 통해 유저가 전체정보를 확인할 수 있어야한다고 생각했습니다.<br><br>
더불어 ScrollView 내에 정보를 표현하기 위한 UI요소들을 적합하게 배치하기 위해서 UI요소들이 많을수록 오토레이아웃 제약조건들이 복잡해지는 상황을 겪게 되었습니다.<br><br>
이를 해결하기 위해 ScrollView의 스크롤 방향을 고정시켜 수직스크롤만 가능하도록 설정하고 내부의 UI요소들을 StackView를 최대한 활용하여 제약조건을 보다 쉽게 조절할 수 있도록 했습니다. StackView의 활용을 통해 UI요소들을 Stack별로 분리해서 UI영역을 보다 구조적으로 설계할 수 있었고, StackView의 기능을 통해 조절해야하는 제약조건을 이전보다 간략화하는 효과를 가질 수 있었습니다.