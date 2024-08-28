# 황동민 OpenAPIWeatherApp

프로젝트 설명

1. MVVM 패턴 이용
2. Almofire을 이용해 API 통신
3. SplashViewcontroller 첫진입후 MainViewConroller 진입(디폴트 위도 경도 넘겨주고 시작)
4. WeatherService 에서 Alamofire 통신 구현 
   # 파라미터
      let parameters: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "appid": OpenWeatherAPIkey.openWeatherKey,
            "units" : units,
            "cnt" : 35
        ]

   units -> mertic으로 넘겨줘 썹시 온도로 표시되게함
  cnt 35로 고정
6. MainViewModel 에서 호출 및 로직 구현
7  SearcVieController로 이동시 push로 이동
8. SearcVieController로에서 데이터 선택시 NotificationCenter을 이용해 위도 경도 를받아
   MainViewController에넘겨줌
9. reduced_citylist json 파싱 할시 데이터 양이 많아 페이징 처리 함 100개씩 호출

