package kr.happyjob.study.surveyMgt.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;

import com.fasterxml.jackson.databind.ObjectMapper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class DateAPI {
	/**
	 * 		국경일 정보조회:		getHoliDeInfo
	 * 		공휴일 정보조회:		getRestDeInfo
	 * 		기념일 정보조회:		getAnniversaryInfo
	 * 		24절기 정보조회:	get24DivisionsInfo
	 * 		잡절 정보조회:		getSundryDayInfo
	 * */
	
	// 제공받은 서비스키
	private static String secretKey = "Ans2m7PMmUcqziRVm6tqrPGnk4%2Ba%2BhPmaBeCZttXQ0GLUCRfLtmubGU7md2fqYi4eK8UKD4P0C%2Bo6fKZT8kUZg%3D%3D";
	
	// 국경일 정보조회
	public static Map<String, Object> holidayInfoAPI(String year, String month) throws IOException, ParseException {
		
		// URL을 만들기 위한 StringBulider
		StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?");
		
		// 서비스키 입력
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + secretKey);
        // 페이지 번호
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
        // 한 페이지 결과 수
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
        // 연
        urlBuilder.append("&" + URLEncoder.encode("solYear", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8"));
        // 월
        urlBuilder.append("&" + URLEncoder.encode("solMonth", "UTF-8") + "=" + URLEncoder.encode(month.length() == 1 ? "0" + month : month, "UTF-8")); 
        
        // json으로 요청
        urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
        
        
        // URL 객체 생성
        URL url = new URL(urlBuilder.toString());
        System.out.println("요청URL:: " + urlBuilder);
        
        // 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        // 통신을 위한 GET 메서드
        conn.setRequestMethod("GET");
        // 통신을 위한 Content type 설정
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code:: " + conn.getResponseCode());
        
        // 전달 받은 데이터를 BufferedReader 객체로 저장
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
        	rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
        	rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));        	
        }
        
        // 저장된 데이터를 줄 별로 읽어 StringBuilder 객체로 저장
        StringBuilder sb = new StringBuilder();
        String line;
        while((line = rd.readLine()) != null) {
        	sb.append(line);
        }
        
        // 객체 종료
        rd.close();
        conn.disconnect();
        
        // 전달 받은 데이터 확인
        System.out.println(sb.toString());
        //자바를 이용해 공공데이터 받아오는 방법 끝
        
//        // SPRING에서 MODEL에 데이터를 설정해주어 JSP로 넘기기 위한 방법
//        // 문자열 형태의 JSON을 파싱하기 위한 JSONPARSER 객체 생성
//        JSONPARSER PARSER = NEW JSONPARSER();
//        // 문자열을 JSON 형태로 JSONOBJECT 객체에 저장
//        JSONOBJECT OBJ = (JSONOBJECT)PARSER.PARSE(SB.TOSTRING());
//        // 필요한 리스트 데이터 부분만 가져와 JSONARRAY로 저장
//        JSONARRAY DATAARR = (JSONARRAY) OBJ.GET("DATA");
//        // MODEL에 담아준다
//        MODEL.ADDATTRIBUTE("DATA", DATAARR);
//        
        return str2Map(sb.toString());
		
	}
	
	/** 
	 * 	Json String을 Hashmap으로 반환
	 * 
	 * @param json
	 * @return
	 * */
	public static Map<String, Object> str2Map(String json) {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> map = null;
		
		try {
			map = mapper.readValue(json, Map.class);
			System.out.println("=================map: " + map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
}
