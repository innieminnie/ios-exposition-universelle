#### StackView의 Attributes
|Axis<br>(방향)|Alignment<br>(Y축정렬)|Distribution<br>(Arrange Views 의 분배)|Spacing<br>(Arrange Views 간 간격)|
|:-:|:-:|:-:|:-:|
|Horizontal<br>(수평)|Fill<br>(가능한 공간을 최대한 채운다)|Fill<br>(가능한 공간을 최대한 채운다)| 숫자 입력을 통해 설정한다.|
|Vertical<br>(수직)|Leading<br>(Leading쪽으로 정렬)|Fill Equally<br>(각각 동등한 영역을 갖는다)||
||Center<br>(가운데 정렬)|Fill Proportionally<br>(각 view의 intrinsic content size에 기초하여 비율에 따라 공간을 분배한다)||
||Trailing<br>(Trailing쪽으로 정렬)|Equal Spacing<br>(view 간의 간격을 동일하게 한다)||
|||Equal Centering<br>(각 view 의 축에 대한 center 들 간의 간격을 동일하게 한다.||

#### StackView 사용의 효과
<img src = "/image/Expo1900_ScrollViewStoryboard3.png" width = 500px>

[Auto Layout Guide StackView StackViews 관련부분 참고](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html)

위의 이미지 또는 진행한 프로젝트와 같이 UI 의 복잡성이 증가할수록 StackView를 통해 Arranged Subviews를 그룹핑하고 그룹 간의 제약조건만 설정해 줄 수 있음에 따라 제약관계를 간단히 할 수 있었습니다.

#### StackView 사용 시 유의점
여러 View들을 StackView 내부에 배치할 경우, View들이 StackView의 범위를 벗어날 수 있습니다. <br>각 View마다 <b>intrinsic content size</b>를 고려해주어야 하며, 제약조건 충돌이 발생하지 않게 <b>compression resistance priority, hugging priority</b> 를 조정해주어야합니다.
