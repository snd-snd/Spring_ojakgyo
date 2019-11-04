package com.ojakgyo.mapper;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.LikeVO;

public interface LikeMapper {

	int likeTotal(@Param("groupCode") String groupCode, @Param("bno") int bno);
	int likeCheck(@Param("groupCode") String groupCode, @Param("like") LikeVO like);
	boolean action(@Param("groupCode") String groupCode, @Param("like") LikeVO like);
	boolean cancel(@Param("groupCode") String groupCode, @Param("like") LikeVO like);
	
}
