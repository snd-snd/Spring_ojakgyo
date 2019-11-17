package com.ojakgyo.mapper;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.LikeVO;

public interface LikeMapper {

	int likeTotal(@Param("groupCode") String groupCode, @Param("bno") int bno);
	int likeCheck(LikeVO like);
	boolean action(LikeVO like);
	boolean cancel(LikeVO like);
	
}
