package com.ojakgyo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;

public interface BoardMapper {

	List<BoardVO> list(@Param("groupCode") String groupCode, @Param("criteria") CriteriaVO criteria);
	BoardVO read(@Param("groupCode") String groupCode, @Param("bno") int bno);
	boolean register(@Param("groupCode") String groupCode, @Param("board") BoardVO board);
	boolean modify(@Param("groupCode") String groupCode, @Param("board") BoardVO board);
	boolean readCount(@Param("groupCode") String groupCode, @Param("board") int bno);
	boolean remove(@Param("groupCode") String groupCode, @Param("bno") int bno);
	int totalCount(@Param("groupCode") String groupCode, @Param("criteria") CriteriaVO criteria);
	
	
	boolean readUp(@Param("groupCode") String groupCode, @Param("bno") int bno);	
	boolean likeUpDown(@Param("groupCode") String groupCode, @Param("bno") int bno, @Param("amount") int amount);
	boolean replyUpDown(@Param("groupCode") String groupCode, @Param("bno") int bno, @Param("amount") int amount);
	
}
