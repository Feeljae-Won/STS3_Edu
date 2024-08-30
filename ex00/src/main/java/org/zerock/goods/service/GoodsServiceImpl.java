package org.zerock.goods.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.goods.mapper.GoodsMapper;
import org.zerock.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("GoodsServiceImpl")
public class GoodsServiceImpl implements GoodsService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private GoodsMapper mapper;
	
	// 상품관리 리스트
	@Override
	public List<GoodsVO> list(PageObject pageObject) {
		log.info("list() 실행");
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	// 상품관리 글보기
	@Override
	public GoodsVO view(Long no, Long inc) {
		log.info("view() 실행");
		if(inc == 1) mapper.increase(no);
		return mapper.view(no);
	}
	
	// 상품관리 글등록
	// @Transactional - insert 2번이 성공해야 Commit 한다. 하나라도 오류가 나면 rollback이 된다.
	@Transactional 
	@Override
	public Integer write(GoodsVO vo) {
		
		Integer result = mapper.write(vo); // 글번호를 시퀀스에서 새로운 번호를 사용
		
//		log.info(vo);
//		mapper.writeTx(vo); // 위에서 사용한 No를 그대로 가져와서 사용 - PK 예외 발생
		
		return result;
	}
	
	// 상품관리 글수정
	@Override
	public Integer update(GoodsVO vo) {
//		log.info(vo);
		return mapper.update(vo);
	}
	
	// 상품관리 글 삭제
	@Override
	public Integer delete(GoodsVO vo) {
//		log.info(vo);
		return mapper.delete(vo);
	}
	
}
