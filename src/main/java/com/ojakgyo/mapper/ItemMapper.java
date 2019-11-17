package com.ojakgyo.mapper;

import com.ojakgyo.domain.ItemVO;
import com.ojakgyo.domain.ProcedureVO;

public interface ItemMapper {

	void create_item(ProcedureVO procedure);
	void remove_item(ProcedureVO procedure);
	int check_item(String groupCode);
}
