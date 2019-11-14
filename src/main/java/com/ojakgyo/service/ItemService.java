package com.ojakgyo.service;

import com.ojakgyo.domain.ProcedureVO;

public interface ItemService {

	void create_item(ProcedureVO procedure);
	void remove_item(ProcedureVO procedure);
	boolean check_item(String groupCode);
}
