<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<td colspan="12" class="text-left">

		<div class="p-3" >
			<button class="btn btn-sm btn-danger float-right">
				Delete
			</button>
			
			<img src="${info.photo }" class="" style="width:130px;">
			<i class="fa fa-plane" style="margin-left: 5px; margin-right:1px; color:#FF9933;"></i> 
				<span>편명 : <strong>${info.flightName }</strong></span>
			<button class="btn btn-sm btn-light">
				<i class="fa fa-pencil-square-o" style="font-size:15px;"></i>
			</button>
		
			<div class="p-3 mt-2" style="font-weight:border; background-color:#e4e4e4;border-radius:10px;">
				<h6 class="ml-3"> <Strong> * 항공사 기본 정보</Strong> </h6>
				<table class="table table-sm text-center align-text-middle table-borderless" 
					style=" table-layout: fixed; width: 100%;">
					<tr>
						<th >제조사</th>
						<th >모델</th>
						<th >소속</th>
						<th style="width:15px;">소속 번호</th>
						<th >국가(한글)</th>
						<th >국가(영문)</th>
						<th >국가코드</th>
					</tr>
					<tr >
						<td>${info.airplanePdt }</td>
						<td>${info.airplaneId }</td>
						<td>${info.airlineKor } (${info.airlineEng })</td>
						<td>${info.airlineNo }</td>
						<td>${info.countryKor }</td>
						<td>${info.countryEng }</td>
						<td>${info.countryCode }</td>
					</tr>
				</table>
				
				<h6 class="ml-3"> <Strong> * 경로 정보</Strong> </h6>
				<table class="table table-sm text-center align-text-middle table-borderless" 
					style="table-layout: fixed; width: 100%;">
					<tr>
						<th style="width:15px;">경로 번호</th>
						<th style="width:15px;">유형</th>
						<th >출발지</th>
						<th >출발 공항</th>
						<th >도착지</th>
						<th >도착 공항</th>
						<th >출발 시간</th>
						<th >도착 시간</th>
						<th >소요 시간</th>
						<th >거리</th>
					</tr>
					<tr >
						<td>${info.routeId }</td>
						<td>${(info.type == 'I')? '국제선' : '국내선' }</td>
						<td>${info.departure }</td>
						<td>${info.departureKor }</td>
						<td>${info.arrival }</td>
						<td>${info.arrivalKor }</td>
						<td>${info.departureTime }</td>
						<td>${info.arrivalTime }</td>
						<td>${info.duration }</td>
						<td>${info.distance } km</td>
					</tr>
				</table>
			</div>
		</div>
	</td>
