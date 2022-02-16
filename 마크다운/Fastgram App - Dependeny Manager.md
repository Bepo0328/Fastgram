Fastgram App - Dependeny Manager
========

# 0. 목차
	1. Fastgram
	2. Dependeny Manager
	3. iOS Dependency Manager
	4. Cocoapods 사용해보기

***
# 1. Fastgram
	- FeedViewController
	  - 이미지 및 동영상 표시
	  - 좋아요 및 더보기 액션

	- UserViewController
	  - 사용자 정보 화면 작업

***
# 2. Dependeny Manager
	- 모듈단위의 소프트웨어가 의존 관계를 가질때 이를 관리해준다.
	- A라는 모듈이 B를 참고하고, B라는 모듈이 C를 참고할때, C라는 모듈만 
	  설정해도 알아서 A와 B를 설치해준다.
    
***
# 3. iOS Dependency Manager
	- Cocoapods
	  - 가장 많이 사용되는 툴, Swift는 물론이고 Objective-C에서도 사용가능

	- Carthage
	  - 빌드가 빠르다는 장점이 있지만 지원하는 곳이 많지 않다.

	- Swift Package Manager
	  - Swift에서 공식적으로 지원하는 툴
    
***
# 4. Cocoapods 사용해보기
	- https://cocoapods.org/
	- https://www.github.com 에서 외부 라이브러리를 가져와 사용할 수 있다.
	- 적용하게 되면 Xcode의 워크스페이스(Workspace)를 생성하게 된다.

***
# 5. 왜 사용해야 하는가?
	- 인터넷 이미지를 UITableViewCell에 적용할 때 필요한 작업
	  - URL 및 해당 리소스가 이미지가 맞는지 검증
	  - 네트워크 모듈로 백그라운드에서 이미지 다운로드
	  - 셀 재사용시 동일한 URL 일 경우 기존에 다운 받은 이미지 사용
	  - 이미지가 다운로드 된 후 애니메이션 및 다운로드 되기 전 이미지 적용 
 
***
# 6. AlamofireImage
	- Alamofire 네트워크 모듈에 의존성을 가지고 있는 이미지 처리 라이브러리
	- 앞선 UITableViewCell의 이미지 적용을 코드 한줄로 해결
	- 많은 사람들이 사용함으로써, 수정과 개선이 활발하게 이루어짐