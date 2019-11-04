package com.ojakgyo.service;

import com.ojakgyo.domain.BoardInfoVO;
import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;

public interface BoardService {

	BoardInfoVO list(String groupCode, CriteriaVO criteria);
	BoardVO read(String groupCode, int bno);
	boolean register(String groupCode, BoardVO board);
	boolean modify(String groupCode, BoardVO board);
	boolean readCount(String groupCode, int bno);
	boolean remove(String groupCode, int bno);
	int totalCount(String groupCode, CriteriaVO criteria);
}
