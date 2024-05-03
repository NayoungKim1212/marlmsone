# LMS Project

## 1. 강의 목록
![image](https://github.com/NayoungKim1212/marlmsone/assets/132897437/734ec263-4785-4e31-89a7-c4f32a9289e3)

- JavaScript와 Jquery를 사용하여 강의 목록 리스트 불러오기 구현
  
    - A.JAX를 사용하여 컨트롤러 호출
      
    - 검색 조건(전체, 강의명, 강사명)을 구현하기 위해 Mapper에서 동적 쿼리를 사용해 조건 추가
      
    - NULL 값과 NOT NULL 값도 받아야 하기 때문에 INNER JOIN과 LEFT JOIN을 사용

- 과정 등록, 수정 및 삭제를 모달로 구현
  
    - action 값을 지정하여 등록, 수정, 삭제 구분

- 공통 코드에 있는 페이지네이션 코드를 사용하여 페이지네이션을 Jquery로 구현

### 과정 등록
![image](https://github.com/NayoungKim1212/marlmsone/assets/132897437/b345f774-c4e6-468b-8b28-5de499608ca5)

- 모달의 드롭다운 목록은 처음 페이지를 불러올 때 해당 리스트들도 같이 불러옴
