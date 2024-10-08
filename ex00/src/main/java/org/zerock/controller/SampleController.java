package org.zerock.controller;

import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.TodoDTO;

import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

// 자동생성 @어노테이션
// @Controller - 동기식 , @RestController - 비동기식 : uri 
// @Service - 처리
// @Repository - 데이터 저장
// @~Advice - 예외 처리
@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

	@RequestMapping("") // /sample/ - 일때 들어온다.
	// return 이 없으면 (void) uri 정보를 jsp 정보로 사용
	// return 이 String이면 "redirect:" -> redirect 시킨다. 없으면 jsp로 forward 시킨다.
	public void basic()	 {
		
		log.info("basic ---------------------------");
		
	}
	
	// uri Mapping 이 GET과 POST 방식만 허용
	@RequestMapping(value= "/basic", method = {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		log.info("basic get/post --------------------------");
	}
	
	// GET 방식만 허용
	// value 속성 하나만 남으면 기본으로 데이터가 들어가는 속성이 된다. 생략 가능.
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get --------------------------");
	}
	
	// get 방식 매핑 - dto를 이용해서 데이터 받아오기
	@GetMapping("/ex01")
	// property로 넘어오는 데이터 받기 (setter 이름과 name 이 같으면 자동으로 받는다.)
	public String ex01(SampleDTO dto) {
		
		log.info("ex01().dto : " + dto);
		// /WEB-INF/view/ + sample/ex01 + .jsp
		return "sample/ex01";
	}
	
	// get 방식 매핑 - 파라미터를 변수 형식으로 데이터 받기
	@GetMapping("/ex02")
	// parameter 변수로 받기 - 변수명과 name이 같아야 한다. age가 없으면 오류가 난다.
	// age가 안들어 오면 기본값을 0 세팅
	public String ex02(String name, @RequestParam(defaultValue = "0", name = "age") int age) {
		
		log.info("ex02().name = " + name + ", age = " + age);
		
		return "ex02";
	}
	
	// get 방식 매핑 - 리스트, 배열 처리
	@GetMapping("/ex02List")
	// parameter 변수로 받기 - 아이디 여러개를 받아서 처리 - List / 배열
	public String ex02List(
			// List로 여러개의 데이터를 받을 때는 @RequestParam 이 꼭 필요하다. 없으면 안 받는다.
			// 배열로 여러개의 데이터를 받을 때는 @RequestParam 필요 없음. 
			@RequestParam ArrayList<String> ids, String[] names) {
		
		log.info("ex02List().ids = " + ids);
		log.info("ex02List().names = " + Arrays.toString(names));
		
		return "ex02List";
	}
	
	// get 방식 매핑 - 파라미터로 날짜 데이터 받기
	@GetMapping("/ex03")
	// parameter 변수로 날짜 데이터 받기. DTO에 @DateTimeFromat(patter = "yyyy-MM-dd hh:mm"
	public String ex03(TodoDTO dto) {
		
		log.info("ex03().dto = " + dto);
		
		return "ex03";
	}
	
	// get 방식 매핑 - 파라미터로 날짜 데이터 받기
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		
		log.info("ex06()");
		
		// DTO 에 @AllArgsConstructor 가 붙어 있으면 생성자에서 값을 전달 받는다.
		SampleDTO dto = new SampleDTO("홍길동", 10);
//		dto.setName("홍길동");
//		dto.setAge(10);
		
		return dto;
	}
	
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07() {
		
		log.info("/ex07 ---------------");
		
		String msg = "{\"name\":\"홍길동\"}";
		
		// 서버에서 보내는 데이터의 정보
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg, headers, HttpStatus.OK);
	}
	
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload -----------------");
		
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(@RequestParam ArrayList<MultipartFile> files) {
		
		log.info("/exUploadPost()");
		
		// 향상된 forEach
		for(MultipartFile file : files) {
			log.info("---------------------------------------");
			log.info("name : " + file.getOriginalFilename());
			log.info("size : " + file.getSize());
			// 파일 저장 객체 (코드 짜야 함.)
//			file.transferTo(null);
		};
		
		// 람다식
		files.forEach(file -> {
			log.info("---------------------------------------");
			log.info("name : " + file.getOriginalFilename());
			log.info("size : " + file.getSize());
		});
		
	}
	
	
	// 교재 방식의 파일 업로드
	@GetMapping("/exUpload2")
	public void exUpload2() {
		log.info("/exUpload2() -----------------");
		
	}
	
	@PostMapping("/exUploadPost2")
	public void exUploadPost2(@RequestParam ArrayList<MultipartFile> files, HttpServletRequest request) throws Exception {
		
		log.info("/exUploadPost2()");
		
		// 저장 위치
		String path = "/upload/image";
		
		// 향상된 forEach
		for(MultipartFile file : files) {
			log.info("---------------------------------------");
			log.info("name : " + file.getOriginalFilename());
			log.info("size : " + file.getSize());
			
			// 파일 업로드 :  저장 객체 (코드 짜야 함.)
			FileUtil.upload(path, file, request);
			
			// 실제 저장 위치
			// D:\\Feeljae\workspace\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\ex00\\upload\\image
			
			
		}; // end of for
	}
	
}
