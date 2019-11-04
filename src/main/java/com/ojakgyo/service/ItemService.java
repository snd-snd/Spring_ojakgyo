package com.ojakgyo.service;

import com.ojakgyo.domain.ProcedureVO;

public interface ItemService {

	ProcedureVO create_item(ProcedureVO procedure);
	ProcedureVO remove_item(ProcedureVO procedure);
	boolean check_item(String groupCode);
}
