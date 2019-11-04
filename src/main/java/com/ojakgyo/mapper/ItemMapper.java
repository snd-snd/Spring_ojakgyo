package com.ojakgyo.mapper;

import com.ojakgyo.domain.ProcedureVO;

public interface ItemMapper {

	ProcedureVO create_item(ProcedureVO procedure);
	ProcedureVO remove_item(ProcedureVO procedure);
	int check_item(String groupCode);
}
