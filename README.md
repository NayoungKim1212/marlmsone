# LMS Project

## 1. 강의 목록
![image](https://github.com/NayoungKim1212/marlmsone/assets/132897437/734ec263-4785-4e31-89a7-c4f32a9289e3)

- JavaScript와 Jquery를 사용하여 강의 목록 리스트 불러오기
  
    - A.JAX를 사용하여 컨트롤러 호출
      
    - 검색 조건을 구현하기 위해 Mapper에서 동적 쿼리를 사용해 조건 추가
      
    - NULL 값과 NOT NULL 값도 받아야 하기 때문에 INNER JOIN과 LEFT JOIN을 사용

- 과정 등록, 수정 및 삭제를 모달로 구현
  
    - action 값을 지정하여 등록, 수정, 삭제 구분

- 공통 코드에 있는 페이지네이션 코드를 사용하여 페이지네이션을 Jquery로 구현

### 과정 등록
![image](https://github.com/NayoungKim1212/marlmsone/assets/132897437/b345f774-c4e6-468b-8b28-5de499608ca5)

- 모달의 드롭다운 목록은 처음 페이지를 불러올 때 해당 리스트들도 같이 불러옴

## 2. 취업 관리
![image](https://github.com/NayoungKim1212/marlmsone/assets/132897437/c9fa437a-0529-4df4-93c7-6437be4a0511)

- JavaScript와 Jquery를 사용하여 취업한 학생들의 정보와 미취업한 학생들의 정보 불러오기
  
    - A.JAX를 사용하여 컨트롤러 호출

    - 검색 조건을 구현하기 위해 Mapper에서 동적 쿼리를 사용해 조건 추가
 
- 입사일 > 퇴사일 => 재직중, 입사일 < 퇴사일 => 퇴사

![image](https://github.com/NayoungKim1212/marlmsone/assets/132897437/5e6f9887-0315-4553-b72c-a7f4ac828551)

 - 학생 이름 클릭 시 학생에 대한 정보와 수강 내역을 불러옴

 - 현재 날짜 < 종강일 => 수강중, 현재 날짜 > 종강일 => 수강완료

![image](https://github.com/NayoungKim1212/marlmsone/assets/132897437/40b0b4bd-828b-4846-9657-5e2ce92d29df)

- 취업한 학생은 등록 버튼을 클릭해 취업 정보를 등록

- 등록 완료 시 학생 목록에서 취업 목록으로 이동

  
