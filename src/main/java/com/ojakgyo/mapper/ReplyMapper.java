package com.ojakgyo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyVO;

public interface ReplyMapper {

	List<ReplyVO> list(@Param("groupCode") String groupCode, @Param("criteria") CriteriaVO criteria, @Param("bno")  int bno);
	ReplyVO read(@Param("groupCode") String groupCode, @Param("rno") int rno);
	int totalCount(@Param("groupCode") String groupCode, @Param("bno") int bno);
	boolean register(ReplyVO reply);
	boolean modify(@Param("groupCode") String groupCode, @Param("reply") ReplyVO reply);
	boolean remove(@Param("groupCode") String groupCode, @Param("rno") int rno);
	
}
