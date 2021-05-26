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
    - Sheet
        - '카드' 형식으로 화면을 표시한다.(화면을 부분적으로 커버한다.)
        - 밑에 깔려있는 전환 이전의 화면은 어둑하게 하여 Sheet로 위에 올라온 Modal 영역과 구분짓는다.
        - 전환 이전의 화면 일부를 사용자가 보여줌을 통해 사용자가 현재 보여지는 화면에서 되돌아갈 수 있음을 인지시킨다.
        - '카드' 화면을 내릴 때는 'Swipe down' 이나 'button tap' 방식을 가능케한다.
        - 카드를 popover 위에는 나타내지 않는다.
    <br>
    <p align = center><img src = "/image/Expo1900_Modal2.png" width = 400px></p>

    - Full Screen
        - 화면 전면을 커버한다.
        - 영상, 사진 등 완전히 화면에 몰입해야 하는 상황에서 사용한다.
        - 버튼을 제공함을 통해 해당 화면에서 벗어날 수 있는 방안을 제시한다.

- <b> Modal Presentation 활용 경험</b><br>
    - 주어진 상황: 로그인 / 회원가입 두 개의 버튼이 있고 회원가입 버튼을 탭할 시, 회원가입 절차에 대한 과정을 진행한다.<br>
    - 구현 내용: 회원가입 flow를 진행하기 위해 로그인 / 회원가입 선택화면에서 화면전환을 Modal로 구현<br>

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