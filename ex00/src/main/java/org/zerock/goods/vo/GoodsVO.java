package org.zerock.goods.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class GoodsVO {

	private Long goods_no;
	private Integer cate_code1;
	private Integer cate_code2;
	private String cate_name;
	private String goods_name;
	private String detail_image_name; // 보기에 나타날 상세 설명 이미지
	private String content; // 보기에 나타날 상세 설명 텍스트
	private String company;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date product_date;
	private String image_name; // 리스트에 나타날 대표 이미지
	private Long hit;
	private Integer price; 
	
	private Integer discount; // 현재 가격에 대한 할인가
	private Integer discount_rate; // 현재 가격에 대한 할인율
	private Integer delivery_charge; // 배송료
	private Integer saved_rate; // 구매 시 적립율
	private Integer sale_price; // 현재 판매 가격
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sale_startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sale_endDate;
	
}
