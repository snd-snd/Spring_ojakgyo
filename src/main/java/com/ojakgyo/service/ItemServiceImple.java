package com.ojakgyo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ojakgyo.domain.ProcedureVO;
import com.ojakgyo.mapper.ItemMapper;


@Service
public class ItemServiceImple implements ItemService {

	@Autowired
	private ItemMapper mapper;
	
	// 관리자에게 그룹 생성을 요청하고 승인됐을 때 실행되는 프로시저
	@Override
	public ProcedureVO create_item(ProcedureVO procedure) {
		return mapper.create_item(procedure);
	}

	// 그룹을 제거할 때 실행되는 프로시저
	@Override
	public ProcedureVO remove_item(ProcedureVO procedure) {
		return mapper.remove_item(procedure);
	}
	
	// 그룹아이디로 사용할 아이디로 만들어진 테이블이 있는지 여부(없어야 함)
	@Override
	public boolean check_item(String groupCode) {
		return mapper.check_item(groupCode) == 0 ? true : false;
	}
}
