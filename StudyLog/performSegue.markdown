#### Segue-Based Presentation
![Expo1900_perfomSegue1](/image/Expo1900_perfomSegue1.png)
```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?)
```
- segue.destination ( 새로운 뷰컨트롤러 ) 설정
- destination에 필요한 data 전달

```swift
func performSegue(withIdentifier identifier: String, 
           sender: Any?)
```
- identifier: storyboard file 의 수행할 segue identifier
- segue 수행 (화면이동)
<br>