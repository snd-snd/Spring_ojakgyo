package com.ojakgyo.service;

import com.ojakgyo.domain.BoardInfoVO;
import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;

public interface BoardService {

	BoardInfoVO list(CriteriaVO criteria);
	BoardVO read(String groupCode, int bno);
	boolean register(BoardVO board);
	boolean modify(BoardVO board);
	boolean readCount(String groupCode, int bno);
	boolean remove(String groupCode, int bno);
	int totalCount(CriteriaVO criteria);
}
