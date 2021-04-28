# 만국박람회

> <br>만국박람회 소개 및 전시품 목록, 전시품 상세화면을 보여줍니다.<br><br>

---

## 주요 구현 사항

### 전반적 설계
![expo1900_diagram](/image/Expo1900_Diagram.png)

#### NavigationController의 활용
> <br>박람회 전체에 대한 정보 -> 해당 박람회에서 보여주는 전시품 목록 -> 전시품에 대한 각각의 구체적 정보 순으로 화면이 진행됩니다. 정보의 흐름이 화면이 진행될수록 더 구체화된다는 측면에서 NavigationController를 활용한 Present방식을 선택했습니다.<br><br>

#### Decodable 프로토콜 활용을 통한 JSON데이터와 Swift타입의 매칭
> <br>Asset의 items.json 파일에 담긴 데이터를 토대로 <b>ExpositionInformation</b> 타입과 <b>ExhibitionWork</b> 타입을 구성했습니다.<br><br>
Codable프로토콜 및 JSONDecoder에 대해 학습한 이후, 해당 프로젝트에선 encoding과정이 필요하지 않다고 생각되어 Codable프로토콜 대신 Decodable프로토콜 채택하여 decoding한 json데이터와 구현한 타입을 매칭시켰습니다.<br><br>


### 박람회소개
- 박람회 정보 제공<br>
![expo1900_mainview](/image/Expo1900_Mainview.gif)<br><br>
    - ScrollView를 활용하여 파싱해오는 데이터의 정보의 길이에 맞춰 모든 정보를 보여줄 수 있도록 합니다.

    - ScrollView 내의 여러 UIComponents들에 대해 StackView를 최대한 활용하여 오토레이아웃을 설정했습니다.

    - UITextLabel과 UITextView 내부의 텍스트 같은 경우, 기기의 사이즈 및 글씨 크기의 변동 시에도 유연하게 대처할 수 있게 DynamicType 카테고리의 Automatically Adjusts Fonts 을 활성화했습니다.

### 박람회의 전시품 소개
- 박람회의 전시품들에 대한 정보 제공<br>
![expo1900_exhibitionworklist](/image/Expo1900_ExhibitionWorkList.gif)<br><br>
    - TableView에 대한 전반적인 동작원리에 대해 학습하고 적용했습니다.

    - UITableViewCell의 재사용에 대해 이해하고 각 Cell의 UI요소들에 대한 오토레이아웃 적용을 통해 일정한 UIImageView 크기 비율 설정, 제목의 UILabel, 전시품의 요약내용의 UILabel은 3줄이하로 표시할 수 있도록 했습니다. 

### 전시품에 대한 상세설명
- 전시품에 대한 상세 정보 제공<br>
![expo1900_exhibitionworkdetail](/image/Expo1900_WorkDetail.gif)<br><br>

    - 이전 화면에서 특정 cell을 탭할 경우, 해당 전시품에 대한 상세내용을 보여줍니다. 
    - cell에 담긴 전시품에 대한 정보 전달을 위해 delegate 패턴을 활용했습니다.
---

## 트러블슈팅

### 1. ScrollView 및 StackView 다루기
> <b>박람회 안내 화면</b>과 <b>전시품상세정보 화면</b>에서 받아오는 json데이터의 텍스트길이나 이미지크기가 유동적이기에, 상황에 따라 데이터의 모든 정보를 표현하기 위해선 ScrollView를 통해 유저가 전체정보를 확인할 수 있어야한다고 생각했습니다.<br><br>
더불어 ScrollView 내에 정보를 표현하기 위한 UI요소들을 적합하게 배치하기 위해서 UI요소들이 많을수록 오토레이아웃 제약조건들이 복잡해지는 상황을 겪게 되었습니다.<br><br>
이를 해결하기 위해 ScrollView의 스크롤 방향을 고정시켜 수직스크롤만 가능하도록 설정하고 내부의 UI요소들을 StackView를 최대한 활용하여 제약조건을 보다 쉽게 조절할 수 있도록 했습니다. StackView의 활용을 통해 UI요소들을 Stack별로 분리해서 UI영역을 보다 구조적으로 설계할 수 있었고, StackView의 기능을 통해 조절해야하는 제약조건을 이전보다 간략화하는 효과를 가질 수 있었습니다.


### 2. 뷰컨트롤러 간의 정보전달 방식에 대해 performSegue와 delegate 방식 비교
> ExhibitionWorksListViewController -> ExhibitionWorkDetailViewController 로 화면 전환시, 전시품 정보 전달 방식에 대해 고민해보았습니다.<br><br>
<b>perfomeSegue 사용하는 경우,</b> 정보를 전달하는 뷰컨트롤러(ExhibitionWorkListViewController) 에서 정보를 전달받는 뷰컨트롤러(ExhibitionWorkDetailViewController)를 인지하고 있어야한다는 부분에 있어 결합도를 낮추는 방향에 대해 고민해보았습니다.<br><br>
이에 대해서 <b>Delegate패턴</b> 을 활용하는 방향으로 작성해보고 두 가지 방식에 대해 비교해보았습니다. 앞선 방식에 비해 Delegate를 설정하는 방식이 정보를 전달하는 뷰컨트롤러와 정보를 전달받는 뷰컨트롤러 간의 결합도를 낮출 수 있다고 생각했습니다. <br><br>
뷰 컨트롤러 간 정보 전달 방식에 대해 팀원과 함께 고민해봤습니다. 이번 프로젝트에서는 delegate를 활용하는 방식으로 코드를 작성했지만 정보 전달의 방향이 양방향으로 설정되어 주고받는 행위가 지속적으로 행해지는 경우에는 delegate패턴을, 해당 프로젝트와 같이 정보 전달 방향이 한쪽으로만 이어질 때 (테이블 뷰 셀을 탭할 경우, 해당 전시품에 대한 상세정보를 보여주는 상황)엔 delegate보다 performSegue가 더 적합할 수 있다고 의논해보았습니다.<br><br>
[해당내용관련 커밋](https://github.com/innieminnie/ios-exposition-universelle/commit/1e6f9272406499d6684b254e35fa8f22af14d6c6)


---

## 학습내용

- Codable 활용을 통한 JSON데이터와 매칭할 모델 타입 구현
https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types 학습해서 블로그포스팅하기
- 테이블뷰의 Delegate와 Data Source의 역할의 이해
- 주어진 JSON 데이터를 파싱하여 테이블뷰에 표시
- 내비게이션 컨트롤러를 통한 화면 전환
- 뷰컨트롤러 간의 정보 전달 방식 비교
- ScrollView